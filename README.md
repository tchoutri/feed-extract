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

## Usage

`feed-extract ~/.local/share/feedreader/data/feedreader-04.db` or every other location where your db might be.

## ROADMAP

- [ ] Preserve categories

## LICENSE

This software is licenced under the [MIT](LICENSE.md) license

