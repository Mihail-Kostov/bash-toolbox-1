include base.vars.BaseVars

include props.writer.util

PropsWriter(){
	setAppServerProps(){
		${setProps} ${appServerProps} ${2} ${3}
	}

	setBuildProps(){
		${setProps} ${buildProps} ${2} ${3}
	}

	setPortalProps(){
		${setProps} ${portalProps} ${2} ${3}
	}

	setTestProps(){
		${setProps} ${testProps} ${2} ${3}
	}

	unsetAppServerProps(){
		${disableProps} ${appServerProps} ${2}
	}

	unsetBuildProps(){
		${disableProps} ${buildProps} ${2}
	}

	unsetPortalProps(){
		${disableProps} ${portalProps} ${2}
	}

	unsetTestProps(){
		${disableProps} ${testProps} ${2}
	}

	local _buildDir=$(BaseVars returnBuildDir ${2})
	local _bundleDir=$(BaseVars returnBundleDir ${2})
	local appServerProps=${_buildDir}/app.server.${HOSTNAME}.properties
	local buildProps=${_buildDir}/build.${HOSTNAME}.proeprties
	local disableProps="PropsWriterUtil disableProps"
	local portalProps=${_bundleDir}/portal-ext.properties
	local setProps="PropsWriterUtil setProps"
	local testProps=${_buildDir}/test.${HOSTNAME}.properties

	$@
}