**Some_chap8_figures** is a repository for scripts producing a subset
 of IPCC/AR6/WG1 figures, mainly for Chapter 8, but also for some
 figures of the Technical Summary. It only deals with figures derived
 using CMIP6 multi-model outputs

This version is tagged V1 and was checked to reproduce results
included in the 6th IPCC/WGI Assessment Report. It relies on CAMMAC V1
(see below)

These scripts have been used on the `CLIMERI-France data and computing
platform <https://climeri-france.fr/acces-plateforme/>`_ for actually
producing these figures:
  - in chapter 8 : 13, 14, 15, 16, 17, 18, 21, 25, 26, Box2-f1
  - in the Technical Summary : 12, and two panels of 7-f1

These scripts make heavy use of `CAMMAC
<https://cammac.readthedocs.io>`_, which development was parallel to
IPCC/AR6/WGI timeline; they just set parameters for CAMMAC notebooks
and do launch them using a CAMMAC launch script. Documentation for
these parameters is provided in CAMMAC documentation for each
notebook. **The compatible CAMMAC version is tagged V1**. CAMMAC in
turn makes heavy use of `CliMAF <https://climaf.readthedocs.io>`_

Also provided is a dictionnary of the CMIP6 data that where available
on the above platform on 31 january 2021, with sufficient temporal
coverage; such a dictionnary in instrumental for the figure scripts;
the one provided was actually used for AR6 figures; when wishing to
use it elsewhere, one should only keep those dictionnary entries
corresponding to locally available data

The script's software requirements are limited to `those of CAMMAC
<https://cammac.readthedocs.io/en/latest/requirements.html>`_

The installation consists in:
  - downloading the scripts : `git clone
    https://github.com/senesis/some_chap8_figures.git`
  - installing CliMAF and CAMMAC (this includes tuning
    $CAMMAC/jobs/job_env.sh)
  - tuning parameter file scripts/common_parameters.yaml according to
    your CAMMAC install

When executing a script:
  - first set the environment as described in CAMMAC doc (see section
    'Batch...'; you basically have to set environemnt varables CLIMAF
    and CAMMAC)
  - a figure-specific directory is created locally. It will contain an
    execution trace (as a notebook with output cells), and for most
    scripts two directories:
    - figures : contains single panel figures, a multi-panel figure,
      and metadata files which list the data used
    - cache : contains the data used as input of the figure plot phase

If scripts are launched with argument 'True', they actually run on a test case

Script run_all_scripts.sh is used for launching all scripts (possibly
in test case mode), but excepting the few dedicated to figure plot step
only;

In their present shape, scripts execution uses a CAMMAC utility,
$CAMMAC/jobs/job_pm.sh, which launches a PBS job using qsub. This job
itself executes a notebook using 'papermill' (see CAMMAC
requirements).

When designing a script similar to those provided : please take note
that script $CAMMAC/jobs/job_pm.sh uses a file 'common_parameters.yaml',
and will search it using the scheme described in that script's
comments.

