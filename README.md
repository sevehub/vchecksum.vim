# vchecksum.vim

A Vim9Script plugin that integrates the V language crypto library, allowing users to calculate checksums of files or selected text directly within Vim. Supports multiple algorithms.


## Requirements

- Vim 9 or higher
- V Language (to compile the `vchecksum.exe` program)

## Installation

To install `vchecksum.vim`, use your preferred plugin manager. For example, if you are using [vim-plug](https://github.com/junegunn/vim-plug), add the following line to your `.vimrc`:

```vim
Plug 'yourusername/vchecksum.vim'
```
Then, run the following command in Vim:

:PlugInstall

### Usage
To calculate the checksum of the current file, use the command:

:Checksum
or the shortcut:
<Leader>c

To calculate the checksum of a selected text in visual mode, select the text and then run:

:Checksum

## Configuration
You can specify the algorithm to use by setting the g:vchecksum_algorithm variable in your Vim configuration. For example, to use SHA256:

```vim
let g:vchecksum_algorithm = 'sha256'
```
If no algorithm is specified, the default will be MD5.
