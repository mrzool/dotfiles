for i in $( ls *.jpg); do convert -resize 30% $i re_$i; done
