#                             Online Bash Shell.
#                 Code, Compile, Run and Debug Bash script online.
# Write your code in this editor and press "Run" button to execute it.

echo "Enter start date: $1"
echo "Enter End date: $2"
if echo "$1" | grep " "
then
    start_date_with_time=$(date -d "$1" +'%d/%m/%y %H:%M:%S')
    end_date_with_time=$(date -d "$2" +'%d/%m/%y %H:%M:%S')
	actual_start_date_with_time=$(date -d "$1" +'%Y%m%d %H:%M:%S')
	actual_end_date_with_time=$(date -d "$2" +'%Y%m%d %H:%M:%S')
	while true
	do
		if grep -n "$start_date_with_time" sample.txt
		then
			echo "Yay!! found"
			break;
		else
			get_start_time=$(echo "$actual_start_date_with_time" | cut -d' ' -f2)
			get_end_date=$(echo "$actual_start_date_with_time" | cut -d' ' -f1)
			actual_start_date_with_time=$(date -d "$get_start_time $get_end_date + 1 min" +'%Y%m%d %r')
			echo "actual_start_date_with_time"
			echo $actual_start_date_with_time
			start_date_with_time=$(date -d "$actual_start_date_with_time" +'%d/%m/%y %H:%M')
			echo "formatted_actual_start_date_with_time"
			echo $start_date_with_time
		fi
	done
	start_date_time_row_number=$(grep -n "$start_date_with_time" sample.txt | cut -d : -f 1 | head -n 1)
	echo "start_date_time_row_number"
	echo "$start_date_time_row_number"
	
	while true
	do
		if tail -n "+$start_date_time_row_number" sample.txt | grep -n "$end_date_with_time"
		then
			echo "Yay!! found"
			break;
		else
			get_end_time=$(echo "$actual_end_date_with_time" | cut -d' ' -f2)
			get_end_date=$(echo "$actual_end_date_with_time" | cut -d' ' -f1)
			actual_end_date_with_time=$(date -d "$get_end_time $get_end_date - 1 min" +'%Y%m%d %H:%M:%S')
			echo "actual_end_date_with_time"
			echo $actual_end_date_with_time
			end_date_with_time=$(date -d "$actual_end_date_with_time" +'%d/%m/%y %H:%M')
			echo "end_date_with_time"
			echo $end_date_with_time
		fi
	done
	end_date_time_row_number=$(grep -n "$end_date_with_time" sample.txt |tail -1 | cut -d : -f 1 | head -n 1)
    awk -v var=$start_date_time_row_number -v vari=$end_date_time_row_number 'NR==var,NR==vari' sample.txt > sample.txt3.txt
else
    echo "string doesn't contain spaces"
    start_date=$(date -d "$1" +'%d/%m/%y')
    echo $start_date
    actual_date=$1
    formatted_actual_date=$start_date
    echo $formatted_actual_date 
    #grep -n "$formatted_actual_date" sample.txt
    while true
    do
		if grep -n "$formatted_actual_date" sample.txt 
		then 
			echo "exist"
			break;
		else 
			echo "not exist"
			actual_date=$(date -d "$actual_date + 1 days" +'%Y%m%d')
			echo $actual_date
			formatted_actual_date=$(date -d "$actual_date" +'%d/%m/%y')
			echo $formatted_actual_date
		fi
    done
    end_date=$(date -d "$2" +'%d/%m/%y')
    echo $end_date
    actual_end_date=$2
    formatted_actual_end_date=$end_date
    echo $formatted_actual_end_date
    grep -n $formatted_actual_end_date sample.txt
    while true
    do
		if grep -n $formatted_actual_end_date sample.txt 
		then 
			echo "exist"
			break;
		else 
			echo "not exist"
			actual_end_date=$(date -d "$actual_end_date - 1 days" +'%Y%m%d')
			echo $actual_end_date
			formatted_actual_end_date=$(date -d "$actual_end_date" +'%d/%m/%y')
			echo $formatted_actual_end_date
		fi
    done
    start_date_row_number=$(grep -n "$formatted_actual_date" sample.txt | cut -d : -f 1 | head -n 1)
    # get row number of end date from logfile that contains last occurance given as input
    end_date_row_number=$(grep -n "$formatted_actual_end_date" sample.txt |tail -1| cut -d : -f 1 | head -n 1)
    echo $start_date_row_number
    echo $end_date_row_number
    #fetch logs from start date row number to end date row number
    awk -v var=$start_date_row_number -v vari=$end_date_row_number 'NR==var,NR==vari' sample.txt > sample.txt3.txt
fi
