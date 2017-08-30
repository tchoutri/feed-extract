{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Builder where

import           Control.Exception      (SomeException, try)
import qualified Data.MultiMap          as MultiMap
import           Database.SQLite.Simple
import           System.Environment     (getEnv)
-- import           System.Exit            (die)
import           Text.OPML.Export
import           Text.OPML.Syntax
import           Text.OPML.Writer
import           Types


getFeeds :: FilePath -> IO [Feed]
getFeeds path = do
    conn <- open path
    query_ conn "SELECT name, url, xmlURL, title FROM feeds INNER JOIN categories ON feeds.category_id == categories.categorieID" :: IO [Feed]

export :: [Feed] -> IO ()
export feeds = do
    home <- getEnv "HOME"
    let opml_str = serializeOPML $ buildOPML feeds
    let savePath = home ++ "/feedreader-export.opml"

    -- print opml_str

    -- die "ugh"
    result <- try (writeFile savePath opml_str)
    case result of
        Right _  -> putStrLn $ "[+] Feeds sucessfully exported to " ++ savePath
        Left (ex :: SomeException) -> do
            putStrLn "[!] Hmm, something not good at all happened when the file was being written."

buildOPML :: [Feed] -> OPML
buildOPML feeds =
    OPML "2.0" [] buildHead (buildBody' feeds) []

buildHead :: OPMLHead
buildHead = OPMLHead "Feedreader RSS Export" [attrs] Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing []
    where
    attrs = xmlAttr "title" "Feedreader"

buildBody' :: [Feed] -> [Outline]
buildBody' feeds = do
    let datas =  concatMap  (\feed -> [(category feed, feed)]) feeds
    let mmap  = MultiMap.assocs $ MultiMap.fromList datas

    fmap (\(key, values) -> buildElement' key values) mmap

buildBody :: [Feed] -> [Outline]
buildBody feeds = map buildElement feeds

buildElement' :: Category -> [Feed] -> Outline
buildElement' cat feeds =
    let
        children = buildBody feeds
    in
        Outline cat Nothing Nothing Nothing Nothing [] children []

buildElement :: Feed -> Outline
buildElement feed =
    let
        txt      = name feed
        type'    = Just "rss"
        html_url = xmlAttr "htmlUrl" (htmlURL feed)
        xml_url  =  xmlAttr "xmlUrl" (xmlURL feed)
    in
        Outline txt type' Nothing Nothing Nothing [html_url, xml_url] [] []
