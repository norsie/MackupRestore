# MackupRestore
Clean Macbook installation with Mackup restore

### Just run the `setupmacbook.sh` script AFTER:
1. Cloning this repo onto iCloud
2. Hardlinking current settings- and config files to iCloud using Mackup (https://github.com/lra/mackup)
3. Running a clean MacOS installation
4. Logging into iCloud
   > DON'T FORGET unticking the 'Optimise Mac Storage' function within the iCloud Drive options.
     This function will rename certain files to _"file.ext.icloud"_ and mess up your 'mackup restore' (among other things).
     AND tick the 'Desktop & Documents Folders' option, otherwise you won't be able to find the Mackup repo in your iCloud.
5. Run the Mackup script from your iCloud drive witin a terminal. 
   > iCloud drive directory can be found here: `/Users/<username>/Library/Mobile\ Documents/com~apple~CloudDocs/`

### This script will Install the following tools and software:
- Xcode
- Homebrew
  - Brave Browser
  - Firefox
  - Python
  - AWSCLI
  - GIT
  - Packer
  - iTerm2
  - OhMyZsh (including plugins)
  - SublimeText (including plugins)
  - Boostnote
  - Authy authenticator
  - Yubico authenticator
  - Lastpass
  - Slack
  - #Caffeïne
  - Snappy
  - Aerial screensaver
  - Mackup
  - Whatsapp
  - #PLEX
  - Spotify
  - #Steam
  - #VLC
  - Dropbox
  - Logitech Options
 
 ### This script will configure the following:
 - Mackup: Restore settings- and config files from iCloud
 - SublimeText: Install packages and plugins
 - VIM: Get dotfiles from Git, install Vundle and run PluginInstall to get all plugins managed by Vundle
 - OhMyZsh: Get dotfiles from Git
 - Setup Finder layout
