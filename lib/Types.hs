{-# LANGUAGE OverloadedStrings #-}

module Types where

import           Database.SQLite.Simple

data Feed = Feed { name     :: String
                 , htmlURL  :: String
                 , xmlURL   :: String
                 , category :: String
                 }
            deriving (Show)

instance FromRow Feed where
    fromRow = Feed <$> field
                   <*> field
                   <*> field
                   <*> field
