#!/bin/bash

D=/home/ssenesi/CAMMAC

# Create a working directory specific to this figure. It will hold cached data
figname=$(basename $0)
figname=${figname/.sh/}
mkdir -p $figname
cd $figname


cat <<EOF >fig.yaml

figure_name               :  Fig8-26 
version                   : "" 
title                     : "Effect on precipitation of first versus second 2 degrees of global warming (vs 1850-1900)"
outdir                    :  ./figures 

variable                  :  pr      
table                     :  Amon          
variable_transformation   :  plain         
seasons                   : [ DJF , JJA ]  
experiment                :  ssp585 
first_delta               : 2.0         
second_delta              : 4.0         
proj_period               : "2015-2099" 
ref_experiment            :  historical 
ref_period                : "1850-1900" 
window_half_size          : 10          
field_type                : rmean     
#threshold                : 0.1/(24*3600) 
threshold                 : null

included_models           : null
excluded_models           : [ ]
with_variability          : True 
variability_models        : null
variability_excluded_models : []

plot_args                 : 
                   color  :  AR6_Precip_12s 
                   colors : "-80. -40. -20. -10. -5. 0 5. 10. 20. 40. 80. "

figure_details            : { page_width : 2450, page_height : 3444,  insert_width : 2000, pt : 60,  ybox : 133, y : 40}
common_grid               : "r360x180"
variability_sampling_args : { house_keeping : True, compute : True, detrend : True, shift : 100, nyears : 20, number : 20}
#

EOF

# Launch a job in which papermill will execute the notebook, injecting above parameters
jobname=$figname
output=$figname
$D/jobs/job_pm.sh $D/notebooks/change_map_path_dependance.ipynb fig.yaml $jobname $output

