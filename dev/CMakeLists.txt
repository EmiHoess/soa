add_executable(dev main.cpp)

target_link_libraries(
  dev
  PRIVATE __template__project_name::__template__project_name_options
          __template__project_name::__template__project_name_warnings
          )

#target_link_system_libraries(
#  dev
#  PRIVATE
#          )

