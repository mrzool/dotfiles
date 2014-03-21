# Lint.Vim #

Facilitates tight integration between [JSHint](http://www.jshint.com/), [CSSLint](https://github.com/stubbornella/csslint) and [Vim](http://www.vim.org/).

JavaScript and CSS files are passed through JSHint or CSSLint when a buffer is saved, placing any warnings in the quickfix window for easy navigation to the source of the warning.  To achieve acceptable performance, Google's [V8 Engine](http://code.google.com/p/v8/) is used for JavaScript execution.
## Installation

The following assumes you're using OS X and [pathogen](https://github.com/tpope/vim-pathogen).  Otherwise, refer to the [full V8 documentation](http://code.google.com/p/v8/wiki/BuildingWithGYP).

### Install V8

    svn checkout http://v8.googlecode.com/svn/trunk/ ./v8
    cd v8
    make dependencies
    make native
    sudo cp out/native/d8 /usr/local/bin
    cd ..
    rm -rf v8


### Install our script

    git clone git@github.com:joestelmach/lint.vim.git ~/.vim/bundle/lint.vim

## Configuration

[JSHint](http://www.jshint.com/options/) and [CSSLint](https://github.com/stubbornella/csslint/wiki/Rules) options can be configured with the following files:

    ~/.vim/bundle/lint.vim/js/jshint/options.js
    ~/.vim/bundle/lint.vim/js/csslint/options.js

Alternatively, you can specify an external location for these files in your .vimrc file:

    let jshint_options_file = '/full/path/to/jshint/options.js'                              
    let csslint_options_file = '/full/path/to/csslint/options.js'

If you're d8 executable is not in your classpath, the full path can be specified in your .vimrc file:

    let d8_command = '/full/path/to/d8'

If you're not down with Dark Magenta, an error highlight color may be specified:

    let jshint_highlight_color = 'DarkGray'

You can toggle the plugin on and off by the command:

    LintVimToggle

This works on file (buffer) basis. You can set it off by default:

    let lint_default = 0

You can also disable the plugin entirely:

    let disable_lint = 1 
