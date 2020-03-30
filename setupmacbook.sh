#!/bin/sh
# Initial MacBook installation, configuration and restoration of backed up settings (done with Mackup)

# Exit immediately if a command exits with a non-zero status
set -e

# SSH
echo -n "--> Do you want to generate a SSH key? (y/n)"
read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo "--> Generating SSH key .."
    ssh-keygen
else
    echo "--> Skipping key generation .."
fi

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew update && brew upgrade
brew doctor
brew tap homebrew/cask-versions

# App Store apps
brew install mas

# Xcode Developer
#mas install 497799835 # Xcode
#echo "--> Pointing xcode-select to the Xcode Developer directory .."
#sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
#sudo xcodebuild -license accept

# Browsers
brew cask install brave-browser
brew cask install firefox

# Python 3 & modules
brew install python3
pip3 install boto3
pip3 install requests
sudo python3 -m pip install pymongo==3.8.0

# Python 2 & modules
brew install python2
pip2 install -U boto
sudo python -m pip install pymongo==2.8.1
pip2 install ConfigParser
pip2 install enum
pip2 install prettytable
pip2 install hurry.filesize
pip2 install requests

# AWSCLI
brew install awscli

# GIT
brew install git

# Packer
brew install packer

# iTerm2
brew cask install iterm2

# Zsh
brew install zsh

# SublimeText editor
brew cask install sublime-text

# Boostnote
brew cask install boostnote

# Authy authenticator
brew cask install authy

# Yubico authenticator
brew cask install homebrew/cask-drivers/yubico-authenticator

# Lastpass
brew cask install lastpass

# Slack
brew cask install slack

# Caffeine
# echo "~~Slurp~~"
# brew cask install caffeine

# Aerial ScreenSaver
brew cask install aerial

# Mackup
# README > https://github.com/lra/mackup#quickstart
brew install mackup

# Whatsapp
brew cask install whatsapp

# Media
# brew cask install plex-media-player
brew cask install spotify
# brew cask install steam
brew cask install discord
# brew cask install vlc

# Dropbox
brew cask install dropbox

# Logitech Options
brew cask install homebrew/cask-drivers/logitech-options


# CONFIGURATION
# #############
 
## Setup Mackup (to iCloud)
## README > https://github.com/lra/mackup/blob/master/doc/README.md
echo "--> Creating config file for Mackup .."
cat <<EOF >~/.mackup.cfg
[storage]
engine = icloud
directory = .config/mackup

[applications_to_ignore]
aws
EOF

## Setup Package Controll & SublimeText
## Manually install Package Controll > https://packagecontrol.io/installation#st3

echo "--> Installing Package Control for SublimeText .."
[ ! -d ~/Library/Application\ Support/Sublime\ Text\ 3/ ] && mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/
[ ! -d ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/ ] && mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/
curl "https://packagecontrol.io/Package Control.sublime-package" --output ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/"Package Control.sublime-package"

echo "--> Creating package file for SublimeText .."
[ ! -d ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/ ] && mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/
cat <<EOF >~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/"Package Control.sublime-settings"
{
	"bootstrapped": true,
	"in_process_packages":
	[
	],
	"installed_packages":
	[
		"A File Icon",
		"AdvancedNewFile",
		"Alignment",
		"BracketHighlighter",
		"DocBlockr",
		"Emmet",
		"FileDiffs",
		"GitGutter",
		"JSONLint",
		"Material Theme",
		"Notes",
		"Package Control",
		"Project Specific Syntax Settings",
		"Puppet",
		"SideBarEnhancements",
		"SublimeCodeIntel",
		"sublimelint"
	]
}
EOF

echo "--> Creating preference file for SublimeText .."
cat <<EOF >~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
{
  "color_scheme": "Packages/Material Theme/schemes/Material-Theme.tmTheme",
  "font_size": 13,
  "ignored_packages":
  [
      "Markdown",
      "Vintage"
  ],
  "line-padding-bottom": 3,
  "line-padding-top": 3,
  "margin": 0,
  "material_theme_accent_titlebar": true,
  "material_theme_compact_panel": true,
  "material_theme_compact_sidebar": true,
  "material_theme_contrast_mode": true,
  "material_theme_small_statusbar": true,
  "material_theme_small_tab": true,
  "material_theme_tabs_autowidth": true,
  "remember_open_files": true,
  "theme": "Material-Theme.sublime-theme"
}
EOF


## Setup VIM (dotfiles)
echo "--> setting up VIM dotfiles .."
git clone https://bitbucket.org/mvanbaak/dotfiles.vim.git ~/.vim
if type git &>/dev/null
then
    # install Vundle
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

    # if we have vim, run PluginInstall to get all plugins managed by vundle
    if type vim &>/dev/null
    then
        vim +PluginInstall +qall
    else
        echo "Vim is not installed"
        exit 1
    fi
    # Fix ~/.vimrc
    if [ -f ~/.vimrc ]
    then
        mv ~/.vimrc ~/.vimrc.backup.denneg
    fi
    echo "source ~/.vim/vimrc" > ~/.vimrc
else
    echo "Git is not installed"
    exit 1
fi


