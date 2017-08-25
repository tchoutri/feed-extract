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
