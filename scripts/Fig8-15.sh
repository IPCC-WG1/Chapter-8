#!/bin/bash

D=/home/ssenesi/CAMMAC

# Create a working directory specific to this figure. It will hold cached data
figname=$(basename $0)
figname=${figname/.sh/}
mkdir -p $figname
cd $figname

# Create input parameters file 
cat <<EOF >fig.yaml

version            : ""

included_models    : {}  
excluded_models    : 
   mrro: [ CAMS-CSM1-0 ]  # outlier for variability

variables          : [ [pr, mean], [prw, mean], [pr, std], [mrro, mean], [mrro, std] ]

latitude_limit     : 30.
SH_latitude_limit  : 60

hybrid_seasons : { 
    tropics_DJF  : [ ( tropics , DJF ) ], 
    tropics_JJA  : [ ( tropics , JJA) ], 
    extra_winter : [ ( NH , DJF ), ( SH , JJA) ],
    extra_summer : [ ( NH , JJA) , ( SH , DJF) ],
    }

stats_list         : [ mean, ens, nq5, nq95 ]

ref_experiment     : historical
ref_period         : "1850-1900" 

scenarios          : [ ssp585, ssp245, ssp126 ]

periods_length     : 20
start_year         : 2021
last_year          : 2081 
step               : 10  

outdir             : ./changes

do_test            : False

EOF

# Launch a job in which papermill will execute the notebook, injecting above parameters 
jobname=$figname
output=$figname
$D/jobs/job_pm.sh $D/notebooks/change_hybrid_seasons.ipynb fig.yaml $jobname $output
#hours=23 $D/jobs/job_pm.sh $D/notebooks/change_hybrid_seasons.ipynb fig.yaml $jobname $output
