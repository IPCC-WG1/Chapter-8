Some_chap8_figures is a repository for scripts producing a subset of IPCC/AR6/WG1 figures, mainly for Chapter 8, but also for some figures of the Technical Summary. It only deals with figures derived using CMIP6 multi-model outputs

They have been used on the `CLIMERI-France data and computing platform <https://climeri-france.fr/acces-plateforme/>`_ for actually producing these figures:
  - in chapter 8 : 13, 14, 15, 16, 17, 18, 21, 27, Box2-f1
  - in the Technical Summary : 19-f1, 20, BoxX-f3-h

These scripts make heavy use of `those of CAMMAC <https://cammac.readthedocs.io>`_, which development was parallel to IPCC/AR6/WGI timeline; they just set parameters for CAMMAC notebooks and do launch them using a CAMMAC launch script. Documentation for these parameters is provided in CAMMAC documentation for each notebook.

Utilities are also provided :
  - a notebook which builds a dictionnary of locally available CMIP6 data, and checks their temporal coverage; such a dictionnary in instrumental for the figure scripts
  - a version of such dictionnary, the one used for actual AR6 figures; it has been built on the above-mentionned platform and so represents only CMIP6 data available there; when wishing to use it elsewhere, one should only keep those dictionnary entries corresponding to locally available data
  - a pre-processing script for computing yearly climatology of daily variables

Their software requirements are limited to `those of CAMMAC<https://cammac.readthedocs.io/en/latest/requirements.html>`_

The installation consists in:
  - downloading the scripts
  - tuning script scripts/job_env.sh according to its embedded comments
  - tuning parameter file scripts/common_parameters.yaml according to your CAMMAC install

In their present shape, scripts execution use a CAMMAC utility, job_pm.sh, which launch a PBS job using qsub. This job itself executes a notebook using 'papermill' (see CAMMAC requirements)

When executing a script, a figure-specific directory is created locally. It will contain an execution trace (as a notebook), and for most scripts two directories :
  - figures : contains single panel figures, a multi-panel figure, and metadata files which list the data used
  - cache : contains the data used as input of the figure plot phase

