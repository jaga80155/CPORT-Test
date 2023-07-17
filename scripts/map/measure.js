var source;
var sketch;
var sketchElement;
var output;
var draw;
var measureInteractionCount = 0;
var drawcount = 0;
var wgs84Sphere = new ol.Sphere(6378137);  // Radius of earth

/* Function to Calculate Geometry (Distance, Area) */
function measurevalues() {

	var measureValue = function(evt) {

		if (sketch) {

			var geom = (sketch.getGeometry());
			if (geom instanceof ol.geom.Polygon) {
				output = formatArea(/** @type {ol.geom.Polygon} */
				(geom));

			} else if (geom instanceof ol.geom.LineString) {
				output = formatLength( /** @type {ol.geom.LineString} */
				(geom));
			}

		}

	};
	return measureValue;
}

/* Add  measure interaction to map */
function addMeasureInteraction() {

	if (measureInteractionCount == 0) {
		addInteraction();
	}
	measureInteractionCount = 1;
}

/* Add Interaction type to map */
function loadMeasureRequirements() {

	typeSelect = document.getElementById('type');
	source = new ol.source.Vector();

	var vector = new ol.layer.Vector({
		source : source,
		style : new ol.style.Style({  // Style after drawing geometry
			fill : new ol.style.Fill({   // fill color
				color : 'rgba(0, 255, 255, 0.2)'
			}),
			stroke : new ol.style.Stroke({   // line stroke
				color : '#ffcc33',
				width : 2
			}),
			image : new ol.style.Circle({   // Circle radius and fill colors for point
				radius : 7,
				fill : new ol.style.Fill({
					color : '#ffcc33'
				})
			})
		
		})
	});
	map.addLayer(vector);

}

/* Distance calculation */
var formatLength = function(line) {
	var length = 0;
	var coordinates = line.getCoordinates();
	var sourceProj = map.getView().getProjection();
	for (var i = 0, ii = coordinates.length - 1; i < ii; ++i) {
		var c1 = ol.proj.transform(coordinates[i], sourceProj, 'EPSG:4326');
		var c2 = ol.proj.transform(coordinates[i + 1], sourceProj, 'EPSG:4326');
		length += wgs84Sphere.haversineDistance(c1, c2);  // formula for calculate distance between multiple points

	}
	if (document.getElementById("unittype").value == "me") {

		if (output < 0.01) {
			output = output + ' ' + "Meters";  // Default value in Meters
		} else {
			output = (Math.round(length * 100) / 100) + ' ' + 'Meters';  // Decimal roundoff to two digits 
		}

	} else if (document.getElementById("unittype").value == "km") {
		output = length / 1000;  // Meters to Kilometers conversion
		if (output < 0.01) {
			output = output + ' ' + "Kilometers";
		} else {
			output = (Math.round(length / 1000 * 100) / 100) + ' '
					+ 'Kilometers';  // Decimal roundoff to two digits 
		}

	} else if (document.getElementById("unittype").value == "ft") {

		output = length * 3.28084;  // Meters to Feets conversion
		if (output < 0.01) {
			output = output + ' ' + "Feets";
		} else {
			output = (Math.round(output * 100) / 100);  // Decimal roundoff to two digits 
			output = output + ' ' + 'Feets';
		}
	} else if (document.getElementById("unittype").value == "mi") {

		output = length * 0.000621371;  // Meters to Miles conversion
		if (output < 0.01) {
			output = output + ' ' + "Miles";
		} else {
			output = (Math.round(output * 100) / 100);  // Decimal roundoff to two digits 
			output = output + ' ' + 'Miles';
		}

	} else if (document.getElementById("unittype").value == "ya") {
		output = length * 1.09361;  // Meters to Yards conversion
		if (output < 0.01) {
			output = output + ' ' + "Yards";
		} else {
			output = (Math.round(output * 100) / 100);  // Decimal roundoff to two digits 
			output = output + ' ' + 'Yards';
		}
	}

	return output;
};

