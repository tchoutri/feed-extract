import           Builder
import           System.Directory   (doesFileExist)
import           System.Environment

main :: IO ()
main = do
    args <- getArgs
    case args of
        [] -> do
            putStrLn "[!] You must specify the database's file."
            putStrLn "[!] It is usually located at ~/.local/share/feedreader/data/"
        ("-h":_)        -> help
        ("--help":_)    -> help
        ("-v":_)        -> version
        ("--version":_) -> version
        (path:_) -> do
            doesIt <- doesFileExist path
            if doesIt then
                do
                feeds <- getFeeds path
                export feeds
                putStrLn "[+] Feeds sucessfully exported to ~/feedreader-export.opml"
            else
                do
                putStrLn "[!] Nah, you really need to give a *real* path :/"

help :: IO ()
help = putStrLn "Usage: feed-extract PATH_TO_DATABASE"

version :: IO ()
version = putStrLn "Feed-extract v0.0.2"
