if(NOT PROJECT_IS_TOP_LEVEL OR __template__project_name_PACKAGING_MAINTAINER_MODE)
  option(__template__project_name_ENABLE_SANITIZER_ADDRESS "Enable undefined sanitizer" OFF)
else()
  option(__template__project_name_ENABLE_SANITIZER_ADDRESS "Enable undefined sanitizer" ${SUPPORTS_UBSAN})
endif()