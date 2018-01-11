SHELL = /bin/sh

# project name (generate executable with this name)
PRIMARY_PROJECT_FOLDER   = testJSON
PRIMARY_PROGRAM  				 = testJSON

# Dependencies
# Boost
BOOST_VER=_1_66_0

BOOST_LIBS_TO_BUILD = filesystem timer chrono system
#relative to this file
BOOST_LIB_DIR = shared/lib_boost$(BOOST_VER)
#relative to this file
BOOSTDIR = shared/boost$(BOOST_VER)

#Subdirectories
DIRECTORIES = $(sort $(dir $(wildcard */makefile)))

.PHONY: build
build: dependencies
		@$(foreach dir,$(DIRECTORIES),$(MAKE) -C $(dir);)

dependencies:
		@echo "---- Build Dependencies ----"
		@$(MAKE) -C shared -f build_boost_libs.mk BOOST_LIBS_TO_BUILD="$(BOOST_LIBS_TO_BUILD)" BOOST_LIB_DIR="../$(BOOST_LIB_DIR)" BOOSTDIR="../$(BOOSTDIR)" BOOST_VER="$(BOOST_VER)"

.PHONY: rebuild
rebuild: remove
		@echo "---- Remove Output Binary ----"
		@$(foreach dir,$(DIRECTORIES),$(MAKE) -C $(dir) remove;)

.PHONY: clean
clean:
		@echo "---- Cleaning ----"
		@$(foreach dir,$(DIRECTORIES),$(MAKE) -C $(dir) clean;)

clean-dependencies:
		@echo "---- Clean Dependencies ----"
		@$(MAKE) -C shared -f build_boost_libs.mk BOOST_LIB_DIR="../$(BOOST_LIB_DIR)" clean

.PHONY: remove
remove: clean
		@echo "---- Removing ----"
		@$(foreach dir,$(DIRECTORIES),$(MAKE) -C $(dir) remove;)

run: build
		@echo "---- Running "$(PRIMARY_PROGRAM)"----"
		@./$(PRIMARY_PROJECT_FOLDER)/out/$(PRIMARY_PROGRAM)
