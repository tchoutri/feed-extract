{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

module Version where

import           Data.String.Here
import           Data.Version       (showVersion)
import           Paths_feed_extract (version)


num :: String
num = "feed-extract " ++ (showVersion version)

help :: String
help = [i|Usage: [OPTION] [DATABASE PATH]

    You must give a path to FeedReader's SQLite3 database.
    The OPML output will be written in ~/feedreader-export.opml

    The available options are the following:
        • - :           Read the database path from standard input (useful for shell pipelines)
        • -h|--help:    Print this help message
        • -v|--version: Display the version number

    Any issue? Open one at https://github.com/tchoutri/feed-extract/issues/new|]

