function fixedMapScale(scalevalue,map){
	
	var units = map.getView().getProjection().getUnits();  // Getting current map scale units
	var dpi = 25.4 / 0.28;  // dots per inch value
	var mpu = ol.proj.METERS_PER_UNIT[units];  // calculation of meters per unit
	var resolution = scalevalue *34 / mpu / 39.37 / dpi;  // calculate resolution to be set
	
	map.getView().setResolution(resolution);  // Apply resolution to map for changing the required zoom
	$("#fixedscale").slideToggle("slow");  // Close the Scale options slider
} 