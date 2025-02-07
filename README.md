# vchecksum.vim

A Vim9Script plugin that seamlessly integrates with the V language's cryptographic library, enabling users to calculate file checksums and save them in a format compatible with GNU Coreutils (hash followed by the corresponding file path).


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

To save the checksum to a file, use the command:
:ChecksumSaveToFile


## Configuration
You can specify the algorithm to use by setting the g:vchecksum_algorithm variable in your Vim configuration. For example, to use SHA256:

```vim
let g:vchecksum_algorithm = 'sha256'
```
If no algorithm is specified, the default will be sha256. Options available are 'sha1', 'md5', and 'sha256'


You can specify a different filename for saving the checksum (default: `checksum.txt`) by setting the following variable in your Vim configuration:

```vim
    let g:vchecksum_filename = 'checksum.txt'
```
The saved file maintains a format compatible with GNU Coreutils sha-cli programs. You can verify the checksums using the following command:

```bash
    sha256sum -c checksum.txt
```

### Note
This project is a work in progress and has been tested primarily on Windows PowerShell. Contributions are welcome!
