import           Builder
import           System.Environment

main :: IO ()
main = do
    args <- getArgs
    case args of
        [] -> do
            putStrLn "[!] You must specify the database's file."
            putStrLn "[!] It is usually located at ~/.local/share/feedreader/data/"
        (path:_) -> do
            feeds <- getFeeds path
            export feeds
            putStrLn "[+] Feeds sucessfully exported to ~/feedreader-export.opml"
