add_library(${PROJECT_NAME}.setup_targets INTERFACE)
add_library(${PROJECT_NAME}::setup_targets ALIAS ${PROJECT_NAME}.setup_targets)

target_link_libraries(${PROJECT_NAME}.setup_targets INTERFACE
    work.hpp.vendors::doctest
    work.hpp.vendors::fmt)

target_compile_options(${PROJECT_NAME}.setup_targets INTERFACE
    $<$<CXX_COMPILER_ID:MSVC>:
        /WX /W4>
    $<$<CXX_COMPILER_ID:GNU>:
        -Werror -Wall -Wextra -Wpedantic>
    $<$<OR:$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_ID:AppleClang>>:
        -Werror -Weverything -Wconversion
        -Wno-c++98-compat
        -Wno-c++98-compat-pedantic
        -Wno-ctad-maybe-unsupported
        -Wno-exit-time-destructors
        -Wno-padded
        -Wno-shadow-field-in-constructor
        -Wno-unneeded-internal-declaration
        -Wno-unused-macros
        -Wno-unused-member-function
        -Wno-weak-vtables
        >)

if(BUILD_WITH_COVERAGE)
    target_link_libraries(${PROJECT_NAME}.setup_targets INTERFACE
        work.hpp::enable_gcov)
endif()

if(BUILD_WITH_SANITIZERS)
    target_link_libraries(${PROJECT_NAME}.setup_targets INTERFACE
        work.hpp::enable_asan
        work.hpp::enable_ubsan)
endif()

if(BUILD_WITH_NO_EXCEPTIONS)
    target_link_libraries(${PROJECT_NAME}.setup_targets INTERFACE
        work.hpp::disable_exceptions)

    target_compile_definitions(${PROJECT_NAME}.setup_targets INTERFACE
        DOCTEST_CONFIG_NO_EXCEPTIONS_BUT_WITH_ALL_ASSERTS)
endif()

if(BUILD_WITH_NO_RTTI)
    target_link_libraries(${PROJECT_NAME}.setup_targets INTERFACE
        work.hpp::disable_rtti)
endif()
