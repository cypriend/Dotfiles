# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"
DEFAULT_USER='cyprienWork'
source $ZSH/oh-my-zsh.sh

# Completion
autoload -U compinit
compinit

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

#Editor
# export EDITOR=$VISUAL
export VISUAL=Sublime Text



# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# Misc aliases
alias ls='ls -AlhF'
alias yoopies='cd /Users/cyprienWork/Sites/YoopiesDev/'
alias github='cd /Users/cyprienWork/Github/'
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'


# ZSH aliases
alias zshconfig="subl ~/.zshrc"
alias ohmyzsh="subl ~/.oh-my-zsh"

# PHP & SF2 aliases
alias composer='php /usr/local/bin/composer update'
alias gen='php app/console doctrine:generate:entities --no-backup'
alias schema='php app/console doctrine:schema:update --force'
alias dump='php app/console assetic:dump'
alias console='php app/console'
alias fixtures='php app/console doctrine:fixtures:load --append'
alias cc='sudo rm -rf app/cache/*'

# GIT aliases
# alias fix='git commit -am "fix"'
alias gpp='git pull && git push'
alias wathchanged='git diff --stat HEAD^ HEAD'

# alias preprod="manager 'cd deploy_preprod && git pull && /var/lib/gems/1.8/bin/cap preprod deploy'"
# alias prodAPI="manager 'cd deploy_prod && git pull && /var/lib/gems/1.8/bin/cap api deploy'"
# alias prodHTTP="manager 'cd deploy_prod && git pull && /var/lib/gems/1.8/bin/cap http deploy'"
# alias gitprod="git pull --rebase && git checkout prod && git pull && git merge master && git push && git checkout master"
# alias gitpreprod="git pull --rebase && git checkout preprod && git pull && git merge master && git push && git checkout master"


# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)


# PATH BORDEL...
export PATH="/usr/local/bin:$PATH"
export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH
export PATH="$(brew --prefix josegonzalez/php/php55)/bin:$PATH"
PATH=$HOME/.rvm/bin:$PATH      # RVM binaries
PATH=/usr/local/bin:$PATH    # User binaries
PATH=/usr/bin:$PATH             # User binaries
PATH=$HOME/bin:$PATH        # Personal
PATH=/usr/X11/bin:$PATH     # X11 Stuff
PATH=/usr/sbin:$PATH #no fucking idea
PATH=/usr/local/share/npm/bin:$PATH
PATH=local/node/bin:$PATH
PATH=/usr/local/share/scala/bin:$PATH
PATH=/usr/local/mysql/bin:$PATH
PATH=$HOME/node_modules/.bin:$PATH
PATH=/bin:$PATH     #no fucking idea
PATH=/usr/local/Cellar/php55/5.5.9/bin:$PATH
PATH="/usr/local/bin:$PATH"



###########################################
#   iTerm Tab and Title Customization     #
###########################################

function set_title_tab {

    function settab   {

            # file settab  -- invoked only if iTerm or Konsole is running

            #  Set iterm window tab to current directory and penultimate directory if the
            #  shell process is running.  Truncate to leave the rightmost $rlength characters.
            #
            #  Use with functions settitle (to set iterm title bar to current directory)
            #  and chpwd


        if [[ $TERM_PROGRAM == iTerm.app && -z "$KONSOLE_DCOP_SESSION" ]];then

            # The $rlength variable prints only the 20 rightmost characters. Otherwise iTerm truncates
            # what appears in the tab from the left.


                # Chage the following to change the string that actually appears in the tab:

                    tab_label="$PWD:h:t/$PWD:t"

                    rlength="20"   # number of characters to appear before truncation from the left

                    echo -ne "\e]1;${(l:rlength:)tab_label}\a"


        else

                # For KDE konsole tabs

                # Chage the following to change the string that actually appears in the tab:

                    tab_label="$PWD:h:t/$PWD:t"

                    rlength="20"   # number of characters to appear before truncation from the left

                # If we have a functioning KDE console, set the tab in the same way
                if [[ -n "$KONSOLE_DCOP_SESSION" && ( -x $(which dcop)  )  ]];then
                        dcop "$KONSOLE_DCOP_SESSION" renameSession "${(l:rlength:)tab_label}"
                else
                    : # do nothing if tabs don't exist
                fi

        fi
    }

    function settitle   {
        # Function "settitle"  --  set the title of the iterm title bar. use with chpwd and settab

        # Change the following string to change what appears in the Title Bar label:


            title_lab=$HOST:r:r::$PWD
                # Prints the host name, two colons, absolute path for current directory

            # Change the title bar label dynamically:

            echo -ne "\e]2;[zsh]   $title_lab\a"
    }

    # Set tab and title bar dynamically using above-defined functions

        function title_tab_chpwd { settab ; settitle }

        # Now we need to run it:
        title_tab_chpwd


    typeset -ga preexec_functions
    preexec_functions+=title_tab_preexec

    typeset -ga precmd_functions
    precmd_functions+=title_tab_precmd

    typeset -ga chpwd_functions
    chpwd_functions+=title_tab_chpwd

}

####################
set_title_tab
