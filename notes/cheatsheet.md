# ARCH
## downgrade pkg
    - if previously intstalled:
        -pacman -U /var/cache/pacman/pkg/old-pkg-version
    - if not previously installed:
        - pacman -U https://archive.archlinux.org/packages/{some_letter}/some_pkg_name.tar.gz
    - to temporarily ignore updates to a pkg that has been downgraded, add pkg to IgnorePkg section of /etc/pacman.conf
    - if can't update b/c of pacman, run:
        - pacman-key --refresh-keys

## view dep tree
    - pactree
# Audio
- To find the duration of all audio files in a directory,use this command:
    - soxi -D /path/to/files/* | awk 'a+=$1; END{print a}'
## ALSA / PulseAudio / Debian / Sound / Audio
- Was having issues getting sound to play on Debian10 (buster)
- Fixed with 'sudo alsactl init'
    - alsactl -h  / shows commands
    - help screen showed that alsactl init returns driver to a default state
# CALCURSE
## to move date of appt:
    -specify date as month/day (e.g., 1/1 for jan 1)
# COMPTON
## manually restart:
    - pkill compton && compton --config ~/.config/compton.conf -bc
# CMUS
## remove cached metadata (e.g., after running id3convert -s **/*)
    - :update-cache
    - can use -f flag if not co-operating
# DJANGO
## commands
### create a new project
- django-admin startproject {proj name}
### create a new app
- python manage.py startapp {app name}
### start the development webserver
- python manage.py runserver
# DOCKER
## running aws cli with credentials 
- #thanks to https://github.com/mikesir87/aws-cli-docker
    - generate config and credentials files
        - docker run --rm -tiv $HOME/.aws:/root/.aws amazon/aws-cli configure
    - run container with those files
        - docker run --rm -v $HOME/.aws:/root/.aws amazon/aws-cli describe instances
## stop and delete all containers
- sudo docker stop $(sudo docker ps -a -q)
- sudo docker rm $(sudo docker ps -a -q)

## detach from running container
    - ^P ^Q
