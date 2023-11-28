include(cmake/utils/system_library.cmake)
#include(cmake/LibFuzzer.cmake)
include(CMakeDependentOption)
include(CheckCXXCompilerFlag)

include(cmake/utils/compiler_warnings.cmake)
include(cmake/settings/sanitizers.cmake)

set (L_PROJECT_NAME __template__project_name)
set (L_PROJECT_VERSION "0.0.1")
set (L_DESCRIPTION "")
set (L_HOMEPAGE_URL "url")
set (L_LANGUAGES CXX C)



macro(__template__project_name_setup_options)
  include(cmake/options/hardening.cmake)
  include(cmake/options/hardening.cmake)
  include(cmake/options/hardening.cmake)
  #option(__template__project_name_ENABLE_HARDENING "Enable hardening" ON)
  #option(__template__project_name_ENABLE_COVERAGE "Enable coverage reporting" OFF)
  
  #cmake_dependent_option(
  #  __template__project_name_ENABLE_GLOBAL_HARDENING
  #  "Attempt to push hardening options to built dependencies"
  #  ON
  #  __template__project_name_ENABLE_HARDENING
  #  OFF)

  #__template__project_name_supports_sanitizers()
  include(cmake/options/sanitizers_support.cmake)
  include(cmake/options/hardening.cmake)
  include(cmake/options/hardening.cmake)
  include(cmake/options/interprocedural_optimization.cmake)
  include(cmake/options/warnings_as_errors.cmake)
  include(cmake/options/user_linker.cmake)

  include(cmake/options/sanitizer_address.cmake)
  include(cmake/options/sanitizer_leak.cmake)
  include(cmake/options/sanitizer_undefined.cmake)
  include(cmake/options/sanitizer_thread.cmake)
  include(cmake/options/sanitizer_memory.cmake)

  include(cmake/options/unity_build.cmake)
  include(cmake/options/clang_tidy.cmake)
  include(cmake/options/cppcheck.cmake)
  include(cmake/options/cppcheck.cmake)
  include(cmake/options/cppcheck.cmake)
  include(cmake/options/precompiled_headers.cmake)
  include(cmake/options/ccache.cmake)

  if(NOT PROJECT_IS_TOP_LEVEL OR __template__project_name_PACKAGING_MAINTAINER_MODE)
    #option(__template__project_name_ENABLE_IPO "Enable IPO/LTO" OFF)
    #option(__template__project_name_WARNINGS_AS_ERRORS "Treat Warnings As Errors" OFF)
    #option(__template__project_name_ENABLE_USER_LINKER "Enable user-selected linker" OFF)
    #option(__template__project_name_ENABLE_SANITIZER_ADDRESS "Enable address sanitizer" OFF)
    #option(__template__project_name_ENABLE_SANITIZER_LEAK "Enable leak sanitizer" OFF)
    #option(__template__project_name_ENABLE_SANITIZER_UNDEFINED "Enable undefined sanitizer" OFF)
    #option(__template__project_name_ENABLE_SANITIZER_THREAD "Enable thread sanitizer" OFF)
    #option(__template__project_name_ENABLE_SANITIZER_MEMORY "Enable memory sanitizer" OFF)
    #option(__template__project_name_ENABLE_UNITY_BUILD "Enable unity builds" OFF)
    #option(__template__project_name_ENABLE_CLANG_TIDY "Enable clang-tidy" OFF)
    #option(__template__project_name_ENABLE_CPPCHECK "Enable cpp-check analysis" OFF)
    #option(__template__project_name_ENABLE_PCH "Enable precompiled headers" OFF)
    #option(__template__project_name_ENABLE_CACHE "Enable ccache" OFF)
  else()
    #option(__template__project_name_ENABLE_IPO "Enable IPO/LTO" ON)
    #option(__template__project_name_WARNINGS_AS_ERRORS "Treat Warnings As Errors" ON)
    #option(__template__project_name_ENABLE_USER_LINKER "Enable user-selected linker" OFF)
    #option(__template__project_name_ENABLE_SANITIZER_ADDRESS "Enable address sanitizer" ${SUPPORTS_ASAN})
    #option(__template__project_name_ENABLE_SANITIZER_LEAK "Enable leak sanitizer" OFF)
    #option(__template__project_name_ENABLE_SANITIZER_UNDEFINED "Enable undefined sanitizer" ${SUPPORTS_UBSAN})
    #option(__template__project_name_ENABLE_SANITIZER_THREAD "Enable thread sanitizer" OFF)
    #option(__template__project_name_ENABLE_SANITIZER_MEMORY "Enable memory sanitizer" OFF)
    #option(__template__project_name_ENABLE_UNITY_BUILD "Enable unity builds" OFF)
    #option(__template__project_name_ENABLE_CLANG_TIDY "Enable clang-tidy" ON)
    #option(__template__project_name_ENABLE_CPPCHECK "Enable cpp-check analysis" ON)
    #option(__template__project_name_ENABLE_PCH "Enable precompiled headers" OFF)
    #option(__template__project_name_ENABLE_CACHE "Enable ccache" ON)
  endif()

  if(NOT PROJECT_IS_TOP_LEVEL)
    mark_as_advanced(
      __template__project_name_ENABLE_IPO
      __template__project_name_WARNINGS_AS_ERRORS
      __template__project_name_ENABLE_USER_LINKER
      __template__project_name_ENABLE_SANITIZER_ADDRESS
      __template__project_name_ENABLE_SANITIZER_LEAK
      __template__project_name_ENABLE_SANITIZER_UNDEFINED
      __template__project_name_ENABLE_SANITIZER_THREAD
      __template__project_name_ENABLE_SANITIZER_MEMORY
      __template__project_name_ENABLE_UNITY_BUILD
      __template__project_name_ENABLE_CLANG_TIDY
      __template__project_name_ENABLE_CPPCHECK
      #__template__project_name_ENABLE_COVERAGE
      __template__project_name_ENABLE_PCH
      __template__project_name_ENABLE_CCACHE)
  endif()

  #__template__project_name_check_libfuzzer_support(LIBFUZZER_SUPPORTED)
  #if(LIBFUZZER_SUPPORTED AND (__template__project_name_ENABLE_SANITIZER_ADDRESS OR __template__project_name_ENABLE_SANITIZER_THREAD OR __template__project_name_ENABLE_SANITIZER_UNDEFINED))
  #  set(DEFAULT_FUZZER ON)
  #else()
  #  set(DEFAULT_FUZZER OFF)
  #endif()
  #option(__template__project_name_BUILD_FUZZ_TESTS "Enable fuzz testing executable" ${DEFAULT_FUZZER})

