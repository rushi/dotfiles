# Dotfiles

Rushi's OS X dotfiles.

## Why is this a git repo?

To version and maintain the history of my dotfiles. It also serves as a backup and allows me to revert to older versions in case of errors

[dotfiles]: https://github.com/rushi/dotfiles/blob/master/bin/dotfiles
[bin]: https://github.com/rushi/dotfiles/tree/master/bin

## Installation
Notes:

* You need to be an administrator (for `sudo`).
* You need to have installed [XCode Command Line Tools](https://developer.apple.com/downloads/index.action?=command%20line%20tools), which are available as a separate, optional (and _much smaller_) download from XCode.

```sh
bash -c "$(curl -fsSl https://raw.github.com/rushi/dotfiles/master/install.sh)"
```

## The "init" step
These things will be installed, but _only_ if they aren't already.

* Homebrew
  * git
  * mercurial
  * tree
  * sl
  * lesspipe
  * nmap
  * git-extras
  * htop-osx
  * apple-gcc42 (via [homebrew-dupes](https://github.com/Homebrew/homebrew-dupes/blob/master/apple-gcc42.rb))
  * several other libraries

## The ~/ "copy" step
Any file in the `copy` subdirectory will be copied into `~/`. Any file that _needs_ to be modified with personal information (like [.gitconfig](https://github.com/rushi/dotfiles/blob/master/copy/.gitconfig) which contains an email address and private key) should be _copied_ into `~/`. Because the file you'll be editing is no longer in `~/.dotfiles`, it's less likely to be accidentally committed into your public dotfiles repo.

## The ~/ "link" step
Any file in the `link` subdirectory gets symbolically linked with `ln -s` into `~/`. Edit these, and you change the file in the repo. Don't link files containing sensitive data, or you might accidentally commit that data!

## Aliases and Functions
Add your aliases, functions, settings, etc into one of the files in the `source` subdirectory, or add a new file. They're all automatically sourced when a new shell is opened. Take a look, I have [a lot of aliases and functions](https://github.com/rushi/dotfiles/tree/master/source).

## Scripts
In addition to the aforementioned [dotfiles][dotfiles] script, there are a few other [bash scripts][bin]. This includes [ack](https://github.com/petdance/ack), which is a [git submodule](https://github.com/rushi/dotfiles/tree/master/libs).

* [dotfiles][dotfiles] - (re)initialize dotfiles. It might ask for your password (for `sudo`).
* [src](https://github.com/rushi/dotfiles/blob/master/link/.zshrc#L53-70) - (re)source all files in `source` directory
* Look through the [bin][bin] subdirectory for a few more.


## Inspiration

* <https://github.com/cowboy/dotfiles>
* <https://github.com/gf3/dotfiles>
* <https://github.com/mathiasbynens/dotfiles>

(and 10+ years of accumulated crap)

## License

Copyright (c) 2012 "Cowboy" Ben Alman
Licensed under the MIT license.
<http://benalman.com/about/license/>

Extended for Personal use by Rushi Vishavadia.
<http://rushi.vishavadia.com/>
