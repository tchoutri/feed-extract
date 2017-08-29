# feed-extract

This is my Haskell week-end project to help with [the lack of "Export" feature](https://github.com/jangernert/FeedReader/issues/334) in [FeedReader](https://jangernert.github.io/FeedReader/)

## Install

### Manual install (recommended for bleeding-edge patches)

You'll need [Stack](https://haskellstack.org).

run `stack install` in the project directory. The binary will be copied to `~/.local/bin`.  
You might want to run `stack install --ghc-options=-dynamic` in order to reduce the size of the binary (4,1M → 20Ko).

### Releases

For the moment, releases are hosted on the GitHub platform. They consist of a Zip archive with the README, the LICENSE file and the binary, whose Haskell
libraries are bundled in (but the C libraries are still dynamically linked (for now)).  
The releases might not be as up-to-date as the `master` branch, though.

## Usage

`feed-extract ~/.local/share/feedreader/data/feedreader-04.db` or every other location where your db might be.

## Uninstall

As Stack does not keep trace of the installed objects on the filesystem, it does not provide an `uninstall` sub-command.  
But since `feed-extract` only uses itself, you can safely delete the binary from your filesystem.

## ROADMAP

- [x] Preserve categories
  - [ ] Get rid of the multimap

## LICENSE

This software is licenced under the [MIT](LICENSE.md) license

