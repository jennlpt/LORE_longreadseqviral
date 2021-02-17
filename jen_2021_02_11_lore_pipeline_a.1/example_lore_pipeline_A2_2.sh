#!/bin/bash

IN_FILE_IDENTIFIERS="./data/identifiers.stride_1800.length_20.out"
IN_FILE_READS="./data/25_125_290.mapped_fix.sam"
OUT_FILE_FILTERED_READS="./data/isoforms_excl.out"

./lore_pipeline_A2_2.sh                    \
   ${IN_FILE_IDENTIFIERS}                  \
   ${IN_FILE_READS}                        \
   ${OUT_FILE_FILTERED_READS}
   