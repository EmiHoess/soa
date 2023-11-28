include(cmake/utils/system_library.cmake)
#include(cmake/LibFuzzer.cmake)
include(CMakeDependentOption)
include(CheckCXXCompilerFlag)

include(cmake/utils/compiler_warnings.cmake)
include(cmake/settings/sanitizers.cmake)

set (L_PROJECT_NAME soa)
set (L_PROJECT_VERSION "0.0.1")
set (L_DESCRIPTION "")
set (L_HOMEPAGE_URL "url")
set (L_LANGUAGES CXX C)



macro(soa_setup_options)
  include(cmake/options/hardening.cmake)
  include(cmake/options/hardening.cmake)
  include(cmake/options/hardening.cmake)
  #option(soa_ENABLE_HARDENING "Enable hardening" ON)
  #option(soa_ENABLE_COVERAGE "Enable coverage reporting" OFF)
  
  #cmake_dependent_option(
  #  soa_ENABLE_GLOBAL_HARDENING
  #  "Attempt to push hardening options to built dependencies"
  #  ON
  #  soa_ENABLE_HARDENING
  #  OFF)

  #soa_supports_sanitizers()
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

  if(NOT PROJECT_IS_TOP_LEVEL OR soa_PACKAGING_MAINTAINER_MODE)
    #option(soa_ENABLE_IPO "Enable IPO/LTO" OFF)
    #option(soa_WARNINGS_AS_ERRORS "Treat Warnings As Errors" OFF)
    #option(soa_ENABLE_USER_LINKER "Enable user-selected linker" OFF)
    #option(soa_ENABLE_SANITIZER_ADDRESS "Enable address sanitizer" OFF)
    #option(soa_ENABLE_SANITIZER_LEAK "Enable leak sanitizer" OFF)
    #option(soa_ENABLE_SANITIZER_UNDEFINED "Enable undefined sanitizer" OFF)
    #option(soa_ENABLE_SANITIZER_THREAD "Enable thread sanitizer" OFF)
    #option(soa_ENABLE_SANITIZER_MEMORY "Enable memory sanitizer" OFF)
    #option(soa_ENABLE_UNITY_BUILD "Enable unity builds" OFF)
    #option(soa_ENABLE_CLANG_TIDY "Enable clang-tidy" OFF)
    #option(soa_ENABLE_CPPCHECK "Enable cpp-check analysis" OFF)
    #option(soa_ENABLE_PCH "Enable precompiled headers" OFF)
    #option(soa_ENABLE_CACHE "Enable ccache" OFF)
  else()
    #option(soa_ENABLE_IPO "Enable IPO/LTO" ON)
    #option(soa_WARNINGS_AS_ERRORS "Treat Warnings As Errors" ON)
    #option(soa_ENABLE_USER_LINKER "Enable user-selected linker" OFF)
    #option(soa_ENABLE_SANITIZER_ADDRESS "Enable address sanitizer" ${SUPPORTS_ASAN})
    #option(soa_ENABLE_SANITIZER_LEAK "Enable leak sanitizer" OFF)
    #option(soa_ENABLE_SANITIZER_UNDEFINED "Enable undefined sanitizer" ${SUPPORTS_UBSAN})
    #option(soa_ENABLE_SANITIZER_THREAD "Enable thread sanitizer" OFF)
    #option(soa_ENABLE_SANITIZER_MEMORY "Enable memory sanitizer" OFF)
    #option(soa_ENABLE_UNITY_BUILD "Enable unity builds" OFF)
    #option(soa_ENABLE_CLANG_TIDY "Enable clang-tidy" ON)
    #option(soa_ENABLE_CPPCHECK "Enable cpp-check analysis" ON)
    #option(soa_ENABLE_PCH "Enable precompiled headers" OFF)
    #option(soa_ENABLE_CACHE "Enable ccache" ON)
  endif()

  if(NOT PROJECT_IS_TOP_LEVEL)
    mark_as_advanced(
      soa_ENABLE_IPO
      soa_WARNINGS_AS_ERRORS
      soa_ENABLE_USER_LINKER
      soa_ENABLE_SANITIZER_ADDRESS
      soa_ENABLE_SANITIZER_LEAK
      soa_ENABLE_SANITIZER_UNDEFINED
      soa_ENABLE_SANITIZER_THREAD
      soa_ENABLE_SANITIZER_MEMORY
      soa_ENABLE_UNITY_BUILD
      soa_ENABLE_CLANG_TIDY
      soa_ENABLE_CPPCHECK
      #soa_ENABLE_COVERAGE
      soa_ENABLE_PCH
      soa_ENABLE_CCACHE)
  endif()

  #soa_check_libfuzzer_support(LIBFUZZER_SUPPORTED)
  #if(LIBFUZZER_SUPPORTED AND (soa_ENABLE_SANITIZER_ADDRESS OR soa_ENABLE_SANITIZER_THREAD OR soa_ENABLE_SANITIZER_UNDEFINED))
  #  set(DEFAULT_FUZZER ON)
  #else()
  #  set(DEFAULT_FUZZER OFF)
  #endif()
  #option(soa_BUILD_FUZZ_TESTS "Enable fuzz testing executable" ${DEFAULT_FUZZER})

