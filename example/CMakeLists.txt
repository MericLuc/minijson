if( ${BUILD_EXAMPLE} )
  project(miniJSON_example)

  set(CMAKE_CXX_STANDARD          17)
  set(CMAKE_CXX_STANDARD_REQUIRED ON)

  find_package(miniJSON REQUIRED)

  add_executable(${PROJECT_NAME} main.cpp)

  target_link_libraries(${PROJECT_NAME} miniJSON)

  install(
    TARGETS                      "${PROJECT_NAME}"
    RUNTIME         DESTINATION  "${CMAKE_INSTALL_BINDIR}"
  )

endif()