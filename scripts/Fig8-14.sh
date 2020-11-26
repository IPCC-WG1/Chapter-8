#!/bin/bash

D=/home/ssenesi/CAMMAC

# Create a working directory specific to this figure. It will hold cached data and figures
figname=$(basename $0)
figname=${figname/.sh/}
mkdir -p $figname
cd $figname


# Create input parameters file 
cat <<EOF >fig.yaml

figure_name            : Fig8-14  
figure_title           : None  
auto_title_prefix      : Seasonal 
outdir                 :  ./figures 
version                : ""

variable               :  pr 
derivation_label       :  plain         
threshold              : 0.1/(24*3600) # 0.1 mm/day, in SI
table                  :  Amon 
field_type             :  means_rchange  
custom_plot            : { units: "%" }

seasons                : [ DJF , MAM ,  JJA ,  SON ]  
experiment             :  ssp245  
proj_period            : "2081-2100"
ref_experiment         :  historical 
ref_period             : "1995-2014"  

included_models        : null
excluded_models        : []

use_cached_proj_fields   : False
write_cached_proj_fields : True
print_statistics         : True

cache_dir              :  ./cache 
figure_details         : { page_width : 2450, page_height : 3444,  insert_width : 1600, pt : 50,  ybox : 133, y : 52}
common_grid            :  r360x180 

figure_mask            : null
variability_sampling_args : { house_keeping : True, compute : True, detrend : True, shift : 100, nyears : 20, number : 20}


EOF

# Launch a job in which papermill will execute the notebook, injecting above parameters 
jobname=$figname
output=$figname
hours="06" $D/jobs/job_pm.sh $D/notebooks/change_map_4seasons.ipynb fig.yaml $jobname $output
