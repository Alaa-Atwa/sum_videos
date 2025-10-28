#!/usr/bin/env bash 

# scripted by: Alaa-Atwa
# this script calculate "total time of a group of videos for the current directory and subdirectories"
# Navigate to your vidoes location and run this script 

# You can add the script to your $PATH :
# > cp tcourse /usr/bin/
# > source ~/.bashrc 

# Colors
# to access colors as variables: echo ${RED}Colored_red_here
C=$(printf '\033') 
RED="${C}[1;31m"
SED_RED="${C}[1;31m&${C}[0m"
GREEN="${C}[1;32m"
SED_GREEN="${C}[1;32m&${C}[0m"
YELLOW="${C}[1;33m"
SED_YELLOW="${C}[1;33m&${C}[0m"
SED_RED_YELLOW="${C}[1;31;103m&${C}[0m"
BLUE="${C}[1;34m"

function breakLine(){
   printf "${GREEN}%$(tput cols)s" | tr " " "=" 
}

# creating a spinner
function spinner(){
  while [ 1 ];do
    spin=( '\' '|' '/' '-' ) 
    for i in ${spin[@]};do
     echo -ne "$i \r"
     sleep 0.2
    done
  done
}

# Banner
if [[ `command -v figlet` ]];then
  figlet "Tcourse"
  echo -e "\t \t \t scripted by: ${BLUE} Alaa-Atwa"
fi

# check for the required tools
required_tools=(exiftool vim awk)

for cmd in ${required_tools[@]};do
  if [[ ! $(command -v $cmd) ]]; then
    echo "You Must install $cmd first"
    exit 1
  fi
done

breakLine && echo -e "\t \t \t ${BLUE}Calculating, Please Wait ,it may takes a while !"  
spinner & # running the spinner
pid=$!
breakLine

# List extensions you want to include:
exts=(mp4 mkv avi mov webm m4v flv)

# Build -ext arguments for exiftool
ext_args=()
for e in "${exts[@]}"; do
  ext_args+=( -ext "$e" )
done

# Ask exiftool for numeric Duration values only (-n numeric, -s3 tag value only),
# recursively from current directory.
# If you prefer non-recursive, remove -r.
total_seconds=$(exiftool -r "${ext_args[@]}" -Duration -n -s3 . 2>/dev/null \
                | awk '{sum+=$1} END{printf "%.3f\n", sum+0}')

# If there were no videos, do this:
if [[ -z "$total_seconds" || "$total_seconds" == "0.000" ]]; then
  echo "No video durations found."
  exit 0
fi

# Convert to hours/minutes/seconds. Use awk for floating math and pretty print.
awk -v sec="$total_seconds" 'BEGIN{
  total=sec;
  h=int(total/3600);
  m=int((total%3600)/60);
  s=total - h*3600 - m*60;
  # Trim trailing zeros on fractional seconds, print seconds as integer if close to integer
  if (s == int(s)) {
    printf("Total: %d hours, %d minutes, %d seconds\n", h, m, int(s));
  } else {
    # print seconds with up to 3 decimals (ms)
    printf("Total: %d hours, %d minutes, %06.3f seconds\n", h, m, s);
  }
}'

kill $pid  # end the spinner 