endmacro()

macro(__template__project_name_global_options)
  #if(__template__project_name_ENABLE_IPO)
  __template__project_name_enable_ipo()
 
  #__template__project_name_enable_ipo()
  #endif()

  #__template__project_name_supports_sanitizers()
  include(cmake/options/sanitizers_support.cmake)
  include(cmake/options/dependent/sanitizer_ub_minimal.cmake)
  if(__template__project_name_ENABLE_HARDENING AND NOT __template__project_name_ENABLE_GLOBAL_HARDENING)
    message("${__template__project_name_ENABLE_HARDENING} ${ENABLE_UBSAN_MINIMAL_RUNTIME} ${__template__project_name_ENABLE_SANITIZER_UNDEFINED}")
    __template__project_name_enable_hardening(__template__project_name_options OFF ${ENABLE_UBSAN_MINIMAL_RUNTIME})
  endif()
endmacro()

macro(__template__project_name_local_options)
  if(PROJECT_IS_TOP_LEVEL)
    include(cmake/settings/standard_project.cmake)
  endif()

  add_library(__template__project_name_warnings INTERFACE)
  add_library(__template__project_name_options INTERFACE)

  #include(cmake/CompilerWarnings.cmake)

  __template__project_name_set_project_warnings(
    __template__project_name_warnings
    ${__template__project_name_WARNINGS_AS_ERRORS}
    ""
    ""
    ""
    "")

  if(__template__project_name_ENABLE_USER_LINKER)
  #  include(cmake/Linker.cmake)
    __template__project_name_user_linker_configure(__template__project_name_options)
  endif()

  __template__project_name_enable_sanitizers(
    __template__project_name_options
    ${__template__project_name_ENABLE_SANITIZER_ADDRESS}
    ${__template__project_name_ENABLE_SANITIZER_LEAK}
    ${__template__project_name_ENABLE_SANITIZER_UNDEFINED}
    ${__template__project_name_ENABLE_SANITIZER_THREAD}
    ${__template__project_name_ENABLE_SANITIZER_MEMORY})

  set_target_properties(__template__project_name_options PROPERTIES UNITY_BUILD ${__template__project_name_ENABLE_UNITY_BUILD})

  if(__template__project_name_ENABLE_PCH)
    target_precompile_headers(
      __template__project_name_options
      INTERFACE
      <vector>
      <string>
      <utility>)
  endif()

  if(__template__project_name_ENABLE_CCACHE)
    #include(cmake/Cache.cmake)
    __template__project_name_enable_cache()
  endif()

  #include(cmake/StaticAnalyzers.cmake)
  if(__template__project_name_ENABLE_CLANG_TIDY)
    __template__project_name_enable_clang_tidy(__template__project_name_options ${__template__project_name_WARNINGS_AS_ERRORS})
  endif()

  if(__template__project_name_ENABLE_CPPCHECK)
    __template__project_name_enable_cppcheck(${__template__project_name_WARNINGS_AS_ERRORS} "" # override cppcheck options
    )
  endif()

  #if(__template__project_name_ENABLE_COVERAGE)
  #  include(cmake/Tests.cmake)
  #  __template__project_name_enable_coverage(__template__project_name_options)
  #endif()

  set_warning_as_errors()

  include(cmake/options/dependent/sanitizer_ub_minimal.cmake)
  if(__template__project_name_ENABLE_HARDENING AND NOT __template__project_name_ENABLE_GLOBAL_HARDENING)
    __template__project_name_enable_hardening(__template__project_name_options OFF ${ENABLE_UBSAN_MINIMAL_RUNTIME})
  endif()

endmacro()