## clean up / remove dangling images
    - docker prune  (prune -a; for more deletion)
    - WARNING! This will remove:
      - all stopped containers
      - all networks not used by at least one container
      - all dangling images
      - all dangling build cache

        -
        - or (according to my understanding of
          http://www.projectatomic.io/blog/2015/07/what-are-docker-none-none-images/),
          a dangling image is an intermediate image that is no longer the parent
          of any child image.  e.g., if you build hello-world image with fedora,
          and then later the fedora image gets updated, the intermediate OLD
          fedora layer for the hello world image no longer points to any
          child/final image.  I think...
    - sudo docker rmi $(sudo docker images -a --filter=dangling=true -q)
        - where dangling = you've created a new build of an image, but it wasn't named
        - see: https://stackoverflow.com/questions/45142528/docker-what-is-a-dangling-image-and-what-is-an-unused-image)
        - is this deprecated by --remove-orphans?
        - note: docker docs refer to these as both orphans and dangling
        - https://forums.docker.com/t/how-do-i-remove-orphaned-images/1172
## run container with interactive shell (first create if needed)
    docker run -i -t {image name} /bin/bash
        // i - interactive
        // t - allocate a psuedo tty (from docker docs, not sure whta this means)
## Container and Image Management
### Containers
#### Lifecyle
    create - creates a container but does not start it
    rename - allows the container to be renamed
    run - creates and starts a container in one operation
    rm - deletes a container
        - shortcut to remove al docker containers:
            - sudo docker rm $(sudo docker ps -a -q)
    update - updates a container's resource limits
#### Starting and Stopping
    start - starts a container so it is running
    stop - stops a running container
    restart - stops and starts a container
    pause - pauses a running container, "freezing" it in place
    unpause - will unpause a running container
    wait - blocks until running container stops
    kill - sends a SIGKILL to a running container
    attach - will connect to a running container
#### Info
    ps - shows running containers
    logs - gets logs from container
    inspect - looks at all the info on a container
    events - gets events from container
    port - shows public facing port of container
    top - shows running processes in container
    stats - shows containers' resource usage statistics
    diff - shows changed files in the container's FS
###  Images
#### Lifecycle
    images - shows all images
    import - creates an image from a tarball
    build - creates image from Dockerfile
        -t - tag iamge
        -f - specify dockerfile
        - e.g., docker build -t ThisWillBeTheImageTag -f abnormDockerFileName .
    commit - creates image from a container
    rmi - removes an image.
    load - loads an image from a tar archive
    save - saves an image to a tar archive
#### Info
    history - shows history of an image
    tag - tags an image to a name (local or registry)
# FLASH
    - can use lightspark, available as standalone and broswer extensoin
# GENTOO
## Portage tips
    * --noreplace stops re-installing of default packages
    * --jobs=X to run parallel installs
    * for full system/world update: 
        * sudo emerge --update --changed-use --deep --ask --with-bdeps=y @world
# GIT
## to sync a forked, local repo, can use the rebase command, which will avoid the ugly merge commit added when doing a normal pull.
    - git pull --rebase <remote name> <branch name>
## rename a local branch
    - git branch -m <oldname> <newname>

## fix merge conflicts with binary files:
    - can choose local or remote with:
    - git checkout --theirs path/to/file.png, for remote
    - or --ours, for local
## Modify last, unpushed commit:
    - first, make needed changes, stage them with "git add file2" then run
    - git commit --amend
## unstage added, but uncommitted, changes:
    - git reset
## abort failed merge (e.g., pulling from wrong branch, now merge conflicts)
    - git merge --abort
## use vimdiff for git difftool
    - git config diff.tool vimdiff
# Javascript
## Run Prettier for code formatting, w/in vim
    - :Prettier
# LaTeX
    - cancel a compilation: 
        - x <enter>

# LINUX
## set default web browser (particularly in Debian sytems)
    - xdg-settings set default-web-browser firefox-esr.desktop
## crontab and mysqldump gotcha - escaping percent sign
    - \% for dates and such
## printing  (CUPS - common unix print system)
    - start daemon on openRC
        - rc-service cupsd start
    - http interface
        - http://localhost:631/
    - if not detecting usb printer, could be permissions/ownership issue (see
        https://wiki.gentoo.org/wiki/Printing#Configuration)
        - lsusb will show bus and device
            - e.g., Bus 001 Device 004: ID 03f0:ce11 Hewlett-Packard 
        - the character device for this will be at:
            - ls /dev/bus/usb/001/004
        - fix ownership and permissions
            - # chgrp lp /dev/bus/usb/001/004
            - # chmod 660 /dev/bus/usb/001/004
        - printer should appear now

    - problem with printing pdfs with forms in evince (apparently in okular too)
        - one workaround is to open the pdf in firefox, print to pdf, then print
            from evince (ugh; maybe can compile firefox with print support on
            gentoo? )

## full system backup (from linux.com/learn/full-metal-backup-using-dd-command)
    - backup to a compressed image file:
        - sudo dd if=/dev/sda conv=sync,noerror status=progress, bs=64k | gzip -c > /PATH/TO/DRIVE/backup_image.img.gz
    - restore from image file:
        - gunzip -c /PATH/TO/DRIVE/backup_image.img.gz | dd of=/dev/sda
## home dir backup
    - create it:
        - nav to location where backup will store, eg /mnt/ultrabay_hdd,
          (so as not to cause tar failure/warning)
        - tar -cz /home/km | gpg -c -o home_dir_backup_DATE.tgz.gpg
    - restore it:
        - gpg -d home_dir_backup_DATE.tgz.gpg | tar -xz
## view csv files on command line
### use column
- column -s, -t < {filename}
### use csvtool
## email backup
    - nav to where backup will be stored (so as not to cause tar failure/warning)
    - tar -cz /home/km/email /home/km/mail_configs | gpg -c -o /mnt/dock_hdd/em_bk_190218.tgz.gpg

## reset failed login count (to reenable acct after failed logins)
    - faillog -r -u <user>
## logfiles
    - /var/log is main dir
    - /var/log/syslog is main file
    - use grc, the generic colouriser, to colourise log files, e.g.:
        - sudo grc less /var/log/syslog
## capture screenshot
    - imagemagick / ImageMagick 
    - provides the 'import' function:
        - `import test.jpg` - click for window, drag for selection
        - `import -window root screenshot.png` - full desktop, multiple monitors
## find out which system you are on
    - lsb_release -a
    - cat /etc/issue.logo
## kernel options format
    - tips/portage output with the following appearance are often kernel options:
        - CONFIG_SNG_HDA_PREALLOC_SIZE=64
## generate random password from terminal/CLI
    - openssl rand -base64 14
## reset terminal
    - if terminal goes bananas, with a bunch of crazy characters, can use the
        'reset' command to clear screen and reload.  Sometimes helps on headless
        machines.
## unfreeze a terminal (when you accidentally press Ctrl-S)
    - Ctrl-Q
## video capture & webcam, kernel modules/setup
    - great information at https://nlug.ml1.co.uk/2013/02/gentoo-kernel-3-7-9-webcams-v4l-uvc-video-kernel-config/3965
    - modules needed (for logitech c270, uvc-based cam):
        - CONFIG_MEDIA_SUPPORT
        - CONFIG_MEDIA_CAMERA_SUPPORT
        - CONFIG_MEDIA_USB_SUPPORT
        - CONFIG_USB_VIDEO_CLASS
## wifi restart (wifi issues)
    - restart service
        - disconnect from connection
        - # systecmtl stop networking
        - # rmmod brcmfmac
        - # modprobe brcmfmac
        - # systemctl start networking.service

    - check dmesg logs for messages
    - remove/re-add kernel module - # rmmod brcmfmac & # modprobe brcmfmac

# METADATA
## mp3 files
  - strip with id3lib
  - $ id3convert -s {filename}
# MUTT
## mass clearing flags (e.g., O for Old)
  1. tag with 'T'
  2. l to filter (i.e., set tag pattern)
    - ~O matches all old messages
  3. ';' performs action on all tagged messages
  4.  W clears flag (w sets)
  5.  enter flag to clear (here, O)

  - taken from 
    -  https://brianbuccola.com/how-to-mark-all-emails-as-read-in-mutt/
## cancel prompt
    - ctrl-g
## view other mailboxes
    - y
## sync (i.e., actually delete marked)
    - $
## tag all messages matching a pattern
    - T
## show only messages matching a pattern <tag-pattern>
    - l
## apply next function to all tagged messages <tag-prefix>
    - ;
## clear flag <clear-flag>
    - W (uppercase clears flags)
    - w (lowercase is to add flag)
## resend a message that was bounced
  - Esc-e
## Detach a file (i.e., delete an attachment)
    - D
## move message to another mailbox
    - s (for save)
    - ? to choose mailbox
## redraw screen (clear artifacts)
    - Ctrl-t (function is redraw-screen in index)
# MYSQL
## Reset a lost root pw
    - shutdown db service, start in safe mode, connect as root, change pw, restart
        $ sudo systemctl stop mariadb
        $ sudo mysqld_safe --skip-grant-tables --skip-networking &
        $ mysql -u root

        mysql> use mysql;
        mysql> UPDATE user SET password=PASSWORD('YourPasswordHere') WHERE User='root' AND Host = 'localhost';
        mysql> flush privileges;
        mysql> quit
        
        (alternate syntax for update command)
        mysql> update user set authentication_string=password('NEWPASSWORD') where user='root';

## kill running mysql service
    - /usr/bin/mysqladmin -u root -p shutdown
        - mysqladmin binary may be elsewhere
    - can always use 'kill -9'

# NODE, NPM, NVM
## install nvm
    - curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
## nvm - install node
    - nvm install node
## nvm - list installed npm versions
    - nvm ls
## npm - install package
    - npm install -g pkg_name
## npm - uninstall package
    - npm uninstall -g pkg_name
## npm - search
    - npm search pkg_name
## npm - list pkgs
    - npm ls (must be in dir where pkg installed)
    - npm ls -g (list global packages)
    - npm ls -gl (list global packages detail)
## npm - update packages
    - npm update 
    - npm update -g (update global pkgs)
## npm - run executables
    - npm run pkg_name
# PDFs
## combine pdfs
    - pdfunite in the poppler library combines pdfs
    - e.g., pdfunite input1.pdf input2.pdf inputn.pdf output.pdf
## resize /scale pdfs
    - cpdf (for coherent pdf)
## rotate, modify, insert pages etc into pdfs
    - pdfshuffler
## wkhtmltopdf
    - create a pdf from html pages
    - .e.g, wkhtmltopdf input.html output.pdf
    - may need to use a particular header line to render some utf8 chars
        - include this in the head section of the html:
        - <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        - and on command line, may need to specify: --encoding='utf-8'
            - check syntax on that argument
## paid programs to edit
    - pdf studio and masterpdf
# POSTGRES
## launch the postgres cluster:
    - sudo /etc/init.d/postgresql-10 start
## note: run these commands as the postgres user
## enter postgres console:
    - psql
## quit pg console
    - \quit
## Start / stop a server
    - pg_ctl -D /var/lib/postgres/data -l ~/logfile {start/stop}
        - if server won't start, may need to run:
        - sudo chown postgres: /run/postgresql
## create new PG user (on arch):
    - createuser --interactive
## create new PG db (on arch):
    - createdb myDatabaseName
## change user/role pw:
    - \password {username}
# PYTHON
## create virtual env
    - python 3.6+
        - python3 -m venv {env name}
    - python 2.7
        - virtualenv --python=/usr/bin/{version} {env name}
## using venv + pip + bpython
    - after installing bpython in venv, needed to deactivate/reactivate the
      venv for it to see pip3 installed pkgs within bpython... I dunno
## use jupyter lab with venv
      - create, activate venv
      - install kernel: ipython kernel install --user --name={venv name}
      - select kernel in notebook/lab
# RAILS
## redo a migration (for example, if botched the structure & have fixed it)
    - rails db:migrate:redo
## recreate database
    1. rake db:reset (loads from schema.rb)
    2. rake db:drop db:create db:migrate db:seed (loads from migrations)

## caching / precompiling assets in development (for complex asset pipelines)
    1. clear cache - Rails.cache.clear
    2. make sprocket concatenate css&js:
        - in config/environments/development:
            - config.assets.debug = false
    3. precompile assets
        - RAILS_ENV=development rails assets:precompile
    - not sure what the diff between 2 and 3 is
## extract partial with rails-vim
    - :Extract partial_name

# RANGER
## Redraw window
    - ctrl-l
    - useful for pdf previews overlapping/cluttering
# RUBY
## notes
    ### - proc - reusable block
        - e.g.,
            ```ruby

            def run_two_procs(a, b)
                a.call
                b.call
            end

            proc1 = Proc.new do
                puts "Hello from proc1"
            end

            proc2 = Proc.new { p "Hello from Proc2"}
            end

            run_two_procs proc1, proc2    #=> "Hello from proc1", \n "Hello from proc2"

            # alternate ampersand syntax
            x = [2,4,6]
            double = Proc.new { |n| n*2}
            dubbed = x.map(&double)  #=> [4,8,12]
            ```

## useful instance methods
### compact
    - remove nils from array
        - example:
            ```ruby
            [ "a", nil, "b", nil, "c", nil ].compact #=> [ "a", "b", "c" ]
            ```

### drop
    - drop first n elements from array
        - example:
            ```ruby
            - a = [1, 2, 3, 4, 5, 0]
            - a.drop(3)   #=> [4, 5, 0]
            ```

### drop_while
    - drop elements up to, but not including, the first element for which the
      block retuns nil or false; then return array containing the remaining
      elements
          - example:
              ```ruby
              -- a = [1, 2, 3, 4, 5, 0]
              => a.drop_while {|i| i < 3 }   #=> [3, 4, 5, 0]
              ```

### map/collect
    - invoke block once for each element of self
        - example:
            ```ruby
            -  ['a', 'b', 'c'].collect{|letter| letter.capitalize} #=> ["A", "B", "C"]
            ```
            - or more compactly/elegantly:
            ```ruby
            - ['a', 'b', 'c'].collect(&:capitalize)     #=> ["A", "B", "C"]
            ```

### select
    - Invoke the block passing in successive elements from self, returning an
        array containing those elements for which the block returns a true value
        - example:
            ```ruby
            -  a = %w{ a b c d e f } 
            -  a.select {|v| v =~ /[aeiou]/}   #=> ["a", "e"]
            ```

### tr(p1, p2)   (short for translate, same utility exists in Unix)
    - Returns a copy of str with the characters in from_str replaced by the corresponding characters in to_str.
        - example:
            ```ruby
            "hello".tr('el', 'ip')      #=> "hippo"

            def rot13(secret_messages)
            secret_messages.map { |c| c.tr("a-z", "n-za-m") }
            end

#### blog post for tr method:

            - What it does: Return a copy of a string with some characters replaced.  The
            method name, tr, is short for Translate, and similar to the tr utility in
            Unix-like operating systems.  In example 1, "e" is replaced by "i" (the value in the corresponding index of the second argument), and "l" is replaced by "p".  Example 1:

            ```bash
            "hello".tr('el', 'ip')      #=> "hippo"
            ```

            Example 2 is a bit more complex: here we use the tr method to implement a [ROT13
            cipher](https://en.wikipedia.org/wiki/ROT13), which, for the uninitiated, is
            a common cipher used to encrypt/scramble text.  (protip: you can ROT13 encipher
            text within vim by using the g? command.  Try g?ap to scramble a paragraph).
            Example 2:

            ```ruby
            def rot13(secret_messages)
                secret_messages.map { |c| c.tr("a-z", "n-za-m") }
            end
            ```

### upto
    - enum for range from start "upto" argument
        - example
            ```ruby
            4.upto(8) { |n| p n } #=>4, 5, 6, 7,8
            ```
        ##### blog post for [upto] method

            What it does: Generate an Enum for a range, from start value (i.e., the object
            *upto* is being called on), to end value.  Example:

            ```ruby
            4.upto(8) { |n| p n } #=> 4, 5, 6, 7,8
            ```
### yield
    - TODO

    #### block_given?
        - useful to check whether block was passed to yield

## list installed gems
    - gem query --local
## use ri to view local documentation
    - ri {class/method/etc name}
    - ri -i   #=> interactive mode

## RVM
    rvm list (or ls)            - show installed and selected
    rvm install {version}       - install new ruby
    rvm gemset create {name}    - create new gemset
    rvm gemset delete {name}    - delete gemset
    rvm gemset list             - list all gemsets
    rvm use 2.5.0@{name}        - use gemset
    rvm 2.5.0 --default         - set deafult ruby

    specify ruby version and gemset whenever cd'ing into dir
        - use rvm helper:
        - rvm --ruby-version use 2.5.0@dotbox
        - creates 2 files: .ruby-version and a .ruby-gemset


## bundler error - bundle (Gem::GemNotFoundException
- shows up with rbenv
- multiple fixes on SO
- my fix - move or delete Gemfile.lock 
# SHELL / UNIX
## paste args from previous command
    - esc + .  (zsh in viins)
    - alt + .  (emacs binding)
## regain shell after ssh drops
    - ~.
## interpret commands as in-line variables
    - echo $(some command)
    - e.g., mysqldump __ __ __ $(date +"%F)
## list all 256 colors
    for i in {0..255} ; do
      printf "\x1b[48;5;%sm%3d\e[0m " "$i" "$i"
        if (( i == 15 )) || (( i > 15 )) && (( (i-15) % 6 == 0 )); then
          printf "\n";
        fi
    done
## show all man pages for a given command
    - whatis {command}
        - will list all available man pages
    - man -a {command}
        - will show all available man pages
## grep with context
    - -C [n] switch
    - e.g., grep -C 2 cool_phrase cool_file
## pause/resume
    - ^S / ^Q
## open link from terminal
    xdg-open {link address}
    can be combined, e.g.: cat file | tail -n 1 | xargs xdg-open 
## job control 
    - ^Z        - suspend process
    - bg        - continue running process in background
    - fg        - foreground process
    - jobs      - list all jobs

    - reptyr - utility to reparent a process
        2 different methods to use:
        - method 1:
            1. ^Z to suspend
            2. in new (target) terminal, run:
                sudo reptyr -T $PID
                note: this will hang the new terminal 
            3. in new terminal, run:
                ctrl-c, then fg
                note: process should now be running in new terminal
                note: initial terminal will hang, will close when you close new terminal
        - method 2:
            1. ^Z to suspend
            2. bg
            3. disown
            4. edit these two files to be the same (i.e., contain only a 0):
                - /etc/sysctl.d/10-ptrace.conf 
                - /proc/sys/kernel/yama/ptrace_scope
            5. reptyr $PID

## view active shell
    - echo $0
## change to new user and move to their home dir
    - su - {uname}
        - note the dash
## convert text into column formatted text
    - column -t
## redo sequence of shell comands
    - fc = fix command: 
        - this command lets you manipulate history, but also to run a series of shell comamnds
        - e.g., fc 10 20 - this will allow you to edit and then run those 11 commands
## modify brightness
    - xrandr --output LVDS1 --brightness 0.3
    - note: doesn't reduce battery usage; mainly useful for external monitor

## recover corrupt .zsh_history file
    - mv .zsh_history .zsh_history_bad
    - strings .zsh_history_bad > .zsh_history
    - fc -R .zsh_history
        - fc -R = read history from file 
## unset/remove/clobber an env variable
    - unset {VAR NAME}
# SFTP
    - if trying to recursively put directory(ies), the dirs must already exist
        on target
    - good to know for sftp management of web hosts
# SQL
## Get column names
    - select * from INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'{table name here';
# TAR
## list files in a tarball
    - -t
# TMUX
## make selected pane full screen temporarily
    - leader-z  (for zoom)
## renumber windows
    - after closing windows, ending up with gaps, can use:
        - movew -r
        - shortform of "move-window -r"
        - can specify individual windows, too
## prefix mappings
    ,   -   rename-window
    $   -   rename-session
    d   -   detach from session
    &   -   kill window
    !   -   break pane into its own window
    V   -   horizontal stack / vert split
    S   -   vertical stack /horizontal split
    q   -   show pane numbers
space   -   next layout
 UDLR   -   move to pane, up/down/left/right
## change bg color
    - set -g window-style 'fg=black,bg=green'
    - set -g window-style default
## move another pane to current window
    - prefix V / S
        - command: join-pane [-hv] -s :1
        - h for horizontal stack (i.e., vert split) (prefix+V)
        - v for vert stack (i.e., horizont split) (prefix+S)
## copying text
    prefix-[ = enter movement/copy mode
    Space = start copy mode
    Enter = copy selection
    prefix-] = paste
## enable clock mode
    prefix-t
## view settings
    show-options
    - g - show global settings
## pane resizing
    :resize-pane -[D,U,L,R] number_of_cells
    - e.g.,   resize-pane -D 10
## default pane layouts
    - note that M(eta) key is alt, by def(ault)

prefix M-1  = vertical split, all panes same width
|-------|-------|-------|
|       |       |       |
|   0   |   1   |   2   |
|       |       |       |
|-------|-------|-------|

prefix M-2  = horizontal split, all panes same height
|-----------------------|
|          0            |
|-----------------------|
|          1            |
|-----------------------|
|          2            |
|-----------------------|

prefix M-3  = horizontal split, main pane on top
|-----------------------|
|          0            |
|-----------------------|
|   1  |    2   |   3   |
|-----------------------|

prefix M-4  = vertical split, main pane left
|-------|-------|
|       |   1   |
|   0   |-------|
|       |   2   |
|-------|-------|

prefix M-5  = tile, new panes on bottom, same height before same width
|-------|-------|
|   0   |   1   |
|-------|-------|
|   2   |   3   |
|-------|-------|
# TRUFFLE
## migrations
    - truffle migrate --reset
        - will reset a running blockchain
        - migrate will run compile first (saving a step)
        - after running this, may need to restart console session
# VIM
## sessions  - save and restore:
        - save: mksession ~/session.vim 
        - reload: ~/session.vim
        - open vim with session - vim -S ~/mysession.vim
## replace tabs with spaces
    - :ret aka :retab
    -
## if vim freezes, try Ctrl-Q to unfreeze
    - technically this is a shell / tty problem.  Ctrl-S stops output, ^Q
        restores it
## use vimdiff for git difftool
    - git config diff.tool vimdiff
## preview method/class definition (via ctags)
    - ^W }
    - this will pop up the definition in a small-ish split
## rot13 a selection
    - g?
## grab next/prev keyword
    - ^n / ^ p
    - like ^x- ^n/^p but faster if only grabbing from current buffer
## copy a range of line to current pos in buffer
    - -8,-4co.
## close all buffers except current one
    - :%bd|e#
## Delete or Rename a file
    - In file explorer (:Explore or :Sex or :Vex), D / R
## create a new file in netrw at cursor position
    - %
## create a new directory/dir in netrw at cursor position
    - d
## disable wrapping
    - set textwidth=0 wrapmargin=0
## run command on all open buffers
    - bufdo
    - example: run a replace on all open buffers, and save files
        bufdo %s/old/new/ge | update
        - e, no error raised if pattern not found, 
        - update - save if file was changed
## generate a range
    - put =range((11,15))
    - could also pipe to seq, e.g., :r! seq 10
## go to first column
    - 0
## go to first char on line
    - ^
## Increment / decrement integers
    - Ctrl-a  / Ctrl-x
    - works anywhere on line (sometimes?)
## check which options vim was compiled with
    - :version
## install vim with script support (e.g., python), 
    - can use vim-nox (at least on debian)
## show loaded plugins
    - :scriptnames
## redirect output of a command to a buffer
    - redir >buffername
    - :command
    - redir END
    - e buffername
## Plug Commands 
### manually install all Plugins
  - PlugInstall
### remove a plugin
    - comment out unwanted plugin
    - reload vimrc
    - :PlugClean
## open link under cursor in browser
    - gx
## ctrl-p rescan files
    - f5 from ctrl-p mode
## TableMode
- to align, use : in desired spot in header. e.g.,
        | header left |       header center       | header right |
        |-------------+:-------------------------:+-------------:|
        | col left    | col center very long text |    col_right |
        | left        |           center          |        right |
## command line window (with normal mode powers like move/cw/etc)
    ctrl-f - from command mode
    q:, q/, q? - from normal mode
## fugitive
    - search git history - :Glog -S *some_pattern* --
    - make commit = cc in Gstatus window
## open alternate file
    - C-^
## end macro in insert mdoe
   - C-o    -   to enter single normal mode command
## chain multiple commands in vim script
    - use pipe |
## syntax for UltiSnips to use vimscript
    // `!v execute("command in here | second command")`
    - note backticks, parens, quotes and optional pipe
    - execute seems needed to run arbitrary commands, but maybe not
## convert dos/mac to unix file endings 
    - useful when ^M or other non LF eol chars show up in files
        - :e ++ff=dos         - Edit file, using dos file format ('fileformats' is ignored)
        - :setlocal ff=unix   - This buffer will use LF-only line endings when written
        - :w
## disable automatic end-of-line insert
    - open file with "vim -b filename"
    - :set noeol
    - save
    - or add to vimrc - :set nofixendofline
## open files in split, from terminal
    - vim -o file1.ext file2.ext
    - use O (capital O) for vertical splits
## open file under cursor in a split
    - Ctrl-w f
## open with different config / vimrc
    - vim -u {filename}
    - vim -u NONE    #don't load vimrc or plugins
    - vim -u NORC    #load plugins but not vimrc

# Vim Vixen (Firefox add-on)
    - open new tab in background:
        - modify plain json in settings, for "F", to include:
        - "background": true
# Webp
## convery webp to another format
    - install webp package
    - dwebp file.webp -o file.png
# Wordpress
    - DIVI - uploading will initially fail, show an error message "Link you
      requested is no longer valid"
        - this is a limit on upload size and execution time
        - fix by modifying wordpress file, wp-config.php, and then
          (importantly), restarting php-fpm.service (at least on aws ec2 amazon
          linux 2 ami)
# X11
    - xprop - get window manager class name
# XTERM
## resize font temporarily
    - ctrl right-click


