#!/bin/bash

set -eu

seed=$SLURM_ARRAY_TASK_ID

sif_file="/home/$USER/regvd.sif"
volume_dir="/home/$USER/data/regvd"
volumes="raw results"

bind_locations=(
    "/home/$USER/regvd:/regvd"
)
for volume in ${volumes}; do
    bind_locations+=( "${volume_dir}/${volume}:/regvd/data/${volume}" )
done

bind_args=()
for location in ${bind_locations[@]}; do
    bind_args+=("--bind ${location}")
done

container_cmd="cd /regvd && python -m venv .venv &&source .venv/bin/activate && pip install -r requirements.txt && ./run_experiment.sh ${seed}"

pushd docker > /dev/null
    apptainer run ${bind_args[@]} --nv --writable-tmpfs $sif_file "$@" bash -c "${container_cmd}"
popd > /dev/null
