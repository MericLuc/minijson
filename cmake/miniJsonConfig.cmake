add_library(${LIBRARY_NAME} ${LIB_TYPE} ${SOURCES})
add_library(${PROJECT_NAME}::${LIBRARY_NAME} 
  ALIAS ${LIBRARY_NAME})

find_package(PkgConfig REQUIRED)
pkg_check_modules(JSON_C REQUIRED json-c)

set_target_properties(${LIBRARY_NAME} PROPERTIES LINKER_LANGUAGE     CXX                 )
set_target_properties(${LIBRARY_NAME} PROPERTIES PUBLIC_HEADER       "${HEADERS_PUBLIC}" )
set_target_properties(${LIBRARY_NAME} PROPERTIES OUTPUT_NAME         "${LIBRARY_NAME}"   )
set_target_properties(${LIBRARY_NAME} PROPERTIES SUFFIX              "${LIB_SUFFIX}"     )
set_target_properties(${LIBRARY_NAME} PROPERTIES PREFIX              "lib"               )

target_compile_definitions(
    ${LIBRARY_NAME} 
    PUBLIC
        "${PROJECT_NAME_UPPERCASE}_DEBUG=$<CONFIG:Debug>")

target_include_directories(
    ${LIBRARY_NAME} 
    PUBLIC
        "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}>"
        "$<BUILD_INTERFACE:${GENERATED_HEADERS_DIR}>"
        "$<INSTALL_INTERFACE:.>"
)

target_link_libraries(
    ${LIBRARY_NAME}
    PRIVATE
        ${JSON_C_LIBRARIES}
)

install(
    TARGETS                      "${LIBRARY_NAME}"
    EXPORT                       "${TARGETS_EXPORT_NAME}"
    LIBRARY         DESTINATION  "${CMAKE_INSTALL_LIBDIR}"
    ARCHIVE         DESTINATION  "${CMAKE_INSTALL_LIBDIR}"
    RUNTIME         DESTINATION  "${CMAKE_INSTALL_BINDIR}"
    INCLUDES        DESTINATION  "${CMAKE_INSTALL_INCLUDEDIR}"
    PUBLIC_HEADER   DESTINATION  "${CMAKE_INSTALL_INCLUDEDIR}/${LIBRARY_FOLDER}"
)

install(
    FILES       "${GENERATED_HEADERS_DIR}/${LIBRARY_FOLDER}/version.h"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/${LIBRARY_FOLDER}"
)

install(
    FILES       "${PROJECT_CONFIG_FILE}"
                "${VERSION_CONFIG_FILE}"
    DESTINATION "${CONFIG_INSTALL_DIR}"
)

install(
  EXPORT      "${TARGETS_EXPORT_NAME}"
  FILE        "${PROJECT_NAME}Targets.cmake"
  DESTINATION "${CONFIG_INSTALL_DIR}"
  NAMESPACE   "${PROJECT_NAME}::"
)

set(prefix      ${CMAKE_INSTALL_PREFIX})
set(exec_prefix ${CMAKE_INSTALL_PREFIX})
set(libdir      ${CMAKE_INSTALL_LIBDIR})
set(includedir  ${CMAKE_INSTALL_INCLUDEDIR})
set(LIBS        "-l${JSON_C_LIBRARIES}")

configure_file("${PROJECT_SOURCE_DIR}/libminijson.pc.in"
               "${GENERATED_DIR}/libminijson.pc" @ONLY)
install(FILES "${GENERATED_DIR}/libminijson.pc"
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig)
