#!/bin/zsh
# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locat
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-n

brew update;
brew install python;
brew install git;
brew install macvim;
brew install ag;
brew install pick;
brew install tree;
brew install gradle;
brew install maven;
brew install colordiff;
brew install tig;
brew install jq jp fx;
brew install bitwise;
brew install wget;
brew install bat bmon htop nmap;
brew install dark-mode ack midnight-commander htop wget geoip watch awscli calc jq lftp links lynx ncdu nmap tmux tree unrar vimpager;
brew install cask;

brew install git-lfs
brew install gs
brew install imagemagick --with-webp
brew install lua
brew install lynx
brew install p7zip
brew install pigz
brew install pv
brew install rename
brew install rlwrap
brew install ssh-copy-id
brew install tree
brew install vbindiff
brew install zopfli

# Install some CTF tools; see https://github.com/ctfs/write-ups.
brew install aircrack-ng
brew install bfg
brew install binutils
brew install binwalk
brew install cifer
brew install dex2jar
brew install dns2tcp
brew install fcrackzip
brew install foremost
brew install hashpump
brew install hydra
brew install john
brew install knock
brew install netpbm
brew install nmap
brew install pngcheck
brew install socat
brew install sqlmap
brew install tcpflow
brew install tcpreplay
brew install tcptrace
brew install ucspi-tcp # `tcpserver` etc.
brew install xpdf
brew install xz

brew cask install firefox
brew cask install kdiff3
brew cask install diffmerge
brew cask install visualvm

# Remove outdated versions from the cellar.
brew cleanup