/* Area Calculation */
var formatArea = function(polygon) {

	var sourceProj = map.getView().getProjection();
	var geom = (polygon.clone().transform(sourceProj, 'EPSG:4326'));
	var coordinates = geom.getLinearRing(0).getCoordinates();
	var area = Math.abs(wgs84Sphere.geodesicArea(coordinates));  // Formula for calculating area of polygon

	if (document.getElementById("unittype").value == "me") {
		if (output < 0.01) {
			output = output + ' ' + "Sq Meters"; // Default value in Square meters
		} else {
			output = (Math.round(area * 100) / 100) + ' ' + 'Sq Meters';  // Decimal roundoff to two digits
		}
	} else if (document.getElementById("unittype").value == "km") {

		output = area / 1000000;   // Square Meters to Square Kilometers conversion

		if (output < 0.01) {
			output = output + ' ' + "Sq Kilometers";
		} else {
			output = (Math.round(output * 100) / 100);   // Decimal roundoff to two digits 
			output = output + ' ' + 'Sq Kilometers';
		}
	} else if (document.getElementById("unittype").value == "ft") {

		output = area * 10.7639;   // Square Meters to Square Feets conversion
		if (output < 0.01) {
			output = output + ' ' + "Sq Feets";
		} else {
			output = (Math.round(output * 100) / 100);  // Square Meters to Square Feets conversion
			output = output + ' ' + 'Sq Feets';
		}
	} else if (document.getElementById("unittype").value == "mi") {

		output = area * 0.0000003861;  //Square Meters to Square Miles conversion
		if (output < 0.01) {
			output = output + ' ' + "Sq Miles";
		} else {
			output = (Math.round(output * 100) / 100);  // Decimal roundoff to two digits 
			output = output + ' ' + 'Sq Miles';
		}
	} else if (document.getElementById("unittype").value == "ya") {

		output = area * 1.19599;  //Square Meters to Square Yards conversion
		if (output < 0.01) {
			output = output + ' ' + "Sq Yards";
		} else {
			output = (Math.round(output * 100) / 100);  // Decimal roundoff to two digits 
			output = output + ' ' + 'Sq Yards';
		}
	}

	return output;

};

function addInteraction() {

	draw = new ol.interaction.Draw({
		source : source,
		type : (geotype),  // Geometry type LineString or Polygon(i.e., Distance or Area)
        style: new ol.style.Style({   // Style while drawing geometry
          fill: new ol.style.Fill({   // Fill color
            color: 'rgba(255, 255, 255, 0.2)'
          }),
          stroke: new ol.style.Stroke({  // line Stroke color and width
            color: 'blue',
            width: 2
          }),
          image: new ol.style.Circle({  // Point radius, stroke and fill color
            radius: 0,
            stroke: new ol.style.Stroke({
              color: 'rgba(0, 0, 0, 0.7)'
            }),
            fill: new ol.style.Fill({
              color: 'rgba(255, 255, 255, 0.2)'
            })
          })
	})
	});
	map.addInteraction(draw);   // add draw interaction to map
	/* Start drawing on map */
	draw.on('drawstart', function(evt) {
		$(popup.getElement()).popover('destroy');  	/* Start drawing on map */
		if (drawcount == 1) {
			source.clear();  // if already drawn clear from map
		}
		sketch = evt.feature;

	}, this);

/* End of drawing on map */
	draw.on('drawend', function(evt) {

		sketch = null;
		sketchElement = null;
		var element = popup.getElement();
		$(popup.getElement()).popover('destroy');

		var featuress = evt.feature;
		var geom = featuress.getGeometry();
		var endCoord = geom.getLastCoordinate();

		popup.setPosition(endCoord);

		var title = "Measure Details";

		if (geotype == "LineString") {
			title = "<b style=\"color: #F0C92F;\">Distance</b><a href=\"#\" onclick=\"closepopup()\" style=\"float:right;padding-right:6px;font-weight:bolder; color:#F0C92F;\">X</a>";
		} else if (geotype == "Polygon") {
			title = "<b style=\"color: #F0C92F;\">Area</b><a href=\"#\" onclick=\"closepopup()\" style=\"float:right;padding-right:6px;font-weight:bolder; color:#F0C92F;\">X</a>";
		}
	/* Configuration of popup window */
		$(element).popover({
			'placement' : 'top',
			'animation' : true,
			'html' : true,
			'title' : title,
			'content' : "<center>" + output + "</center>"

		});
		$(element).popover('show');
		drawcount = 1;
	}, this);
}