array=( 5000097208131d21 50000972082fb510 )
cnt=${#array[@]}
for ((i=0;i<cnt;i++)); do
    array[i]="hba$i"
    echo "${array[i]}" 
done
