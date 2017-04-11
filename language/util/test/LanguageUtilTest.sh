include language.util.LanguageUtil

include test.executor.TestExecutor

LanguageUtilTest(){
	run(){
		TestExecutor executeTest language.util.test
	}

	testToggleArticleVowelForm[false](){
		if [[ $(LanguageUtil toggleArticleVowelForm cba) == a ]]; then
			echo PASS
		else
			echo FAIL
		fi
	}

	testToggleArticleVowelForm[true](){
		if [[ $(LanguageUtil toggleArticleVowelForm abc) == an ]]; then
			echo PASS
		else
			echo FAIL
		fi
	}

	testTogglePlurality[false](){
		if [[ $(LanguageUtil togglePlurality 1 bar bars) == bar ]]; then
			echo PASS
		else
			echo FAIL
		fi
	}

	testTogglePlurality[true](){
		if [[ $(LanguageUtil togglePlurality 2 bar bars) == bars ]]; then
			echo PASS
		else
			echo FAIL
		fi
	}

	$@
}