option(BUILD_WITH_COVERAGE "Build with coverage" OFF)
option(BUILD_WITH_SANITIZERS "Build with sanitizers" OFF)
option(BUILD_WITH_NO_EXCEPTIONS "Build with no exceptions" ${WORK_HPP_NO_EXCEPTIONS})
option(BUILD_WITH_NO_RTTI "Build with no RTTI" ${WORK_HPP_NO_RTTI})

set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set_property(GLOBAL PROPERTY PREDEFINED_TARGETS_FOLDER "CMake")
list(INSERT CMAKE_MODULE_PATH 0 "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(DisableExceptions)
include(DisableRTTI)
include(EnableASan)
include(EnableGCov)
include(EnableUBSan)
include(SetupTargets)

add_subdirectory(untests)
add_subdirectory(vendors)
