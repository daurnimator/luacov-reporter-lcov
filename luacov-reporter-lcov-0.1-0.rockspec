package = "luacov-reporter-lcov"
version = "0.1-0"

description = {
	summary = "A luacov reporter for use with lcov";
	homepage = "https://github.com/daurnimator/luacov-reporter-lcov";
	license = "MIT";
}

source = {
	url = "https://github.com/daurnimator/luacov-reporter-lcov/archive/v0.1.zip";
	dir = "luacov-reporter-lcov-0.1";
}

dependencies = {
	"lua >= 5.1";
	"luacov";
}

build = {
	type = "builtin";
	modules = {
		["luacov.reporter.lcov"] = "luacov/reporter/lcov.lua";
	}
}
