if(NOT PROJECT_IS_TOP_LEVEL OR __template__project_name_PACKAGING_MAINTAINER_MODE)
  option(__template__project_name_ENABLE_SANITIZER_UNDEFINED "Enable address undefined" OFF)
else()
  option(__template__project_name_ENABLE_SANITIZER_UNDEFINED "Enable address undefined" ${SUPPORTS_ASAN})
endif()