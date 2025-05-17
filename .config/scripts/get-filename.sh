path=$1
filename=$(echo "${path##*/}")
filename=$(echo "${filename%.*}")
echo $filename
