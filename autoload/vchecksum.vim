vim9script
export def WriteStringToFile(content: string, filename: string): void
    var buffer_path = getbufinfo('%')[0].name
    var dir = fnamemodify(buffer_path, ':h')
    var  full_path = dir .. '/' .. filename
    call writefile([content], full_path)
enddef

export def GetChecksum(exe: string, algo: string): string
    var current_file = expand('%:p')
    var command = exe .. ' -a ' .. algo .. ' ' .. current_file

    var output = system(command)

    # Check for errors
    if v:shell_error != 0
        cgetexpr output
        cgetexpr 'Error: ' .. v:shell_error .. ', ' .. output
        return 'Error: ' .. v:shell_error .. ', ' .. output
    endif
    return output
enddef

