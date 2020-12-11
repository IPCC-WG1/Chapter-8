#!/bin/bash

D=${CAMMAC:-/home/ssenesi/CAMMAC}

# Create a working directory specific to this figure. It will hold cached data
figname=$(basename $0)
figname=${figname/.sh/}
mkdir -p $figname
cd $figname

cat <<EOF >fig.yaml

do_test              : False

figure_name          :  FigTS-2-10 
outdir               :  ./figures 
version              : ""
manual_title         : null  

experiment           :  ssp245 
proj_period          : "2081-2100"

ref_experiment       :  historical 
ref_period           : "1995-2014" 

season               :  ANN         
field_type           :  means_rchange  # Ranges in figures are not tuned for other choices ...

z1                   : 0.1/(24*3600) # 0.1 mm/day, in kg m2 s-1
use_cached_proj_fields : True
#
cache_dir            :  ./cache 
variab_sampling_args : { house_keeping : True, compute : True, detrend : True, shift : 100, nyears : 20, number : 20}
figure_details       : { page_width : 2450, page_height : 3444, pt : 48,  ybox : 133, y : 52}
common_grid          : "r360x180"
antarctic_mask       : $D/data/mask_hide_antarctic_360x180.nc


included_models      : null
excluded_models :
   sos   : [ IPSL-CM6A-LR]   # Issue for CDO remap : ssp245,picontrol data have variable 'area' without coordinates
   P-E   : [ EC-Earth3-Veg ] # EC-Earth : Issue with evspsbl version latest for historical,r4i1p1f1 for tag 20200719d
   pr_day: [ EC-Earth3-Veg, EC-Earth3 ] # EC-Earth : Issue with mergetime 

variability_models   : null
variability_excluded_models :
   sos   : [ IPSL-CM6A-LR]   # Issue for CDO remap : ssp245,picontrol data have variable 'area' without coordinates
   P-E   : [ ACCESS-ESM1-5 ] # ACCESS-ESM1-5 : Pr and evspsbl don't have common period, as of 20200913
   pr_day: [ EC-Earth3-Veg, EC-Earth3 ] # EC-Earth : Issue with mergetime 

EOF


# Launch a job in which papermill will execute the notebook, injecting above parameters
jobname=$figname
output=$figname
# Tell job_pm.sh to use co-located environment setting
export ENV_PM=$(cd $(dirname $0); pwd)/job_env.sh

# Tell job_pm.sh to use co-located parameters file 
commons=$(cd $(dirname $0); pwd)/common_parameters.yaml
[ ! -f $commons ] && $commons = ""

#hours=23 $D/jobs/job_pm.sh $D/notebooks/change_map_1SSP_9vars.ipynb fig.yaml $jobname $output
hours=23 $D/jobs/job_pm.sh $D/notebooks/change_map_1SSP_9vars.ipynb fig.yaml $jobname $output $commons
