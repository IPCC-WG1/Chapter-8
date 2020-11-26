#!/bin/bash

D=/home/ssenesi/CAMMAC

# Create a working sub-directory specific to this figure. It will hold cached data
figname=$(basename $0)
figname=${figname/.sh/}
wdir=${figname/_figure} # This in order to execute in the same directory as companion notebook for getting cached data
mkdir -p $wdir
cd $wdir


# Create input parameters file 
cat <<EOF >fig_figure.yaml

version               : ""
figure_name           :  Fig8-15
outdir                :  ./figures 
indir                 :  ./changes    # Location for compute phase outputs
scenario              :   ssp585 
variables             : [( pr , mean ),( pr , std ),( prw , mean ),( mrro , mean ),( mrro , std )]
seasons               : [ tropics_JJA , tropics_DJF , extra_summer , extra_winter ]
excluded_models       : { mrro : [  CAMS-CSM1-0  ]}
ensemble_stat         :  nq95  



########################################
# Plot tuning (Ncl/PyNgl conventions)
########################################

layout      : [2,2] 
title       : "Dependency of hydrological variables land averages with global warming ~Z70~~C~Evaluated for SSP5-8.5 on overlapping periods : [2021-2040],[2031-2050] ...[2081-2100]"
yaxis_title : "%% change in land averages (mean over %d CMIP6 models)~Z75~~C~Error bars show 5%%-95%% percentiles"
xaxis_title : "Global temperature change vs. %s (C)"
#
seasons_description : [ "a) Tropics JJA", 
                        "b) Tropics DJF", 
                        "c) Extra-tropics Summer (NH:JJA, SH : DJF)", 
                        "d) Extra-tropics Winter (NH:DJF, SH:JJA)"
                      ]
#
seasons_showing_legend : [ tropics_DJF ]
show_all_error_bars    : False

colors          : { pr  :  red ,  huss  :  black ,  prw  :  forestgreen ,  mrro  :  blue }
xyMarkLineModes : { mean  :  MarkLines ,  std  :  MarkLines }
xyDashPatterns  : { mean  : 1,  std  : 0 }  
# MarkerSizes can be tuned in the notebook

nice            : 
   pr    :  precipitation 
   prw   :  precipitable water 
   mrro  :  runoff 
   std   :  inter-annual variability 
   mean  :  mean 



EOF

jobname=$figname
output=$figname
$D/jobs/job_pm.sh $D/notebooks/change_hybrid_seasons_figure.ipynb fig_figure.yaml $jobname $output
