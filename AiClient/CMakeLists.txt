cmake_minimum_required(VERSION 3.16)

project(AiClient VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)
find_package(Qt6 REQUIRED COMPONENTS Quick Network)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appAiClient
    main.cpp
    aiclient.h
    aiclient.cpp
    Quick/QuickFramelessWindow.cpp
    Quick/QuickFramelessWindow.h
    Quick/private/QuickFramelessWindowPrivate.cpp
    Quick/private/QuickFramelessWindowPrivate.h
)

qt_add_qml_module(appAiClient
    URI AiClient
    VERSION 1.0
    QML_FILES
    Main.qml
    InputMessage.qml
    UserMessageItem.qml
    SystemMessageItem.qml
    LoadingIndicator.qml
    RESOURCES res.qrc
    QML_FILES TitleBar.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appAiClient PROPERTIES
    #    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appAiClient
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appAiClient
    PRIVATE Qt6::Quick Qt6::Network
    dwmapi
)

include(GNUInstallDirs)
install(TARGETS appAiClient
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
