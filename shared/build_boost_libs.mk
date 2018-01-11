# Adapted from a makefile provided by the user "lockcmpxchg8b" on StackOverflow:
# https://stackoverflow.com/questions/47519561/partially-compile-and-include-boost-with-makefile-c/

SHELL = /bin/sh

# This makefile expects multiple arguments to be passed:
#
# Use the pattern: make var_name="var_value" when invoking this makefile
#
# BOOST_VER (the version suffix )
# BOOST_LIBS_TO_BUILD (space delimited list of boost libraries to build)
# BOOST_LIB_DIR (the output lib dir for the boost libraries)
# BOOSTDIR (the base directory to build from)
#

# Compile Info
CXX = g++
CXXFLAGS = -Wall -std=c++11

WORK_FOLDER = obj_boost$(BOOST_VER)

.PHONY: all
all: $(foreach lib,$(BOOST_LIBS_TO_BUILD),$(BOOST_LIB_DIR)/libboost_$(lib).a )

$(BOOST_LIB_DIR):
	@mkdir -p $(BOOST_LIB_DIR)

$(WORK_FOLDER):
	@mkdir -p $(WORK_FOLDER)

#####
# helper for building the .o files in WORK_FOLDER
#####
define MAKE_BOOST_LIB_COMPILE_RULES
$(foreach cppfile,$(shell ls $(BOOSTDIR)/libs/$(1)/src/*.cpp),$(WORK_FOLDER)/$(1)/$(notdir $(cppfile:.cpp=.o)): $(cppfile) | $(WORK_FOLDER)/$(1)
		$(CXX) $(CXXFLAGS) -D BOOST_ALL_NO_LIB \
					-I$(BOOSTDIR) \
					-c $$^ \
					-o $$@
)
endef

#####
# define the build rules based on the files we find in the subfolders of
# the boost distro that correspond to our library names
#####
define BUILD_BOOST_LIB
$(WORK_FOLDER)/$(1): | $(WORK_FOLDER)
		@mkdir -p $$@
$(call MAKE_BOOST_LIB_COMPILE_RULES,$(1))
$(BOOST_LIB_DIR)/libboost_$(1).a: $(foreach cppfile,$(notdir $(shell ls $(BOOSTDIR)/libs/$(1)/src/*.cpp)),$(WORK_FOLDER)/$(1)/$(cppfile:.cpp=.o)) | $(BOOST_LIB_DIR)
		@ar r $$@ $$^
		@ranlib $$@
endef

#####
# dynamically generate the build rules from the list of libs
#####
$(foreach lib,$(BOOST_LIBS_TO_BUILD),$(eval $(call BUILD_BOOST_LIB,$(lib))))

.PHONY: clean
clean:
		@rm -rf $(WORK_FOLDER)
		@rm -rf $(BOOST_LIB_DIR)/*
		@echo "---- Done Cleaning Boost Libs ----"
