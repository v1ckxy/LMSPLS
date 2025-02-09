@echo off && setlocal EnableDelayedExpansion
rem VXN LMStudio Portable Launch Script (LMS PLS)

rem Modify in case you want to change in which GPU(s) you want to load models.
rem 0 (1st GPU), 1 (2nd), 2 (3rd) and so on. Specify multiple GPUs with commas: 1,2,3
set CUDA_VISIBLE_DEVICES=0

rem Get current path and set log file on it
cd /D "%~dp0"
set "CurrentPath=%CD%"

call "%CurrentPath%\launchLMS.cmd"