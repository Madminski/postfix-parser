#!/bin/bash
start_time=$(date +%s)
filelist="$1"
DATA_DIR=/mnt/z/data/
RAW_DIR=$DATA_DIR/raw
OUTPUT_DIR=$DATA_DIR/processed
output_file="parsed_"$1".csv"
num_files=$(wc -l $filelist | awk '{print $1}')
total_lines=$(wc -l $(cat $filelist) | grep total | awk '{print $1}')

for i in ${filelist}
do
    echo "############# $i Started"
    while read line; 
	do 
	echo "Parsing $line Started - $(date | awk '{print $4}')";
	./pf_parse "$line" >> $OUTPUT_DIR/$output_file; 
	counter=$(($counter + $(wc -l $line | awk '{print $1}') )); 
	echo "$counter of $total_lines Completed - $(date | awk '{print $4}')" ;
	done < "$i";
    echo "############# $i Completed"
    end_time=$(date +%s)
    delta=$((end_time - start_time))
    lines_per_second=$((total_lines / delta))
    num_output_lines=$(wc -l $OUTPUT_DIR/$output_file | awk '{print $1'})
    num_msg_ids=$(awk -F'|' '{print $1}' $OUTPUT_DIR/$output_file | wc -l)
    echo "############# SUMMARY ############# "
    echo "Parsed $num_output_lines send attempts from $total_lines maillog lines"
    echo "@ $lines_per_second lines/second"
    echo "With $num_msg_ids unique msg-ids"
    echo "Completed in $((delta / 60)) minutes"
done
