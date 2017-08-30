import           Builder
import           System.Directory   (doesFileExist)
import           System.Environment
import qualified Version            as Version

main :: IO ()
main = do
    args <- getArgs
    case args of
        []              -> putStrLn Version.help
        ("-":_)         -> getStdInstead
        ("-h":_)        -> putStrLn Version.help
        ("--help":_)    -> putStrLn Version.help
        ("-v":_)        -> putStrLn Version.num
        ("--version":_) -> putStrLn Version.num
        (path:_) -> do
            doesIt <- doesFileExist path
            if doesIt then do
                processArgs args
            else
                putStrLn "[!] Nah, you really need to give a *real* path :/"


getStdInstead :: IO ()
getStdInstead = do
    args <- getLine
    case args of
        [] -> do
            putStrLn "[!] You must specify the database's file."
            putStrLn "[!] It is usually located at ~/.local/share/feedreader/data/"
        args ->
            processArgs' args


processArgs :: [String] -> IO ()
processArgs (path:_) = do
    feeds <- getFeeds path
    export feeds
    putStrLn "[+] Feeds sucessfully exported to ~/feedreader-export.opml"

processArgs' :: String -> IO ()
processArgs' path =
    processArgs [path]

