include logger.Logger

include math.util.MathUtil

package base

GitUtil(){
	cleanSource(){
		Logger logProgressMsg "resetting_the_source_directory"

		local buildDir=$(BaseVars returnBuildDir ${@})

		cd ${buildDir}

		git reset --hard -q

		if [[ $(MathUtil isEven $(BaseUtil getDate -d)) || $(
			BaseComparator isEqual ${1} true) ]] ; then

			git clean -fdqx
		fi

		Logger logCompletedMsg
	}

	clearIndexLock(){
		local lockFile=$(BaseVars returnBuildDir ${1})/.git/index.lock

		if [ -e ${lockFile} ]; then
			Logger logProgressMsg "clearing_index_lock"

			rm -rf ${lockFile}

			Logger logCompletedMsg
		fi
	}

	getCurBranch(){
		git rev-parse --abbrev-ref HEAD
	}

	listBranches(){
		git branch | sed s/\*/\ /g
	}

	$@
}