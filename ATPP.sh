#! /bin/bash

# Automatic Tractography-based Parcellation Pipeline (ATPP)
#
# ---- Single-ROI oriented brain parcellation
# ---- Automatic parallel computing
# ---- Modular and flexible structure
# ---- Simple and easy-to-use settings
#
# Usage: sh ATPP.sh atpp_gui_config.sh
# Hai Li (hai.li@nlpr.ia.ac.cn)
# ATPP V2.0


# Copyright (C) 2016  Hai Li
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


#==============================================================================
# Prerequisites:
# 1) Tools: FSL (with FDT toolbox), SGE and MATLAB (with SPM8)
# 2) Data files:
#    > T1 image for each subject
#    > b0 image for each subject
#    > images preprocessed by FSL(BedpostX) for each subject
#
# Directory structure:
#	  Working_dir
#     |-- sub1
#     |   |-- T1_sub1.nii
#     |   `-- b0_sub1.nii
#     |-- ...
#     |-- subN
#     |   |-- T1_subN.nii
#     |   `-- b0_subN.nii
#     |-- ROI
#     |   |-- ROI_L.nii
#     |   `-- ROI_R.nii
#     `-- log 
#==============================================================================

#==============================================================================
# Global configuration file
# Before running the pipeline, you NEED to modify parameters in the file.
#==============================================================================
set -o allexport
CONFIG=$1
if [ -f ${CONFIG} ]; then 
    source ${CONFIG}
fi

#==============================================================================
#----------------------------START OF SCRIPT-----------------------------------
#------------NO EDITING BELOW UNLESS YOU KNOW WHAT YOU ARE DOING---------------
#==============================================================================

# return id and log

mkdir -p ${WD}/log
LOG_DIR=${WD}/log
LOG=${LOG_DIR}/ATPP_log_$(date +%m-%d_%H-%M-%S).txt

if [ "${GE}" == "1" ]; then

echo "\
#!/bin/bash
#$ -V
#$ -cwd
#$ -N ATPP_${ROI}
#$ -o ${LOG_DIR}
#$ -e ${LOG_DIR}

bash ${PIPELINE}/pipeline.sh ${CONFIG} >${LOG} 2>&1" > ${LOG_DIR}/ATPP_${ROI}_qsub.sh

id=$(${COMMAND_QSUB} -terse ${WD}/log/ATPP_${ROI}_qsub.sh)
echo ${id}

else

bash ${PIPELINE}/pipeline.sh $1 >${LOG} 2>&1 &
id=$!
echo ${id}

fi

echo ${LOG}

#================================ END =======================================
