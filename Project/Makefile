#******************************************************************************
# Shell & Silent
#******************************************************************************
SHELL := /bin/bash
.SILENT:

#******************************************************************************
# Root directory
#******************************************************************************
ROOT_DIR := $(CURDIR)

#******************************************************************************
# Date & Time
#******************************************************************************
dDD := $(shell date +%d)
dMM := $(shell date +%m)
dYY := $(shell date +%Y)

tHH := $(shell date +%H)
tMM := $(shell date +%M)
tSS := $(shell date +%S)

#******************************************************************************
# Target & Build Mode
#******************************************************************************
TARGET_BASE ?= Project
BUILD ?= debug
RUN ?= false
TARGET := $(TARGET_BASE)_$(BUILD)
OUT_EXE := $(ROOT_DIR)/bin/$(TARGET).exe
MAP_FILE := $(ROOT_DIR)/build/$(TARGET).map
CPPCHECK_REPORT := $(BIN_DIR)/cppcheck_report.txt

#******************************************************************************
# Toolchain
#******************************************************************************
CXX := C:/msys64/mingw64/bin/g++.exe

#******************************************************************************
# Paths & Directories
#******************************************************************************
SRC_DIR := $(ROOT_DIR)/code
OBJ_DIR := $(ROOT_DIR)/build
BIN_DIR := $(ROOT_DIR)/bin
PROD_DIR := $(BIN_DIR)/PRODUCTION

#******************************************************************************
# Sources
#******************************************************************************
SRCS :=
SRCS += $(SRC_DIR)/main.cpp
SRCS += $(SRC_DIR)/Logger.cpp

RES_SRC := $(ROOT_DIR)/resource/resource.rc
OBJS := $(SRCS:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)
OBJS += $(OBJ_DIR)/resource.res.o
DEPS := $(OBJS:.o=.d)

#******************************************************************************
# Include Paths
#******************************************************************************
INCS :=
INCS += -I$(ROOT_DIR)/libs/wxWidget/include

ifeq ($(BUILD),debug)
	INCS += -I$(ROOT_DIR)/libs/wxWidget/lib/gcc_lib/mswud
else ifeq ($(BUILD),release)
	INCS += -I$(ROOT_DIR)/libs/wxWidget/lib/gcc_lib/mswu
endif

#******************************************************************************
# Library Paths (static build)
#******************************************************************************
LIB_DIRS :=
LIB_DIRS += -L$(ROOT_DIR)/libs/wxWidget/lib/gcc_lib

#******************************************************************************
# Libraries wxWidgets & Windows
#******************************************************************************
WX_LIBS_DEBUG += wxmsw32ud wxmsw32ud_gl wxexpatd wxjpegd wxpngd wxregexud wxscintillad wxtiffd wxzlibd
WX_LIBS_RELEASE += wxmsw32u wxmsw32u_gl wxexpat wxjpeg wxpng wxregexu wxscintilla wxtiff wxzlib

WIN_LIBS += kernel32 user32 gdi32 comdlg32 ole32 shell32 oleaut32 uuid comctl32 shlwapi version uxtheme winspool imm32 winmm advapi32 oleacc

#******************************************************************************
# Compiler Flags
#******************************************************************************
CXXFLAGS := -Wall -std=c++17 -m64
ifeq ($(BUILD),debug)
	CXXFLAGS += -g -O0 -DDEBUG -D__WXDEBUG__
	LIBS := $(foreach lib,$(WX_LIBS_DEBUG),-l$(lib))
else ifeq ($(BUILD),release)
	CXXFLAGS += -O2 -DNDEBUG
	LIBS := $(foreach lib,$(WX_LIBS_RELEASE),-l$(lib))
	LDFLAGS_EXTRA := -Wl,-subsystem,windows
else
$(error BUILD must be 'debug' or 'release')
endif

CXXFLAGS += $(INCS)
LIBS += $(foreach lib,$(WIN_LIBS),-l$(lib))

#******************************************************************************
# Linker Flags
#******************************************************************************
LDFLAGS := -Wl,-Bstatic -Wl,-Map=$(MAP_FILE) $(LIB_DIRS) $(LIBS)

#******************************************************************************
# Targets
#******************************************************************************
all: preBuild $(OUT_EXE) postBuild
ifeq ($(RUN),true)
	@echo ">> Running: $(OUT_EXE)"
	@$(OUT_EXE)
endif

$(OUT_EXE): $(OBJS)
	@echo "[LD] $@"
	@mkdir -p $(BIN_DIR)
	$(CXX) $^ -o $@ $(LDFLAGS_EXTRA) $(LDFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@echo "[CC] $<"
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -MMD -MP -c $< -o $@

$(OBJ_DIR)/resource.res.o: $(ROOT_DIR)/resource/resource.rc
	@echo "[RC] $<"
	@mkdir -p $(dir $@)
	windres $< -O coff -o $@

#******************************************************************************
# Pre/Post Build
#******************************************************************************
preBuild:
	@echo "[PREBUILD]"

postBuild:
	@echo "[POSTBUILD] $(dDD).$(dMM).$(dYY) $(tHH):$(tMM):$(tSS)"
	@echo "Build finished successfully."
	@echo
	@echo "--- Executable size:"
	@du -h $(OUT_EXE)
	@echo
	@echo "--- Memory sections (from size):"
	@size $(OUT_EXE)
	@echo

#******************************************************************************
# Clean
#******************************************************************************
clean:
	@echo "[CLEAN]"
	@rm -rf $(OBJ_DIR) $(BIN_DIR)

#******************************************************************************
# Lint
#******************************************************************************
lint:
	@echo "[LINT] Running cppcheck..."
	@cppcheck --enable=all --inconclusive --std=c++17 --force --inline-suppr --suppress=missingIncludeSystem \
		--template=gcc --color=always --output-file=$(CPPCHECK_REPORT) \
		$(SRC_DIR) 2> >(tee $(CPPCHECK_REPORT) >&2)
	@echo "[LINT] Report saved to: $(CPPCHECK_REPORT)"
	@echo

#******************************************************************************
# Utilities
#******************************************************************************
run: $(OUT_EXE)
	@$<

size: $(OUT_EXE)
	@echo "--- File size (du -h):"
	@du -h $<
	@echo "--- Section sizes (size):"
	@size $<

help:
	@echo "make [BUILD=debug|release] [RUN=true]"
	@echo "make clean"
	@echo "make run"
	@echo "make size"
	@echo "make lint"
	@echo "make print"
	@echo "make ver"
	@echo "make dateAndTime"

print:
	@echo "SRCS: $(SRCS)"
	@echo "OBJS: $(OBJS)"
	@echo "DEPS: $(DEPS)"
	@echo "TARGET: $(OUT_EXE)"

ver:
	@echo "GCC Version: $$($(CXX) -dumpversion)"

dateAndTime:
	@echo "Date: $(dDD).$(dMM).$(dYY)"
	@echo "Time: $(tHH):$(tMM):$(tSS)"

#******************************************************************************
# Dependency Includes
#******************************************************************************
.PHONY: all clean run help print ver dateAndTime lint
-include $(DEPS)
