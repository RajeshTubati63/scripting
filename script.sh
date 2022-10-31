#!/usr/bin/bash
# remove duplites file
rm duplicates.csv
#get first column data from source file to array
arr=( $( cut -d ',' -f1 source.csv) )
echo "${arr[@]}"
#get duplicate items and the record row numbers which contains first occurance of record and duplicate occurances
printf '%s\n' "${arr[@]}" | awk '{ elmnt[$0]= ($1 in elmnt? elmnt[$1] FS:"") NR-1 } END{ for (e in elmnt)  print elmnt[e] }' > rownumbers.csv
# get only duplicate row numbers
duplicate_row_numbers=$(cut -d" " -f1 --complement rownumbers.csv)
data=($duplicate_row_numbers)
echo "${data[@]}"
# loop through the array and save duplicate records to other file
for i in ${data[@]}
do
        awk -v var=$i 'NR==var' source.csv >> duplicates.csv
done
# remove extra spaces in array
fine=($(echo "${data[@]// /}"))
#echo ${fine[@]}
#get count of array
cnt=${#fine[@]}
array=()
#loop through array and append d: to each item in array except last item in array
for ((i=0;i<cnt;i++)); do
        echo $i
       if [[ $i -ne $cnt-1 ]]
       then
         array[i]="${fine[i]}d;"
         echo "${array[i]}"
       else
          array[i]="${fine[i]}d"
          echo "${array[i]}"
       fi

done
array2=${array[@]}
#remove duplicate rows and save into other file
sed "${array2[@]}" source.csv > dest.csv
# remove extra spaces in array
sed '/^$/d' dest.csv > dest2.csv
# move unique records to sourcefile
mv dest2.csv source.csv
