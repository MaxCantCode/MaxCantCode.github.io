#!/bin/sh

# gimme free sudo
# %admin		ALL = (ALL) NOPASSWD: ALL
# %admin		ALL = (ALL) ALL, NOPASSWD: /usr/sbin/visudo, /usr/sbin/vipw

if [ ! -f ~/bin/micromamba ]; then
    curl -Ls https://micro.mamba.pm/api/micromamba/osx-64/latest | tar -xvj bin/micromamba
    mv bin ~
fi
mkdir ~/micromamba
zsh -ilc 'micromamba install -yq ansible cmake pandoc hy'

~/micromamba/bin/python -m pip install pipx
~/micromamba/bin/hy2py ~/.config/qutebrowser/config.hy > ~/.config/qutebrowser/config.py

zero apply-defaults

rm -r ~/{.emacs.d,.vim}
mkdir ~/.qutebrowser && touch ~/.qutebrowser/q # block bkmk symlinks
zero apply-symlinks

# https://stackoverflow.com/a/56137655
defaults delete com.apple.dock persistent-apps
defaults delete com.apple.dock persistent-others
killall Dock Finder

# https://github.com/StevenBlack/hosts#macos
sudo curl -o /etc/hosts https://raw.githubusercontent.com/StevenBlack/hosts/HEAD/alternates/fakenews-gambling-porn-social/hosts
sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder

chmod +x ~/.config/piu/piu
sudo ln -sv ~/.config/piu/piu /usr/local/bin

piu i -q --HEAD vis kakoune
piu i -q neovim github shortcat
luarocks --local install fennel
piu i -q amethyst honer joshjon-nocturnal qutebrowser

github
open /Applications/{Shortcat,Amethyst,Honer,Nocturnal,qutebrowser}.app

piu i -q d12frosted/emacs-plus/emacs-plus@28 enchant
piu i -q --cask docker # zotero-beta
# https://www.zotero.org/support/dev_builds

# relative ln -s broken, need to cd
# stow symlink broken, need to abs link
ln -sfFv ~/{.config/chemacs/scimax-user/*,scimax/user}
cd
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/jkitchin/scimax/HEAD/install-scimax-mac.sh)"
