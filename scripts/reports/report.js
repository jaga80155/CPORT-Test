$(function () {
	
	var chartdata = document.getElementById("plotscountarray").value;
	var allChartArray = new Array();
	allChartArray = chartdata.split('[[');
	
	var chartArray = new Array();
	chartArray = allChartArray[1].split(', ');
	
	var totalPlots = chartArray[0];
	
	var occupied= chartArray[1];
	
	var available = chartArray[2];
	
	var processing = chartArray[3];

	var dummyArray = new Array();
	dummyArray = chartArray[4].split(']]');
	var PartialAlloted = dummyArray[0];
	
	var availablePercent = (available/totalPlots)*100;
	var occupiedPercent = (occupied/totalPlots)*100;
	var processingPercent = (processing/totalPlots)*100;
	var PartialAllotedPercentage = (PartialAlloted/totalPlots)*100;
	
	
    $('#widget-container').highcharts({
        chart: {
            type: 'pie',
            options3d: {
                enabled: true,
                alpha: 45,
                beta: 0
            }
        },
        title: {
            text: ''
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                depth: 35,
                dataLabels: {
                    enabled: true,
                    format: '{point.name}'
                }
            }
        },
        series: [{
            type: 'pie',
            name: 'Plots',
            data: [ 
                ['Available', availablePercent],
                ['Processing', processingPercent],
                ['Partially Alloted', PartialAllotedPercentage],
                
                {
                    name: 'Occupied',
                    y: occupiedPercent,
                    sliced: true,
                    selected: true
                }
            ]
        }]
    });
});