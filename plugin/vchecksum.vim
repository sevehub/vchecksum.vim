vim9script

g:vchecksum_algorithm = 'md5'  # Default algorithm

def Checksum()
    echom Eol()
    var current_file = expand('%:p')
    var algorithm = g:vchecksum_algorithm
    var command = 'vchecksum.exe -a ' .. algorithm .. ' ' .. current_file

    # If in visual mode, get the selected text
    if mode() ==# 'v'
        var selection = getreg('"')
    #    l:command = 'vchecksum.exe -a ' . l:algorithm . ' - ' . l:selection
    endif

    # Run the command and capture the output
    var output = system(command)

    # Check for errors
    if v:shell_error != 0
        cgetexpr output
        cgetexpr 'Error: ' .. v:shell_error .. ', ' .. output
        return
    endif

    # Populate the quickfix list with the output
    cgetexpr split(output, '\n')
    copen
enddef

def Eol(): string
	#return line-ending string
	if &fileformat == 'unix'
		return "\n"
	elseif &fileformat == 'dos'
		return "\r\n"
	elseif &fileformat == 'mac'
		return "\r"
    else
        return &fileformat
	endif
enddef 

command! Checksum call Checksum()
