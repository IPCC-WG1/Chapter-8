#!/bin/bash

D=/home/ssenesi/CAMMAC

# Create a working directory specific to this figure. It will hold cached data
figname=$(basename $0)
figname=${figname/.sh/}
mkdir -p $figname
cd $figname


# Create input parameters file 
cat <<EOF >fig.yaml

figure_title           : null
auto_title_prefix      : Seasonal
#
figure_name            : Fig8-17
version                : ""
#
variable               : evspsbl
table                  : Amon
field_type             : means_rchange
derivation_label       : plain
custom_plot            : {  "units": "%" }
#
included_models        : null 
excluded_models        : []
variability_models     : null
variability_excluded_models : []
variability_sampling_args   : { shift: 100, nyears: 20, number: 20, house_keeping: False, compute: True, detrend: True }
#
seasons                : [ DJF, JJA ]  
experiments            : [ ssp126, ssp245, ssp585 ] 
proj_period            : "2081-2100"
ref_experiment         : historical
ref_period             : "1995-2014"  
#
use_cached_proj_fields : False   
print_statistics       : True
#
outdir                 : ./figures
cache_dir              : ./cache
figure_details         : { page_width :2450,  page_height :3444,  insert_width :1800, pt :48,  ybox :133,  y :52}
common_grid            : "r360x180"
figure_mask            : null

plot_for_each_model    : []
ranges : 
           reference   : { scale : 24*3600 , units : mm/d, min : 0 , max : 5 , delta : 0.5 }
           projection  : { scale : 24*3600 , units : mm/d, min : 0 , max : 5 , delta : 0.5 }
           change      : { scale : 24*3600 , units : mm/d, min : -2.5 , max : 2.5 , delta : 0.5 }
           rchange     : { min : -100. , max : 100., delta : 10. }
           variability : { scale : 24*3600 , units : mm/d, min : 0 , max : 0.25 , delta : 0.2 }

EOF

# Launch a job in which papermill will execute the notebook, injecting above parameters 
jobname=$figname
output=$figname
hours=12 $D/jobs/job_pm.sh $D/notebooks/change_map_3SSPs_2seasons.ipynb fig.yaml $jobname $output
