{-# LANGUAGE OverloadedStrings #-}

module Builder where

import qualified Data.MultiMap          as MultiMap
import           Database.SQLite.Simple
import           System.Environment     (getEnv)
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
    writeFile (home ++ "/feedreader-export.opml") opml_str

buildOPML :: [Feed] -> OPML
buildOPML feeds =
    OPML "2.0" [] buildHead (buildBody feeds) []

buildHead :: OPMLHead
buildHead = OPMLHead "Feedreader RSS Export" [attrs] Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing []
    where
    attrs = xmlAttr "title" "Feedreader"

buildBody :: [Feed] -> [Outline]
buildBody feeds =
    let
        datas =  concatMap  (\feed -> [(category feed, feed)]) feeds
        mmap  = MultiMap.assocs $ MultiMap.fromList datas
    in
        fmap (\(key, values) -> buildElement' key values) mmap

buildElement' :: Category -> [Feed] -> Outline
buildElement' cat feeds =
    let
        children = buildBody feeds
    in
        Outline cat Nothing Nothing Nothing Nothing [] children []


-- Legacy function that doesn't handle categories but left here
-- for people to use it in their own project.
-- buildBody' :: [Feed] -> [Outline]
-- buildBody' feeds = map buildElement feeds

buildElement :: Feed -> Outline
buildElement feed =
    let
        txt      = name feed
        type'    = Just "rss"
        html_url = xmlAttr "htmlUrl" (htmlURL feed)
        xml_url  =  xmlAttr "xmlUrl" (xmlURL feed)
    in
        Outline txt type' Nothing Nothing Nothing [html_url, xml_url] [] []
