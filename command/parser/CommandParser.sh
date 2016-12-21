include string.util.StringUtil

CommandParser(){
	getValidFunctions(){
		local file=${1}

		local validFunctions=()

		while read line; do
			if [[ ${line} == *\(\){ ]]; then
				local validFunctions+=($(StringUtil strip ${line} \(\)\{))
			fi
		done < ${file}

		echo ${validFunctions[@]}
	}

	$@
}