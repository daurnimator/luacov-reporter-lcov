# luacov-reporter-lcov

A [luacov](https://keplerproject.github.io/luacov/) reporter for use with [lcov](https://github.com/linux-test-project/lcov).

## Installation

Use luarocks:

```
luarocks install luacov-reporter-lcov
```

luacov-reporter-lcov will optionally use an md5 module if you have one installed.


## Usage

First generate your luacov stats file, e.g. via passing `-lluacov` to Lua or with `busted -c`

```sh
# Invoke luacov with a custom reporter
luacov -r lcov
# Generate a set of HTML pages showcasing your coverage
genhtml luacov.report.out -o destination_directory/
```

To generate cross-language coverage (e.g. for a lua library with both C and Lua components), you can first assemble files with the `lcov` tool.
