add_executable(dev main.cpp)

target_link_libraries(
  dev
  PRIVATE soa::soa_options
          soa::soa_warnings
          )

#target_link_system_libraries(
#  dev
#  PRIVATE
#          )

