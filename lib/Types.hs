{-# LANGUAGE OverloadedStrings #-}

module Types where

import           Database.SQLite.Simple

type Category = String

data Feed = Feed { name     :: String
                 , htmlURL  :: String
                 , xmlURL   :: String
                 , category :: Category
                 }
            deriving (Show)

instance FromRow Feed where
    fromRow = Feed <$> field
                   <*> field
                   <*> field
                   <*> field
