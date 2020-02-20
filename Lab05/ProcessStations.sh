## created by logan heusinger
## 2/19/2020
## filters through StationData/ and checks .txt files for altitude
## altitudes >= 200 stored in HigherElevation Directory --> checks for dir and creates if none
## creates .ps .epsi .tiff files of lat long data 

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


./alllatlongrip.sh #creates lists and joins them into .xy
./HElatlongrip.sh #same ^

module load gmt

gmt pscoast -JU16/4i -R-93/-86/36/43 -B2f0.5 -Ia/blue  -Na/orange -P -Cblue -K -V -Dh>  SoilMoistureStations.ps #creates .ps of area with lat long locations
gmt psxy AllStation.xy -J -R -Sc0.15 -Gblack -K -O -V >> SoilMoistureStations.ps
gmt psxy HEStation.xy -J -R -Sc0.065 -Gred -O -V >> SoilMoistureStations.ps


ps2epsi SoilMoistureStations.ps SoilMoistureStations.epsi #converts .ps into .epsi
convert -density 150x150 SoilMoistureStations.epsi SoilMoistureStations.tiff #converts .epsi into tiff

echo "all done"
