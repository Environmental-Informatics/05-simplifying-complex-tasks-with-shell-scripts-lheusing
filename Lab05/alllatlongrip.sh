rm Lat.list
rm Long.list
FILES=StationData/*
for f in $FILES
do 
	long=`egrep 'Longitude' $f|tail -c 9 >> Long.list`  #rip long
	lat=`egrep 'Latitude' $f|tail -c 9 >> Lat.list`  #rip lat
	paste Long.list Lat.list > AllStation.xy
done 
echo "all lat long lists created and pasted"
