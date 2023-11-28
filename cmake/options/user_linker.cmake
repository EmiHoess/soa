if(NOT PROJECT_IS_TOP_LEVEL OR soa_PACKAGING_MAINTAINER_MODE)
  option(soa_WARNINGS_AS_ERRORS "Treat Warnings As Errors" OFF)
else()
  option(soa_WARNINGS_AS_ERRORS "Treat Warnings As Errors" ON)
endif()

macro(soa_user_linker_configure project_name)
  include(CheckCXXCompilerFlag)

  set(USER_LINKER_OPTION
      "lld"
      CACHE STRING "Linker to be used")
  set(USER_LINKER_OPTION_VALUES "lld" "gold" "bfd" "mold")
  set_property(CACHE USER_LINKER_OPTION PROPERTY STRINGS ${USER_LINKER_OPTION_VALUES})
  list(
    FIND
    USER_LINKER_OPTION_VALUES
    ${USER_LINKER_OPTION}
    USER_LINKER_OPTION_INDEX)

  if(${USER_LINKER_OPTION_INDEX} EQUAL -1)
    message(
      STATUS
        "Using custom linker: '${USER_LINKER_OPTION}', explicitly supported entries are ${USER_LINKER_OPTION_VALUES}")
  endif()

  if(NOT ENABLE_USER_LINKER)
    return()
  endif()

  set(LINKER_FLAG "-fuse-ld=${USER_LINKER_OPTION}")

  check_cxx_compiler_flag(${LINKER_FLAG} CXX_SUPPORTS_USER_LINKER)
  if(CXX_SUPPORTS_USER_LINKER)
    target_compile_options(${project_name} INTERFACE ${LINKER_FLAG})
  endif()
endmacro()
