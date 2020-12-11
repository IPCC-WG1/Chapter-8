#!/bin/bash

D=${CAMMAC:-/home/ssenesi/CAMMAC}

# Create a working sub-directory specific to this figure. It will hold cached data
figname=$(basename $0)
figname=${figname/.sh/}
wdir=${figname/_figure} # This in order to have same dir as compute phase, and find compute outputs in ./changes
mkdir -p $wdir
cd $wdir


# Create input parameters file 
cat <<EOF >fig.yaml

version               : ""
input_dir             :  ./changes 
outdir                :  ./figures 
figure_name           :  fig_BoxTS.X_f3_h 
panel                 :  h 
title                 : "Hydrological variables change over tropical land"
yaxis_title           : "% change "

scenarios             : [ ssp585 ]
excluded_models       : [ ]
#excluded_models       : [ CIESM , KACE-1-0-G , CAMS-CSM1-0, FIO-ESM-2-0, FGOALS-f3-L, MCM-UA-1-0 ]
#data_versions_tag     : 20200918

variables             : [[ pr , mean ],  [ mrro , mean ], [ pr , std ], [ mrro , std ], [ prw , mean ]]
option                :  mean 
combined_seasons    : [ tropics_annual ]

colors                : { tropics_annual   : {  pr : firebrick3 , mrro : blue3 , prw : gray40 , tas : gray40 }}
thicknesses           : { tropics_annual : 10.0}
xyMarkLineModes       : { mean : MarkLines , std : MarkLines }
xyDashPatterns        : { mean : 0, std : 1 }
xyMarkerSizes         : { pr_mean  : 0.015, mrro_mean  : 0.015, pr_std  : 0.01, mrro_std : 0.01,  prw_mean : 0.01, tas_mean : 0.015,  tas_std : 0.01}
nice                  : { pr : precipitation , prw : precipitable water , mrro : runoff ,
                          tropics_annual  : "Tropics annual", 
                          mean : "annual mean",  std  : "inter-annual variability",
                          ssp126 : SSP1-1.9 , ssp126 : SSP1-2.6 , ssp245 : SSP2-4.5 , ssp585 : SSP5-8.5 }
only_warmer_CI        : True  
show_variability_CI   : True
show_mean_CI          : True
show_tas_CI           : False
plot_intermediate_CIs : False
xy_ranges             : [ 1, 6.4, -9.0, 50.0 ]

max_warming_level   : 5.
min_models_nb       : 7

EOF

jobname=$figname
output=$figname
# Tell job_pm.sh to use co-located environment setting
export ENV_PM=$(cd $(dirname $0); pwd)/job_env.sh

# Tell job_pm.sh to use co-located parameters file 
commons=$(cd $(dirname $0); pwd)/common_parameters.yaml
[ ! -f $commons ] && $commons = ""

$D/jobs/job_pm.sh $D/notebooks/change_hybrid_seasons_dT_figure.ipynb fig.yaml $jobname $output $commons
