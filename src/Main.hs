import           Builder
import           System.Directory   (doesFileExist)
import           System.Environment

main :: IO ()
main = do
    args <- getArgs
    case args of
        []              -> getStdInstead
        ("-h":_)        -> help
        ("--help":_)    -> help
        ("-v":_)        -> version
        ("--version":_) -> version
        (path:_) -> do
            doesIt <- doesFileExist path
            if doesIt then
                processArgs args
                putStrLn "[+] Feeds sucessfully exported to ~/feedreader-export.opml"
            else
                putStrLn "[!] Nah, you really need to give a *real* path :/"

help :: IO String
help = putStrLn "Usage: feed-extract PATH_TO_DATABASE"

version :: IO String
version = putStrLn "Feed-extract v0.0.2"

getStdInstead :: IO String
getStdInstead = do
    args <- getLine
    case args of
        [] ->
            putStrLn "[!] You must specify the database's file."
            putStrLn "[!] It is usually located at ~/.local/share/feedreader/data/"
        args ->
            processArgs args


processArgs :: [String] -> IO ()
processArgs (path:args) = do
    feeds <- getFeeds path
    export feeds
    putStrLn "[+] Feeds sucessfully exported to ~/feedreader-export.opml"
