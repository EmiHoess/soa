if(__template__project_name_ENABLE_HARDENING AND NOT __template__project_name_ENABLE_GLOBAL_HARDENING)
  if(NOT SUPPORTS_UBSAN 
    OR __template__project_name_ENABLE_SANITIZER_UNDEFINED
    OR __template__project_name_ENABLE_SANITIZER_ADDRESS
    OR __template__project_name_ENABLE_SANITIZER_THREAD
    OR __template__project_name_ENABLE_SANITIZER_LEAK)
    set(ENABLE_UBSAN_MINIMAL_RUNTIME FALSE)
  else()
    set(ENABLE_UBSAN_MINIMAL_RUNTIME TRUE)
  endif()
endif()