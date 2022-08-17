#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.1 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Tue Dec 28 10:28:01 CET 2021
# SW Build 2552052 on Fri May 24 14:47:09 MDT 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xelab -wto 3f071ffd6e094b4b829f4a7cb44664d9 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot processor_tb_behav xil_defaultlib.processor_tb -log elaborate.log"
xelab -wto 3f071ffd6e094b4b829f4a7cb44664d9 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot processor_tb_behav xil_defaultlib.processor_tb -log elaborate.log

