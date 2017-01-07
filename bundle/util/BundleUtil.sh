include app.server.validator.AppServerValidator
include app.server.version.AppServerVersion

include base.comparator.BaseComparator
include base.vars.BaseVars

include file.io.util.FileIOUtil

include logger.Logger

include string.util.StringUtil

BundleUtil(){
	configure(){
		local appServerDir=$(AppServerFactory getAppServerDir ${1} ${2})

		Logger logProgressMsg "increasing_memory_limit"
		if [[ $(AppServerValidator isTomcat appServer) ]]; then
			${replace} ${appServerDir}/bin/setenv.sh Xmx1024m Xmx2048m

			string1=XX:MaxPermSize=384m
			string2=Xms1024m

			${replace} ${appServerDir}/bin/setenv.sh ${string1} ${string2}
		elif [[ $(AppServerValidator isWildfly appServer) ]]; then
			d=[[:digit:]]

			${replace} ${appServerDir}/bin/standalone.conf Xmx${d}\+m Xmx2048m

			string1=MaxMetaspaceSize=${d}\+m
			string2=MaxMetaspaceSize=1024m

			${replace} ${appServerDir}/bin/standalone.conf ${string1} ${string2}
		fi
		Logger logCompletedMsg

		if [[ $(BaseComparator isEqual ${branch} ee-6.2.x) ]]; then
			Logger logProgressMsg "changing_port_for_${branch}"
			${replace} ${appServerDir}/conf/server.xml "\"8" "\"7"
			Logger logCompletedMsg
		fi
	}

	deleteBundleContent(){
		deleteHomeFolders ${1}
		deleteTempFiles ${1}

		Logger logProgressMsg "deleting_remaining_bundle_folders"

		for dir in deploy osgi poshi tools work; do
			rm -rf ${bundleDir}/${dir}
		done

		Logger logCompletedMsg

		Logger logProgressMsg "deleting_app_server_directory"
		rm -rf $(AppServerFactory getAppServerDir ${1} ${2})
		Logger logCompletedMsg
	}

	deleteHomeFolders(){
		Logger logProgressMsg "deleting_home_folders"
		rm -rf ${bundleDir}/data ${bundleDir}/deploy
		Logger logCompletedMsg
	}

	local branch=$(BaseVars returnBranch ${2})
	local bundleDir=$(BaseVars returnBbundleDir ${2})
	local replace="FileIOUtil replace"

	$@
}