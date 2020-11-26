#!/bin/bash

D=/home/ssenesi/CAMMAC

# Create a working directory specific to this figure. It will hold cached data
figname=$(basename $0)
figname=${figname/.sh/}
mkdir -p $figname
cd $figname


# Create input parameters file 
cat <<EOF >fig.yaml

do_test                : False

figure_name            : FigTS-2-9 
manual_title           : null
auto_title_end         : "for three SSPs and near to long-term"
version                : ""     
outdir                 :  ./figures 

variable               :  pr 
threshold              : null
table                  : Amon 
derivation             : plain 
season                 : ANN 
field_type             : means_rchange 

experiments            : [ ssp126 , ssp245 , ssp585 ]
horizons               : [ "2021-2040" , "2041-2060","2081-2100"]
ref_period             : "1995-2014"
ref_experiment         :  historical 


excluded_models        : []
included_models        : null
variability_models     : null
variability_excluded_models : []

plot_args              : { colors : "-40 -20 -10  -5 -2  0 2  5 10 20 40 "}

variab_sampling_args   : { house_keeping :True, compute :True, detrend :True, shift :100, nyears :20, number :20}

figure_details         : { page_width :2450, page_height :3444,  insert_width :1800, pt :48,  ybox :133, y :52}
use_cached_proj_fields : False
common_grid            : "r360x180"

EOF


# Launch a job in which papermill will execute the notebook, injecting above parameters
jobname=$figname
output=$figname
hours=12 $D/jobs/job_pm.sh $D/notebooks/change_map_3SSPs_3horizons.ipynb fig.yaml $jobname $output
