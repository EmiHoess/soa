if(NOT PROJECT_IS_TOP_LEVEL OR __template__project_name_PACKAGING_MAINTAINER_MODE)
  option(__template__project_name_WARNINGS_AS_ERRORS "Treat Warnings As Errors" OFF)
else()
  option(__template__project_name_WARNINGS_AS_ERRORS "Treat Warnings As Errors" ON)
endif()


macro(set_warning_as_errors)
    if(__template__project_name_WARNINGS_AS_ERRORS)
    check_cxx_compiler_flag("-Wl,--fatal-warnings" LINKER_FATAL_WARNINGS)
    if(LINKER_FATAL_WARNINGS)
        # This is not working consistently, so disabling for now
        # target_link_options(__template__project_name_options INTERFACE -Wl,--fatal-warnings)
    endif()
    endif()
endmacro()