@echo off
REM ****************************************************************************
REM Vivado (TM) v2019.1.3 (64-bit)
REM
REM Filename    : elaborate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for elaborating the compiled design
REM
REM Generated by Vivado on Sat Feb 19 12:48:28 +0100 2022
REM SW Build 2644227 on Wed Sep  4 09:45:24 MDT 2019
REM
REM Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
REM
REM usage: elaborate.bat
REM
REM ****************************************************************************
echo "xelab -wto c5940ffbbe4742d6887be50915638e62 --incr --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot cronometroTB_behav xil_defaultlib.cronometroTB -log elaborate.log"
call xelab  -wto c5940ffbbe4742d6887be50915638e62 --incr --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot cronometroTB_behav xil_defaultlib.cronometroTB -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
