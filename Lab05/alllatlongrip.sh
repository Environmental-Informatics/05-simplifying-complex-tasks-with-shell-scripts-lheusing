## created by logan heusinger
## 2/19/2020
## rips lat and longitude values from StationData/ and stores them in lat, long .lists
## joins lat long lists into allstaion.xy

rm Lat.list #clear old files
rm Long.list
FILES=StationData/*
for f in $FILES
do 
	long=`egrep 'Longitude' $f|tail -c 10`  #rip long 
	long2=`echo "$long * -1"|bc -l >> Long.list` #multiply by neg 1 to get into proper coordinate
	lat=`egrep 'Latitude' $f|tail -c 10 >> Lat.list`  #rip lat
	paste Long.list Lat.list > AllStation.xy #join two files
done 
echo "all lat long lists created and pasted"
