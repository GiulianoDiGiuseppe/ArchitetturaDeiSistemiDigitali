#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.1 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Wed Oct 27 17:58:42 CEST 2021
# SW Build 2552052 on Fri May 24 14:47:09 MDT 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xelab -wto e6f38f92babf4f02b8089ee2a3907c53 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot Riconoscitore_Mealy_2_Modi_01_TB_behav xil_defaultlib.Riconoscitore_Mealy_2_Modi_01_TB -log elaborate.log"
xelab -wto e6f38f92babf4f02b8089ee2a3907c53 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot Riconoscitore_Mealy_2_Modi_01_TB_behav xil_defaultlib.Riconoscitore_Mealy_2_Modi_01_TB -log elaborate.log

