cmake_minimum_required(VERSION 3.16)

project(
  cutter
  VERSION 0.1
  LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(
  Qt6 6.2
  COMPONENTS Quick
  REQUIRED)

qt_add_executable(appcutter main.cpp)

qt_add_qml_module(
  appcutter
  URI
  cutter
  VERSION
  1.0
  QML_FILES
  Window.qml
  QML_FILES
  Content.qml
  MyRadioButton.qml
  ListMessage.qml
  QML_FILES
  Dialogs.qml
  QML_FILES
  Buttons2.qml
  QML_FILES
  Buttons1.qml
  QML_FILES
  Controller.js
  SOURCES
  videoedit.h
  videoedit.cpp)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1. If
# you are developing for iOS or macOS you should consider setting an explicit,
# fixed bundle identifier manually though.
set_target_properties(
  appcutter
  PROPERTIES # MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appcutter
             MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
             MACOSX_BUNDLE_SHORT_VERSION_STRING
             ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
             MACOSX_BUNDLE TRUE
             WIN32_EXECUTABLE TRUE)

target_link_libraries(appcutter PRIVATE Qt6::Quick)

include(GNUInstallDirs)
install(
  TARGETS appcutter
  BUNDLE DESTINATION .
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
