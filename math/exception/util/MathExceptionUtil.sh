include base.comparator.BaseComparator
include base.util.BaseUtil
include string.util.StringUtil

MathExceptionHelper(){
	_formatLogLevel(){
		local logLevel=${1}
		local validLogLevels=(info error)

		local maxLength=$(_returnMaxLength ${validLogLevels[@]})

		while [[ $(BaseComparator isLessThan $(StringUtil
			length ${logLevel}) ${maxLength}) ]]; do

			local logLevel=$(StringUtil append ${logLevel} _)
		done

		StringUtil toUpperCase ${logLevel}
	}

	_returnMaxLength(){
		local array=($@)
		local maxLength=0

		for a in ${array[@]}; do
			if [[ $(StringUtil length ${a}) > ${maxLength} ]]; then
				local maxLength=$(StringUtil length ${a})
			fi
		done

		echo ${maxLength}
	}

	getLogMsg(){
		local time=$(BaseUtil timestamp log)

		if [[ $(BaseComparator isEqualIgnoreCase ${1} error) ]]; then
			local message=$(colorme red $(StringUtil replace $(StringUtil
				capitalize ${2}) _ space))
		else
			local message=$(StringUtil parseMessage $(StringUtil
				capitalize ${2}))
		fi

		echo -e "${time} [ $(_formatLogLevel ${1}) ] ${message}"
	}

	logErroMsg(){
		getLogMsg error ${1}
	}

	$@
}