## Setup ZSH (dotfiles)
echo "--> setting up ZSH dotfiles .."
git clone https://bitbucket.org/mvanbaak/dotfiles.zsh.git ~/.zsh
    # Fix ~/.zshrc
    if [ -f ~/.zshrc ]
    then
        mv ~/.zshrc ~/.zshrc.backup.denneg
    fi
    echo "source ~/.zsh/zshrc" > ~/.zshrc

    # Fix ~/.zshenv
    if [ -f ~/.zshenv ]
    then
        mv ~/.zshenv ~/.zshenv.backup.denneg
    fi
    echo "source ~/.zsh/zshenv" > ~/.zshenv


## Setup Finder
echo "--> setting up Finder layout .."
defaults write com.apple.finder ShowStatusBar -bool TRUE
defaults write com.apple.finder ShowPathbar -bool TRUE
defaults write com.apple.finder ShowSidebar -bool TRUE
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool TRUE
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool TRUE
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool TRUE
defaults write com.apple.finder NewWindowTarget PfHm
defaults write com.apple.finder NewWindowTargetPath file://$HOME
defaults write com.apple.finder DesktopViewSettings "{
    IconViewSettings =     {
        arrangeBy = name;
        backgroundColorBlue = 1;
        backgroundColorGreen = 1;
        backgroundColorRed = 1;
        backgroundType = 0;
        gridOffsetX = 0;
        gridOffsetY = 0;
        gridSpacing = 85;
        iconSize = 64;
        labelOnBottom = 0;
        showIconPreview = 1;
        showItemInfo = 1;
        textSize = 12;
        viewOptionsVersion = 1;
    };
}"
defaults write com.apple.finder StandardViewSettings "{
    ExtendedListViewSettingsV2 =     {
        calculateAllSizes = 0;
        columns =         (
                        {
                ascending = 1;
                identifier = name;
                visible = 1;
                width = 300;
            },
                        {
                ascending = 0;
                identifier = ubiquity;
                visible = 0;
                width = 35;
            },
                        {
                ascending = 0;
                identifier = dateModified;
                visible = 1;
                width = 181;
            },
                        {
                ascending = 0;
                identifier = dateCreated;
                visible = 0;
                width = 181;
            },
                        {
                ascending = 0;
                identifier = size;
                visible = 1;
                width = 97;
            },
                        {
                ascending = 1;
                identifier = kind;
                visible = 1;
                width = 115;
            },
                        {
                ascending = 1;
                identifier = label;
                visible = 0;
                width = 100;
            },
                        {
                ascending = 1;
                identifier = version;
                visible = 0;
                width = 75;
            },
                        {
                ascending = 1;
                identifier = comments;
                visible = 0;
                width = 300;
            },
                        {
                ascending = 0;
                identifier = dateLastOpened;
                visible = 0;
                width = 200;
            },
                        {
                ascending = 0;
                identifier = dateAdded;
                visible = 0;
                width = 181;
            }
        );
        iconSize = 16;
        showIconPreview = 1;
        sortColumn = name;
        textSize = 12;
        useRelativeDates = 1;
        viewOptionsVersion = 1;
    };
    GalleryViewSettings =     {
        arrangeBy = name;
        iconSize = 48;
        showIconPreview = 1;
        viewOptionsVersion = 1;
    };
    IconViewSettings =     {
        arrangeBy = none;
        backgroundColorBlue = 1;
        backgroundColorGreen = 1;
        backgroundColorRed = 1;
        backgroundType = 0;
        gridOffsetX = 0;
        gridOffsetY = 0;
        gridSpacing = 54;
        iconSize = 64;
        labelOnBottom = 1;
        showIconPreview = 1;
        showItemInfo = 0;
        textSize = 12;
        viewOptionsVersion = 1;
    };
    ListViewSettings =     {
        calculateAllSizes = 0;
        columns =         {
            comments =             {
                ascending = 1;
                index = 7;
                visible = 0;
                width = 300;
            };
            dateCreated =             {
                ascending = 0;
                index = 2;
                visible = 0;
                width = 181;
            };
            dateLastOpened =             {
                ascending = 0;
                index = 8;
                visible = 0;
                width = 200;
            };
            dateModified =             {
                ascending = 0;
                index = 1;
                visible = 1;
                width = 181;
            };
            kind =             {
                ascending = 1;
                index = 4;
                visible = 1;
                width = 115;
            };
            label =             {
                ascending = 1;
                index = 5;
                visible = 0;
                width = 100;
            };
            name =             {
                ascending = 1;
                index = 0;
                visible = 1;
                width = 300;
            };
            size =             {
                ascending = 0;
                index = 3;
                visible = 1;
                width = 97;
            };
            version =             {
                ascending = 1;
                index = 6;
                visible = 0;
                width = 75;
            };
        };
        iconSize = 16;
        showIconPreview = 1;
        sortColumn = name;
        textSize = 12;
        useRelativeDates = 1;
        viewOptionsVersion = 1;
    };
    SettingsType = StandardViewSettings;
}"

# show directory path in Finder titlebar
defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES;killall Finder

# RESTORE Settings
# ################

### Mackup
echo -n "--> Do you want to restore your config files and settings using Mackup? (y/n)"
read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo "--> Restoring settings via Mackup (iCloud) .." 
    mackup restore
else
    echo "--> Skipping Mackup restore .."
fi

echo "--> JOB's DONE !!"
