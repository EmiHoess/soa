macro(add_default_options_library name SOURCES)
    add_library(name ${SOURCES})
    add_library(__template__project_name::name ALIAS name)
    target_link_libraries(name PRIVATE __template__project_name_options __template__project_name_warnings)
    target_include_directories(name ${WARNING_GUARD} PUBLIC $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
                                                                    $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include>)
    target_compile_features(name PUBLIC cxx_std_20)
    set_target_properties(
    name
    PROPERTIES VERSION ${PROJECT_VERSION}
                CXX_VISIBILITY_PRESET hidden
                VISIBILITY_INLINES_HIDDEN YES)
    if(NOT BUILD_SHARED_LIBS)
        target_compile_definitions(name PUBLIC name_STATIC_DEFINE)
    endif()
endmacro()