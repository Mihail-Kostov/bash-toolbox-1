include array.validator.ArrayValidator

include test.executor.TestExecutor
include test.util.TestUtil

@class
ArrayValidatorTest(){
	run(){
		TestExecutor executeTest ArrayValidatorTest
	}

	@test
	testHasEntry[false](){
		local inputArray=(foo foo)

		${assertNull} $(ArrayValidator hasEntry inputArray bar)
	}

	@test
	testHasEntry[true](){
		local inputArray=(foo bar)

		${assertTrue} $(ArrayValidator hasEntry inputArray foo)
	}

	@test
	testHasUniqueEntry[false](){
		local inputArray=(foo foo bar)

		${assertNull} $(ArrayValidator hasUniqueEntry inputArray foo)
	}

	@test
	testHasUniqueEntry[true](){
		local inputArray=(foo foo bar)

		${assertTrue} $(ArrayValidator hasUniqueEntry inputArray bar)
	}

	local assertNull="TestUtil assertNull"
	local assertTrue="TestUtil assertTrue"

	$@
}