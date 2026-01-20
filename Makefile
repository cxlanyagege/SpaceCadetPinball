include $(APPDIR)/Make.defs

PROGNAME  = $(CONFIG_EXAMPLES_PINBALL_PROGNAME)
PRIORITY  = $(CONFIG_EXAMPLES_PINBALL_PRIORITY)
STACKSIZE = $(CONFIG_EXAMPLES_PINBALL_STACKSIZE)
HEAPSIZE  = $(CONFIG_EXAMPLES_PINBALL_HEAPSIZE)
MODULE    = $(CONFIG_EXAMPLES_PINBALL)

# Source files directory
PINBALL_DIR = SpaceCadetPinball

# Collect all C++ source files
CXXSRCS = $(wildcard $(PINBALL_DIR)/*.cpp)

# Exclude SDL-specific implementations
CXXSRCS := $(filter-out $(PINBALL_DIR)/imgui_impl_sdl.cpp,$(CXXSRCS))
CXXSRCS := $(filter-out $(PINBALL_DIR)/imgui_impl_sdlrenderer.cpp,$(CXXSRCS))

# Include path
CXXFLAGS += -I$(CURDIR)/$(PINBALL_DIR)
CXXFLAGS += -Wno-narrowing -Wno-unused-parameter -Wno-unused-variable

include $(APPDIR)/Application.mk

