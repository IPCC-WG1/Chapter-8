#!/bin/bash

D=/home/ssenesi/CAMMAC

# Create a working directory specific to this figure. It will hold cached data
figname=$(basename $0)
figname=${figname/.sh/}

mkdir -p $figname
cd $figname

# Create input parameters file 
cat <<EOF >fig.yaml

title                      : Multi-model zonal mean long-term changes in P, E and P-E
variables                  : [ pr, evspsbl, P-E ]
table                      : Amon
columns                    : "Precipitation|Evaporation|Precip. minus evaporation"
figure_name                : Fig8-14 
version                    : "" 
outdir                     : ./figures

# Data used (data_version_tag is set in commom_parameters.yaml)
included_models            : null      
excluded_models            : { P-E : [ EC-Earth3-Veg , EC-Earth3 ] }
variability_models         : null
variability_excluded_models : { P-E : ACCESS-ESM1-5} # No common data period between pr and evspsbl as of 20200913

ref_experiment             : historical
ref_period                 : "1995-2014"
experiments                : [ssp126, ssp245, ssp585] 
projection_period          : "2081-2100"
#
print_statistics           : True
common_grid                : "r360x180"
variability_sampling_args  : { shift: 100, nyears: 20, number: 20, house_keeping: False, compute: True, detrend: True }
check_fixed_fields         : True

do_profiling               : True
do_test                    : False

EOF

# Launch a job in which papermill will execute the notebook, injecting above parameters 
jobname=$figname
output=$figname
$D/jobs/job_pm.sh $D/notebooks/change_zonal_mean.ipynb fig.yaml $jobname $output
#hours=18 $D/jobs/job_pm.sh $D/notebooks/change_zonal_mean.ipynb fig.yaml $jobname $output
