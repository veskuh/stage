QT += core
CONFIG += console c++17 testcase
TARGET = AutoTests

SOURCES += test_main.cpp \
           filehandling_tests.cpp \
           ../../src/documentfile.cpp

HEADERS += ../../src/documentfile.h

# Use catch2 for auto tests
PKGCONFIG += catch2
