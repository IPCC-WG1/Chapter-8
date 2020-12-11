#!/bin/bash

# After changing notebook to use preprocessed yearly stats of daily pr

D=${CAMMAC:-/home/ssenesi/CAMMAC}

# Create a working directory specific to this figure. It will hold cached data
figname=$(basename $0)
figname=${figname/.sh/}
mkdir -p $figname
cd $figname

# Create input parameters file 
cat <<"EOF" >fig.yaml

figure_name        : Fig8-16 
version            : ""        
title              : "Multi-model annual mean long-term changes in daily precipitation statistics"
outdir             : ./figures

cases              : 
                     ydry    : { derivation : plain  ,  variable : dday ,  table : yr ,  threshold : null, 
                                 plot_args  : {  color : AR6_Evap_12 ,  units : days , 
                                                 colors : "-32 -16 -8 -4 -2 0 2 4 8 16 32",
                                                 focus : land  }}
                     ydrain  : { derivation : plain  ,  variable : drain ,  table : yr ,  threshold : null, 
                                 plot_args : {  color : AR6_Precip_12s ,  units : mm ,  scale : 24.*3600., 
                                                colors : "-2 -1 -0.5 -0.2 -0.1 0 0.1 0.2 0.5 1 2 ",
                                                focus : land } } 

order              : [ ydry, ydrain ]

derived_variables_pattern  : "/data/ssenesi/CMIP6_derived_variables/${variable}/${variable}_${table}_${model}_${experiment}_${realization}_${grid}_${version}_${PERIOD}.nc"
derived_variable_table     : yr

ref_experiment     : historical
experiments        : [ ssp126 , ssp245 , ssp585 ]
ref_period         : "1995-2014"
proj_period        : "2081-2100"
field_type         :  mean_change 
season             :  ANN 

included_models    : null
excluded_models    : [ EC-Earth3, EC-Earth3-Veg ]

variability_models : null
variability_excluded_models : [ EC-Earth3, EC-Earth3-Veg ]

use_cached_proj_fields : False   
print_statistics       : True

common_grid            : "r360x180"
variab_sampling_args   : { house_keeping : True, compute : True, detrend : True, shift : 100, nyears : 20, number : 20}
cache_dir              :  ./cache 
figure_details         : { page_width : 2450, page_height : 3444,  insert_width : 2400, pt : 55, ybox : 133, y : 40}
do_test                : False

EOF


# Launch a job in which papermill will execute the notebook, injecting above parameters 
jobname=$figname
output=$figname
# Tell job_pm.sh to use co-located environment setting
export ENV_PM=$(cd $(dirname $0); pwd)/job_env.sh

# Tell job_pm.sh to use co-located parameters file 
commons=$(cd $(dirname $0); pwd)/common_parameters.yaml
[ ! -f $commons ] && $commons = ""

hours=12 $D/jobs/job_pm.sh $D/notebooks/change_map_3SSPs_2vars.ipynb fig.yaml $jobname $output $commons
