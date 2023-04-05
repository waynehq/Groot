
if (EXPECTED_REGISTRY_VIEW STREQUAL "UNDEFINED")
  if (DEFINED ${CMAKE_FIND_PACKAGE_NAME}_FIND_REGISTRY_VIEW)
    message(SEND_ERROR "${CMAKE_FIND_PACKAGE_NAME}_FIND_REGISTRY_VIEW: unexpectedly defined as '${${CMAKE_FIND_PACKAGE_NAME}_FIND_REGISTRY_VIEW}' instead of '${EXPECTED_REGISTRY_VIEW}'")
  endif()
  return()
endif()

if (NOT ${CMAKE_FIND_PACKAGE_NAME}_FIND_REGISTRY_VIEW STREQUAL EXPECTED_REGISTRY_VIEW)
  message(SEND_ERROR "${CMAKE_FIND_PACKAGE_NAME}_FIND_REGISTRY_VIEW: '${${CMAKE_FIND_PACKAGE_NAME}_FIND_REGISTRY_VIEW}' instead of '${EXPECTED_REGISTRY_VIEW}'")
endif()
