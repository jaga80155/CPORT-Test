var osmbasemapgroup;
var bingbasemapgroup;
var streetbasemapgroup;
var satellitebasemapgroup;
var googleLayer;
var carto;
var MapQuestSat;
var bingroad;
var bingAerialWithLabels;

osmbasemapgroup =  new ol.layer.Tile({
	    name: 'Test_OSM',
	    source: new ol.source.OSM()
	})
	
	streetbasemapgroup = new ol.layer.Tile({
	    name: 'Test_MQ',
	    source: new ol.source.MapQuest({
	        layer: 'osm'
	    })
	});
	
	bingbasemapgroup =  new ol.layer.Tile({
	    name: 'Bingmap',
		source : new ol.source.BingMaps(
				{
					key : 'AtRJu52pIf1CINdLfRGGJz27bXzXkGc8STzexLhnwtQecuzCnF-C_4RQI5KNKA88',
					imagerySet : 'Aerial',
					params : {
						'LAYERS' : "BingMaps"
					}

				})
	});
	
	bingroad =  new ol.layer.Tile({
	    name: 'Bingmap',
		source : new ol.source.BingMaps(
				{
					key : 'AtRJu52pIf1CINdLfRGGJz27bXzXkGc8STzexLhnwtQecuzCnF-C_4RQI5KNKA88',
					imagerySet : 'Road',
					params : {
						'LAYERS' : "BingMaps"
					}

				})
	});
		
	bingAerialWithLabels = new ol.layer.Tile({
		    name: 'Bingmap',
			source : new ol.source.BingMaps(
					{
						key : 'AtRJu52pIf1CINdLfRGGJz27bXzXkGc8STzexLhnwtQecuzCnF-C_4RQI5KNKA88',
						imagerySet : 'AerialWithLabels',
						params : {
							'LAYERS' : "BingMaps"
						}

					})
		});
	
	carto = new ol.layer.Tile({ 
	    source: new ol.source.XYZ({ 
	        url:'http://{1-4}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
	    })
	});
	
	MapQuestSat  = new ol.layer.Tile({
      source: new ol.source.MapQuest({layer: 'sat'})
    });

/* Change Base Map */
function changetoOSMbasemap(maps)
{
	 maps.getLayers().setAt(0, osmbasemapgroup)
}

function changetostreetbasemap(maps)
{
	maps.getLayers().setAt(0, streetbasemapgroup)
}

function changetoBINGbasemap(maps)
{
	maps.getLayers().setAt(0, bingbasemapgroup)
}

function changetoBINGROADbasemap(maps)
{
	maps.getLayers().setAt(0, bingroad)
}

function changetoBINGAerialWithLabels(maps)
{
	maps.getLayers().setAt(0, bingAerialWithLabels)
}

function changetoSATELLITEbasemap(maps)
{
	maps.getLayers().setAt(0, satellitebasemapgroup)
}

function changetocartoDBbasemap(maps)
{
	maps.getLayers().setAt(0, carto)
}

function changetomapquestsatbasemap(maps)
{
	maps.getLayers().setAt(0, MapQuestSat)
}

function changetogooglebasemap(maps)
{
	maps.getLayers().setAt(0, googleLayer)
}

var basemapgallerystatus = 0;
function showBaseMaps()
{
	if(basemapgallerystatus == 0)
		{
			document.getElementById("basemapgallerydiv").style.display = "block";
			basemapgallerystatus = 1;
		}
	else
		{
			document.getElementById("basemapgallerydiv").style.display = "none";
			basemapgallerystatus = 0;
		}	
}

function closebasemapgallery()
{
	document.getElementById("basemapgallerydiv").style.display = "none";
	basemapgallerystatus = 0;
}