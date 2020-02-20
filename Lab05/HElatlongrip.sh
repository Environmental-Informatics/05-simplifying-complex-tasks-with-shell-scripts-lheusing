rm HELat.list
rm HELong.list
FILES=HigherElevation/*
for f in $FILES
do 
	lat=`egrep 'Latitude' $f|tail -c 9 >> HELat.list`  #rip lat
	long=`egrep 'Longitude' $f|tail -c 9 >> HELong.list`  #rip long
	
paste HELong.list HELat.list > HEStations.xy

done 
echo "HE lat long files created and pasted"

