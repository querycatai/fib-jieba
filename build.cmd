@echo off

REM The addon repositories are single CMake projects: the entry script of the
REM addon platform (fib-addon) calls the shared build driver, which configures
REM and builds the project of this directory in one pass:
REM
REM   build.cmd x64 release -j8

cd /d "%~dp0"

call "fib-addon\scripts\build.cmd" %*
