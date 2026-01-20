# ##############################################################################
# apps/examples/pinball/CMakeLists.txt
# Space Cadet Pinball for openvela
# ##############################################################################

if(CONFIG_EXAMPLES_PINBALL)
  
  # Collect all C++ source files
  file(GLOB PINBALL_SRCS
    ${CMAKE_CURRENT_SOURCE_DIR}/SpaceCadetPinball/*.cpp
  )
  
  # Remove platform-specific files that depend on SDL2
  list(FILTER PINBALL_SRCS EXCLUDE REGEX ".*imgui_impl_sdl.*")
  list(FILTER PINBALL_SRCS EXCLUDE REGEX ".*imgui_impl_sdlrenderer.*")
  
  nuttx_add_application(
    MODULE
    ${CONFIG_EXAMPLES_PINBALL}
    NAME
    ${CONFIG_EXAMPLES_PINBALL_PROGNAME}
    SRCS
    ${PINBALL_SRCS}
    INCLUDE_DIRECTORIES
    ${CMAKE_CURRENT_SOURCE_DIR}/SpaceCadetPinball
    STACKSIZE
    ${CONFIG_EXAMPLES_PINBALL_STACKSIZE}
    HEAPSIZE
    ${CONFIG_EXAMPLES_PINBALL_HEAPSIZE}
    PRIORITY
    ${CONFIG_EXAMPLES_PINBALL_PRIORITY}
    COMPILE_FLAGS
    -Wno-narrowing
    -Wno-unused-parameter
    -Wno-unused-variable
  )
  
endif()
