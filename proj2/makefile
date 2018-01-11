include ../shared/make_libs/gmsl
include ../shared/make_libs/helper_functions.mk

SHELL = /bin/sh

# project name (generate executable with this name)
TARGET   = projectname2

CC       = gcc
CXX      = g++
LINKER   = g++
BOOST_VER=_1_66_0

# change these to proper directories where each file should be
SRCDIR   = src
OBJDIR   = obj
BINDIR   = out
INCDIR   = include
LIBDIR   = lib
#shared directories
SHRINC	 = ../shared/include
SHRLIB	 = ../shared/lib
LIB_LIST=$(foreach item,$(basename $(notdir $(shell find $(SHRLIB) -name *.a))), $(call remove_prefix,$(item),lib))

BOOST_LIB= ../shared/lib_boost$(BOOST_VER)
BOOST_LIB_LIST=$(foreach item,$(basename $(notdir $(shell find $(BOOST_LIB) -name *.a))), $(call remove_prefix,$(item),lib))
BOOSTDIR = ../shared/boost$(BOOST_VER)

SOURCES  := $(wildcard $(SRCDIR)/*.cpp)
INCLUDES := $(wildcard $(INCDIR)/*.h) $(wildcard $(INCDIR)/*.hpp)
OBJECTS  := $(SOURCES:$(SRCDIR)/%.cpp=$(OBJDIR)/%.o)
LIBS		 = -lm -L$(LIBDIR) -L$(SHRLIB) -L$(BOOST_LIB)
rm       = rm -f

# compiling flags here
CFLAGS   = -Wall -I$(INCDIR) -I$(SHRINC) -I$(BOOSTDIR) -std=c++11
# linking flags here
LFLAGS   = -Wall -I$(INCDIR) -I$(SHRINC) -lm -L$(SHRLIB) $(addprefix  -l ,$(LIB_LIST)) -L$(BOOST_LIB) $(addprefix  -l ,$(BOOST_LIB_LIST))

$(BINDIR)/$(TARGET): $(OBJECTS)
		@$(LINKER) $(LFLAGS) $(OBJECTS) -o $@ $(LIBS)
		@echo "---- Done Linking ----"

$(OBJECTS): $(OBJDIR)/%.o : $(SRCDIR)/%.cpp
	@$(CXX) $(CFLAGS) -c $< -o $@
	@echo "Compiled "$<""

test-lists:
		@echo "lib-list: "$(BOOST_LIB_LIST)
		@echo "link flags: "$(LFLAGS)

.PHONY: clean
clean:
	@$(rm) $(OBJECTS)
	@echo "---- Done Cleaning "$(TARGET)"----"

.PHONY: remove
remove: clean
	@$(rm) $(BINDIR)/$(TARGET)
	@echo "---- Removed Output "$(TARGET)"----"

run:
	@./$(BINDIR)/$(TARGET)
