## created by logan heusinger
## 2/19/2020
## rips lat and longitude values from HigherElevation/ and stores them in lat, long .lists
## joins lat long lists into HEStaion.xy

rm HELat.list
rm HELong.list
FILES=HigherElevation/*
for f in $FILES
do 
	lat=`egrep 'Latitude' $f|tail -c 10 >> HELat.list`  #rip lat
	long=`egrep 'Longitude' $f|tail -c 10`  #rip long
	long2=`echo "$long * -1"|bc -l >>HELong.list` # multiply by -1 to get into correct coordinate
paste HELong.list HELat.list > HEStation.xy #join the two lists into xy

done 
echo "HE lat long files created and pasted"

