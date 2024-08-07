QT += core
CONFIG += console c++17 testcase
TARGET = AutoTests

RESOURCES += \
    test_resources.qrc

SOURCES += test_main.cpp \
           filehandling_tests.cpp \
           ../../src/documentfile.cpp

HEADERS += ../../src/documentfile.h

contains(CONFIG, coverage) {
    message("Building with coverage support")
    QMAKE_CXXFLAGS += -fprofile-arcs -ftest-coverage
    QMAKE_LFLAGS += -fprofile-arcs -ftest-coverage
}

# Use catch2 for auto tests
PKGCONFIG += catch2

# target for coverage
coverage.commands = ./AutoTests && \
                    lcov --directory . --capture --output-file coverage_base.info && \
                    lcov --remove coverage_base.info '/usr/*' 'tests/auto' --output-file coverage.info -ignore-errors unused && \
                    genhtml coverage.info --output-directory coverage_report
coverage.depends = all
QMAKE_EXTRA_TARGETS += coverage

clean_coverage.commands = rm -f *.gcda *.gcno coverage.info coverage_base.info && rm -rf coverage_report
QMAKE_EXTRA_TARGETS += clean_coverage