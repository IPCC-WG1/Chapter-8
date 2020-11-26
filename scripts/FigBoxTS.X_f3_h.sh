#!/bin/bash

D=/home/ssenesi/CAMMAC

# Create a working sub-directory specific to this figure. It will hold cached data
figname=$(basename $0)
figname=${figname/.sh/}
wdir=${figname/_figure}
mkdir -p $wdir
cd $wdir

# Create input parameters file 
cat <<EOF >fig.yaml

# Version number will be a suffix for data filename. Use e.g.  _V1  for legibility
version            : ""

variables          : [ [ pr , mean ], [ prw , mean ], [ pr , std ], [ mrro , mean ], [ mrro , std ] ]
stats_list         : [  mean ,  ens , nq5 , nq95 ]

hybrid_seasons  : 
    tropics_annual : [  [ tropics , ANN ] ]  
latitude_limit     : 30.

scenarios          : [  ssp585 ,  ssp245 , ssp126  ]

ref_experiment     : historical 
ref_period         : "1850-1900" 
proj_period        : "2000-2099"

option             : direct 
max_warming        : 5. 
min_warming        : 1.5
warming_step       : 0.25
window_half_size   : 10  

excluded_models    : {} 
included_models    : {}  

outdir             :  ./changes 

EOF

# Launch a job in which papermill will execute the notebook, injecting above parameters
jobname=$figname
output=$figname
$D/jobs/job_pm.sh $D/notebooks/change_hybrid_seasons_dT.ipynb fig.yaml $jobname $output
