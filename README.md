terminaldocument
================

This is a [Vim] plugin that shows a proxy icon on the title bar for the file
you're editing when running on Terminal.app on OS X El Capitan.

![Example screenshot](./doc/demo.png)


## Installation

### With pathogen.vim

The best way is to use [pathogen.vim] to handle your Vim plugins.

Once you have pathogen.vim installed, you may clone this repository into
`~/.vim/bundle`:

```sh
$ cd ~/.vim/bundle
$ git clone https://github.com/mernen/vim-terminaldocument.git
```

### Manual

The simplest way without depending on other plugins is to copy
[terminaldocument.vim] (./plugin/terminaldocument.vim) (just this file) into
the `~/.vim/plugin` directory.


## License

This code is free to use under the terms of the MIT license.
See the [LICENSE](./LICENSE) file for details.


[pathogen.vim]: https://github.com/tpope/vim-pathogen
[Vim]: http://www.vim.org
