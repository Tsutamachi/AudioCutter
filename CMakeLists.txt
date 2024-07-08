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
  # 下面是C++类的注册
  URI
  "se.qt.videoEditing"
  VERSION
  1.0
  QML_FILES
  Actions.qml
  Window.qml
  MySquareButton.qml
  MyRadioButton.qml
  MainContent.qml
  ListMessage.qml
  Dialogs.qml
  Cutter.js
  Content.qml
  SOURCES
  videoedit.h
  videoedit.cpp
  RESOURCE_PREFIX
  images.qrc
  RESOURCES
  images.qrc
  SOURCES  )

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

target_link_libraries(appCutter PRIVATE Qt6::Quick FFmpeg::FFmpeg)
include_directories("usr/bin/ffmpeg")
find_package(FFmpeg REQUIRED)
target_link_libraries(appCutter PRIVATE Qt6::Quick FFmpeg::FFmpeg)

include(GNUInstallDirs)
install(
  TARGETS appCutter
  BUNDLE DESTINATION .
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