endmacro()

macro(soa_global_options)
  #if(soa_ENABLE_IPO)
  soa_enable_ipo()
 
  #soa_enable_ipo()
  #endif()

  #soa_supports_sanitizers()
  include(cmake/options/sanitizers_support.cmake)
  include(cmake/options/dependent/sanitizer_ub_minimal.cmake)
  if(soa_ENABLE_HARDENING AND NOT soa_ENABLE_GLOBAL_HARDENING)
    message("${soa_ENABLE_HARDENING} ${ENABLE_UBSAN_MINIMAL_RUNTIME} ${soa_ENABLE_SANITIZER_UNDEFINED}")
    soa_enable_hardening(soa_options OFF ${ENABLE_UBSAN_MINIMAL_RUNTIME})
  endif()
endmacro()

macro(soa_local_options)
  if(PROJECT_IS_TOP_LEVEL)
    include(cmake/settings/standard_project.cmake)
  endif()

  add_library(soa_warnings INTERFACE)
  add_library(soa_options INTERFACE)

  #include(cmake/CompilerWarnings.cmake)

  soa_set_project_warnings(
    soa_warnings
    ${soa_WARNINGS_AS_ERRORS}
    ""
    ""
    ""
    "")

  if(soa_ENABLE_USER_LINKER)
  #  include(cmake/Linker.cmake)
    soa_user_linker_configure(soa_options)
  endif()

  soa_enable_sanitizers(
    soa_options
    ${soa_ENABLE_SANITIZER_ADDRESS}
    ${soa_ENABLE_SANITIZER_LEAK}
    ${soa_ENABLE_SANITIZER_UNDEFINED}
    ${soa_ENABLE_SANITIZER_THREAD}
    ${soa_ENABLE_SANITIZER_MEMORY})

  set_target_properties(soa_options PROPERTIES UNITY_BUILD ${soa_ENABLE_UNITY_BUILD})

  if(soa_ENABLE_PCH)
    target_precompile_headers(
      soa_options
      INTERFACE
      <vector>
      <string>
      <utility>)
  endif()

  if(soa_ENABLE_CCACHE)
    #include(cmake/Cache.cmake)
    soa_enable_cache()
  endif()

  #include(cmake/StaticAnalyzers.cmake)
  if(soa_ENABLE_CLANG_TIDY)
    soa_enable_clang_tidy(soa_options ${soa_WARNINGS_AS_ERRORS})
  endif()

  if(soa_ENABLE_CPPCHECK)
    soa_enable_cppcheck(${soa_WARNINGS_AS_ERRORS} "" # override cppcheck options
    )
  endif()

  #if(soa_ENABLE_COVERAGE)
  #  include(cmake/Tests.cmake)
  #  soa_enable_coverage(soa_options)
  #endif()

  set_warning_as_errors()

  include(cmake/options/dependent/sanitizer_ub_minimal.cmake)
  if(soa_ENABLE_HARDENING AND NOT soa_ENABLE_GLOBAL_HARDENING)
    soa_enable_hardening(soa_options OFF ${ENABLE_UBSAN_MINIMAL_RUNTIME})
  endif()

endmacro()
