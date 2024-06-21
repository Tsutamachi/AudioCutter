cmake_minimum_required(VERSION 3.16)

project(
  Cutter
  VERSION 0.1
  LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(
  Qt6 6.2
  COMPONENTS Quick
  REQUIRED)

qt_add_executable(appCutter main.cpp)

qt_add_qml_module(
  appCutter
  URI
  Cutter
  VERSION
  1.0
  QML_FILES
  Window.qml
  QML_FILES
  MySquareButton.qml
  QML_FILES
  MyRadioButton.qml
  QML_FILES
  MainContent.qml
  QML_FILES
  ListMessage.qml
  QML_FILES
  Dialogs.qml
  QML_FILES
  Cutter.js
  QML_FILES
  Content.qml
  SOURCES
  videoedit.h
  videoedit.cpp)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1. If
# you are developing for iOS or macOS you should consider setting an explicit,
# fixed bundle identifier manually though.
set_target_properties(
  appCutter
  PROPERTIES # MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appCutter
             MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
             MACOSX_BUNDLE_SHORT_VERSION_STRING
             ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
             MACOSX_BUNDLE TRUE
             WIN32_EXECUTABLE TRUE)

target_link_libraries(appCutter PRIVATE Qt6::Quick)

include(GNUInstallDirs)
install(
  TARGETS appCutter
  BUNDLE DESTINATION .
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
