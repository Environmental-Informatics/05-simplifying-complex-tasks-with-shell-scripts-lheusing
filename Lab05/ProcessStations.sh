
FILES=StationData/*
for f in $FILES
do 
	alt=`egrep 'Altitude' $f|tail -c 11|head -c 3`  #rip altitude 
	#if [ $alt -gt 199 ] #chech elevation
	if (($(echo "$alt > 199 " |bc -l))) 	
	then	
		if [ -d HigherElevation/ ] #check for directory
		then 
			cp $f HigherElevation/ # copy files

		else
			mkdir HigherElevation
			cp $f HigherElevation/
		fi
	fi

done 
echo "files copied to directory"


./alllatlongrip.sh
./HElatlongrip.sh

module load gmt

gmt pscoast -JU16/4i -R-93/-86/36/43 -B2f0.5 -Ia/blue -Na/orange -P -K -V > SoilMoistureStations.ps
gmt psxy AllStation.xy -J -R -Sc0.15 -Gblack -K -O -V >> SoilMoistureStations.ps
gmt psxy HEStation.xy -J -R -Sc0.15 -Gred -O -V >> SoilMoistureStations.ps


echo "all done"
