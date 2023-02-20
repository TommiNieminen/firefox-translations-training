#!/bin/bash
##
# Applies OPUS-MT preprocessing to corpus
#

set -x
set -euo pipefail

# add spm_encode to path
export PATH=$(realpath 3rd_party/marian-dev/build/):$PATH

source_file=$1
opusmt_model=$2
source_lang=$3
model_dir=$(dirname $2)
 
cat $1 | ${model_dir}/preprocess.sh $3 "${model_dir}/source.spm"  > $1.opusmt
