if(NOT PROJECT_IS_TOP_LEVEL OR soa_PACKAGING_MAINTAINER_MODE)
  option(soa_ENABLE_PCH "Enable precompiled headers" OFF)
else()
  option(soa_ENABLE_PCH "Enable precompiled headers" OFF)
endif()