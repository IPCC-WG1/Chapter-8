#!/bin/bash

# Generates ANN panel for figure 8-21 in the IPCC Working Group I Contribution to the Sixth Assessment Report: Chapter 8

# Creator : Stéphane Sénési stejase@laposte.net
# Version date : 20210328

# This script needs CAMMAC - see https://cammac.readthedocs.io/.

# It actually launches one of its notebooks (see last line), feeding
# it with some parameter values, through CAMMAC utility job_pm.sh
# Parameters are explained in CAMMAC doc for the launched notebbok

D=${CAMMAC:-/home/ssenesi/CAMMAC}

# Create a working directory specific to this figure. It will hold cached data
figname=$(basename $0)
figname=${figname/.sh/}
mkdir -p $figname
cd $figname


cat <<EOF >fig.yaml

figure_name               : Fig8-21-ANN
version                   : ""   
manual_title              : null
outdir                    :  ./figures 

variable                  :  P-E      
table                     :  Amon          
variable_transformation   :  plain         
season                    :  ANN  
experiment                :  ssp585 
#
ref_experiment            :  historical 
ref_period                : "1850-1900" 
proj_period               : "2015-2099" 
warming                   : 3.0         
window_half_size          : 10          
#
clim_experiment           :  piControl 
clim_period               : "1-100" 
#
field_type                :  mean
threshold                 : null
contour_mask              : $D/data/fixed_fields/sftlf_fx_CNRM-CM6-1_historical_r1i1p1f2_gr.nc 

included_models           : null
excluded_models           : [ ACCESS-ESM1-5, EC-Earth3-Veg, EC-Earth3 ]

plot_args : 
  color : AR6_Precip_12
  min   : -1
  max   : 1 
  delta : 0.2 
  aux_options : "|cnLineThicknessF=5.|cnLineColor=black|gsnContourZeroLineThicknessF=9."

clim_contours             : [ 0 ] 
figure_details            : { page_width : 2450, page_height : 3444,  insert_width : 2000, pt : 60,  ybox : 133, y : 40}
common_grid               :  r360x180 

EOF

# Launch a job in which papermill will execute the notebook, injecting above parameters
jobname=$figname
output=$figname
# Tell job_pm.sh to use co-located environment setting
export ENV_PM=$(cd $(dirname $0); pwd)/job_env.sh

# Tell job_pm.sh to use co-located parameters file 
commons=$(cd $(dirname $0); pwd)/common_parameters.yaml
[ ! -f $commons ] && $commons = ""

$D/jobs/job_pm.sh $D/notebooks/change_map_1var_at_WL_1SSP_with_clim.ipynb fig.yaml $jobname $output $commons

