GIT_TAG := $(shell git log -1 --pretty=%h)
export GIT_TAG

help:
	@echo 'For convenience'
	@echo
	@echo 'Available make targets:'
	@grep PHONY: Makefile | cut -d: -f2 | sed '1d;s/^/make/'

.PHONY: env          # show environment variables
env:
	@echo "GIT_TAG           = ${GIT_TAG}"

.PHONY: gen          # setup build configuration
gen:
	@echo "generate build configuration"
	(cmake -G "Unix Makefiles" -H. -B_bld -DBUILD_TZ_LIB=ON -DCMAKE_CXX_STANDARD=11)
	# (cmake -G "Unix Makefiles" -H. -B_bld -DBUILD_TZ_LIB=ON -DCMAKE_CXX_STANDARD=17)

.PHONY: gen2         # setup build configuration using internal tzdb instead of the one provided by date lib
gen2:
	@echo "generate build configuration (internal tzdb)"
	(cmake -G "Unix Makefiles" -H. -B_bld -DBUILD_TZ_LIB=ON -DUSE_SYSTEM_TZ_DB=ON -DCMAKE_CXX_STANDARD=11)
	# (cmake -G "Unix Makefiles" -H. -B_bld -DBUILD_TZ_LIB=ON -DUSE_SYSTEM_TZ_DB=ON -DCMAKE_CXX_STANDARD=17)

.PHONY: bld          # build tests
bld: gen
	@echo "build tests"
	(cmake --build _bld)

.PHONY: bld2         # build tests using internal tzdb instead of the one provided by date lib
bld2: gen2
	@echo "build tests (internal tzdb)"
	(cmake --build _bld)

.PHONY: test         # run tests
test: bld
	@echo "Run tests"
	_bld/test/date.benchmark # eternal battle with f..g cmake

.PHONY: test2        # run tests using internal tzdb instead of the one provided by date lib
test2: bld2
	@echo "Run tests (internal tzdb)"
	_bld/test/date.benchmark # eternal battle with f..g cmake

.PHONY: cln          # clean current build environment
cln:
	@echo "Cleaning current build environment"
	rm -rf _bld