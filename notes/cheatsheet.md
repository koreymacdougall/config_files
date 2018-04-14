# ARCH
## downgrade pkg
    pacman -U /var/cache/pacman/pkg/old-pkg-version
## view dep tree
    - pactree
# CALCURSE
## to move date of appt:
    -specify date as month/day (e.g., 1/1 for jan 1)
# COMPTON
## manually restart:
    - pkill compton && comtpon --config ~/.config/compton.conf -bc
# DOCKER
## detach from running container
    - ^P ^Q
## remove dangling images
    where dangling = you've created a new build of an image, but it wasn't named
    see: https://stackoverflow.com/questions/45142528/docker-what-is-a-dangling-image-and-what-is-an-unused-image)
    - sudo docker rmi $(sudo docker images -a --filter=dangling=true -q)
    - possible alternative, but check docs
        sudo docker system prune -a
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
# MUTT
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
# PDFs
## combine pdfs
    - pdfunite in the poppler library combines pdfs
    - e.g., pdfunite input1.pdf input2.pdf inputn.pdf output.pdf
## wkhtmltopdf
    - create a pdf from html pages
    - .e.g, wkhtmltopdf input.html output.pdf
    - may need to use a particular header line to render some utf8 chars
        - include this in the head section of the html:
        - <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        - and on command line, may need to specify: --encoding='utf-8'
            - check syntax on that argument
# PYTHON
## create virtual env
    - python 3.6+
        - python3 -m venv {env name}
    - python 2.7
        - virtualenv --python=/usr/bin/{version} {env name}
# RVM
## rvm
    list                    - show installed and selected
    gemset create {name}    - create new gemset
    use 2.5.0@{name}        - use gemset
# SHELL
## grep with context
    - -C [n] switch
    - e.g., grep -C 2 cool_phrase cool_file
## view active shell
    - echo $0
## redo sequence of shell comands
    - fc - this command lets you manipulate history, but also to run a series of shell comamnds
        - e.g., fc 10 20 - this will allow you to edit and then run those 11 commands
# TAR
## list files in a tarball
    - -t
# TMUX
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
## change bg color
    - set -g window-style 'fg=black,bg=green'
    - set -g window-style default
## move another pane to current window
    join-pane [-hv] -s :1
    - h for horizontal stack (i.e., vert split) (prefix+V)
    - v for vert stack (i.e., horizont split) (prefix+S)
## copying text
    prefix-[ = enter movement/copy mode
    Space = start copy mode
    Enter = copy selection
    prefix-] = paste
## view settings
    show-options
    - g - show global settings
## defaults for pane resizing / default layouts
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
# VIM
## disable wrapping
    - set textwidth=0 wrapmargin=0
## generate a range
    - put =range((11,15))
    - could also pipe to seq, e.g., :r! seq 10
## go to first column
    - 0
## Increment / decrement
    - Ctrl-a  / Ctrl-x
    - works anywhere on line
## check which options vim was compiled with
    - :version
## remove plugin (using vim-plug)
    - comment out unwanted plugin
    - reload vimrc
    - :PlugClean
## show loaded plugins
    - :scriptnames
## open link under cursor in browser
    - gx
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
# XTERM
## resize font temporarily
    - ctrl right-click
