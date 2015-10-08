include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}
)

set(
    IntervalTimerbackend_SRCS
    modules/IntervalTimer/backend.cpp
    modules/IntervalTimer/mytype.cpp
)

# Make the unit test files visible on qtcreator
add_custom_target(IntervalTimerbackend_UNITTEST_QML_FILES ALL SOURCES "tests/unit/tst_mytype.qml")

add_library(IntervalTimerbackend MODULE
    ${IntervalTimerbackend_SRCS}
)

set_target_properties(IntervalTimerbackend PROPERTIES
         LIBRARY_OUTPUT_DIRECTORY IntervalTimer)

qt5_use_modules(IntervalTimerbackend Gui Qml Quick)

# Copy qmldir file to build dir for running in QtCreator
add_custom_target(IntervalTimerbackend-qmldir ALL
    COMMAND cp ${CMAKE_CURRENT_SOURCE_DIR}/modules/IntervalTimer/qmldir ${CMAKE_CURRENT_BINARY_DIR}/IntervalTimer
    DEPENDS ${QMLFILES}
)

# Install plugin file
install(TARGETS IntervalTimerbackend DESTINATION ${QT_IMPORTS_DIR}/IntervalTimer/)
install(FILES   modules/IntervalTimer/qmldir DESTINATION ${QT_IMPORTS_DIR}/IntervalTimer/)

