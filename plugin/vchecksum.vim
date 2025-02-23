vim9script
import autoload "../autoload/vchecksum.vim"
if v:version < 900
    finish
endif

var vchecksum_algorithm = 'sha256'
var plugindir =  expand('<sfile>:p:h')
var srcdir = fnamemodify(plugindir, ':h') .. '/src'
var vchecksum_exe = 'vchecksum.exe'
var vchecksum_filename = 'checksum.txt '

if !executable('vchecksum.exe')
    if executable('v.exe')
        if executable(srcdir .. '/' ..  vchecksum_exe)
            vchecksum_exe = srcdir .. '/' .. vchecksum_exe    
        else
            var error = ''
            error = system('v.exe ' .. srcdir .. '/vchecksum.v' )
            if v:shell_error
                echom error
            else
                vchecksum_exe = srcdir .. '/vchecksum.exe'
            endif 
        endif

    else
        echom 'Unable to compile vchecksum'
        finish
    endif
endif

if exists('g:vchecksum_algorithm')
    vchecksum_algorithm = g:vchecksum_algorithm
endif

if exists('g:vchecksum_filename')
    vchecksum_filename = g:vchecksum_filename
endif

def Checksum()
    var checksum = ''
    checksum = vchecksum.GetChecksum(vchecksum_exe, vchecksum_algorithm)
    # Populate the quickfix list with the output
    cgetexpr split(checksum, '\n')
    copen
enddef

def ChecksumSaveToFile()
    var checksum = ''
    checksum = vchecksum.GetChecksum(vchecksum_exe, vchecksum_algorithm)
    vchecksum.WriteStringToFile(checksum, vchecksum_filename)
enddef

command! ChecksumSaveToFile call ChecksumSaveToFile()
command! Checksum call Checksum()
