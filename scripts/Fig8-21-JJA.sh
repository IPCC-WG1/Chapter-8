#!/bin/bash

D=/home/ssenesi/CAMMAC

# Create a working directory specific to this figure. It will hold cached data
figname=$(basename $0)
figname=${figname/.sh/}
mkdir -p $figname
cd $figname


cat <<EOF >fig.yaml

figure_name               : Fig8-21-DJF
version                   : ""   
manual_title              : null
outdir                    :  ./figures 

variable                  :  P-E      
table                     :  Amon          
variable_transformation   :  plain         
season                    :  JJA
experiment                :  ssp585 

ref_experiment            :  historical 
ref_period                : "1850-1900" 
proj_period               : "2015-2099" 
warming                   : 3.0         
window_half_size          : 10          

field_type                : mean
threshold                 : null

included_models           : null
excluded_models           : [ ACCESS-ESM1-5, EC-Earth3-Veg, EC-Earth3 ]

plot_args : 
  color : AR6_Precip_12s 
  min   : -1
  max   : 1 
  delta : 0.2 

clim_contours             : [ ] 
figure_details            : { page_width :2450, page_height :3444,  insert_width :2000, pt :60,  ybox :133, y :40}
common_grid               :  r360x180 

EOF

# Launch a job in which papermill will execute the notebook, injecting above parameters
jobname=$figname
output=$figname
$D/jobs/job_pm.sh $D/notebooks/change_map_1var_at_WL_1SSP_with_clim.ipynb fig.yaml $jobname $output

