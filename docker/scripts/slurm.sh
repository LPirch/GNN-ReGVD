#!/bin/bash -eu
#SBATCH --job-name=regvd
#SBATCH --partition=cpu-2h
#SBATCH --mem=20G
#SBATCH --ntasks-per-node=1
#SBATCH --output=slurm-logs/regvd/%j.out

/home/$USER/regvd/scripts/run.sh
