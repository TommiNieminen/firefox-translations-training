#!/bin/bash
# properties = {properties}

#parse properties json and get log file name
log_file=$(echo '{properties}' | jq -r .log[0])

export SINGULARITYENV_CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES

if [ -n "$SINGULARITYENV_CUDA_VISIBILE_DEVICES" ]
then
    nvidia-smi --query-gpu=timestamp,name,pci.bus_id,driver_version,pstate,pcie.link.gen.max,pcie.link.gen.current,temperature.gpu,utilization.gpu,utilization.memory,power.draw,memory.total,memory.free,memory.used --format=csv -l 1 > $log_file.gpu &
fi

{exec_job}
i
if [ -n "$SINGULARITYENV_CUDA_VISIBILE_DEVICES" ]
then
    kill %1
    gzip $log_file.gpu
fi
