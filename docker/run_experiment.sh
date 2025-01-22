#!/usr/bin/env bash

set -eu

if [ $# -ne 1 ]; then
    echo "Usage: $0 <seed>"
    exit 1
fi

seed=$1

in_train=data/raw/primevul_train.jsonl
in_valid=data/raw/primevul_valid.jsonl
in_test=data/raw/primevul_test.jsonl
out_dir=data/results/regvd-${seed}
mkdir -p $out_dir
log_file=$out_dir/training_log.txt
touch $log_file

python code/run.py --output_dir=./saved_models/regcn_l2_hs128_uni_ws5_lr5e4 --model_type=roberta --tokenizer_name=microsoft/graphcodebert-base --model_name_or_path=microsoft/graphcodebert-base \
	--do_eval --do_test --do_train --train_data_file=$in_train --eval_data_file=$in_valid --test_data_file=$in_test \
	--block_size 400 --train_batch_size 128 --eval_batch_size 128 --max_grad_norm 1.0 --evaluate_during_training \
	--gnn ReGCN --learning_rate 5e-4 --epoch 100 --hidden_size 128 --num_GNN_layers 2 --format uni --window_size 5 \
	--seed $seed  --pred_csv=$out_dir/predictions.csv 2>&1 | tee $log_file
