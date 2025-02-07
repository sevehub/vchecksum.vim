
module main
import os
import crypto.md5
import crypto.sha1
import crypto.sha256

const (
	version = '0.0.2'
	algorithms = ['md5', 'sha1', 'sha256']
)

fn print_usage() {
	println('Usage: vchecksum.exe [flags] [algorithm] [file1] [file2]')
	println('flags:')
	println('  -v              Show version')
	println('  -list           List all supported algorithms')
	println('  -a algorithm    Select algorithm (md5, sha1, sha256)')
	println('  -aC algorithm   Compare checksums of two files')
	println('Copyright (c) 2024 SeveTech. All rights reserved.')
}

fn calculate_checksum(file_path string, algorithm string) ?string {
	data := os.read_file(file_path) or {
		println('Error reading file: $err')
		exit(1)
	}

	match algorithm {
		'md5' {
			return md5.sum(data.bytes()).hex()
		}
		'sha1' {
			return sha1.sum(data.bytes()).hex()
		}
		'sha256' {
			return sha256.sum(data.bytes()).hex()
		}
		else {
			println('Unsupported algorithm: $algorithm')
			exit(1)
		}
	}
}

fn main() {
	if os.args.len < 2 {
		print_usage()
		return
	}

	mut algorithm := ''
	arg := os.args[1]
		match arg {
			'-v' {
				println('vchecksum version: $version')
				return
			}
			'--help' {
				print_usage()
				return
			}
			'-list' {
				println('Supported algorithms:')
				for algo in algorithms {
					println('  - $algo')
				}
				return
			}
			'-aC' {
				if  os.args.len > 4  {
					algorithm = os.args[2]
					file1 := os.args[3]
					file2 := os.args[4]
					checksum1 := calculate_checksum(file1, algorithm) or {
						println('Error: $err')
						return
					}

					checksum2 := calculate_checksum(file2, algorithm) or {
						println('Error: $err')
						return
					}
					if checksum1 != checksum2
					{
						// returns an exit status of 1, which indicates failure
						println('1\t False - Different Checksum')
						exit(1)
					}
					else
					{ 
						// returns an exit status of 0, which indicates success
						println('0\t True - Same Checksum')
						exit(0)

					}
				}
				else {

					println('Error: algorithm/files missing after -aC')
					exit(1)
				}
			}

			'-a' {
				if  os.args.len > 3 {
					algorithm = os.args[2]
					file_path := os.args[3]
					if algorithm == '' {
						println('Error: No algorithm specified. Use -a to select one.')
						return
					}
					checksum := calculate_checksum(file_path, algorithm) or {
						println('Error: $err')
						return
					}
					println('$checksum *$file_path')
					return
				}
				else {
					println('Error: Missing algorithm or filename')
					return
				}
			}

			else {
				exit(0)
			}
		}
}
