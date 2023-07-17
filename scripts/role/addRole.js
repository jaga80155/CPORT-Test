$(document).ready(function() {

		 $('#myTable').after('<div id="nav" style="text-align:center;" class="pager"></div>');
    var rowsShown = 3;
    var numLimit = 1;
    var rowsTotal = $('#myTable tbody tr').length;
    var numPages = rowsTotal / rowsShown;
    for (var i = 0; i < numPages; i++) {
        var pageNum = i + 1;
        $('#nav').append('<a class="btn nums" href="#" rel="' + i + '">' + pageNum + '</a> ');
    }
    $('#myTable tbody tr').hide();
    $('#myTable tbody tr').slice(0, rowsShown).show();
    $('#nav a:first').addClass('active').css("color", "white");
    if (numPages > 3) {
        $('#nav').append('<a class="btn" href="#" rel="next">Next</a> ');
		// $('#nav').append('<a class="btn" href="#" rel="first">First</a> ');
		  //$('#nav').append('<a class="btn" href="#" rel="last">Last</a> ');
        $('#nav').prepend('<a class="btn" href="#" rel="prev" style="display:none">Prev</a> ');
    }
    $('#nav').on('click', 'a', function () {
        var $nums = $('.nums');
        var currPage = $(this).attr('rel');
        if (currPage == "next") {
            currPage = $('#nav a.active').attr('rel');
            currPage++;
        } else if (currPage == "prev") {
            currPage = $('#nav a.active').attr('rel');
            currPage--;
        }
        var startItem = currPage * rowsShown;
        var endItem = startItem + rowsShown;
        $('#nav a').removeClass('active').css("color", "#dbae8c");;
        $('#nav a[rel="' + currPage + '"]').addClass('active').css("color", "yellow");
        $('#myTable tbody tr').css('opacity', '0.0').hide().slice(startItem, endItem).
        css('display', 'table-row').animate({
            opacity: 1
        }, 300);
        if ($('#nav a').last().prev().hasClass('active')) 
        	$('#nav a').last().hide();
        else 
        	$('#nav a').last().show();
        if (!$('#nav a').first().next().hasClass('active')) 
        	$('#nav a').first().show();
        else 
        	$('#nav a').first().hide();
        $nums.hide();
        if(numLimit < 1)
        	numLimit = 2;
        var $temp = {};
        if ($nums.filter('.active').is($nums.first())){
        	$temp = $nums.first().show();
        	for (var j = 0; j < numLimit; j++) {
        		$temp = $temp.next().show();
        	}
        }
        else if ($nums.filter('.active').is($nums.last())){
        	$temp = $nums.last().show();
        	for (var j = 0; j < numLimit; j++) {
        		$temp = $temp.prev().show();
        	}
        }
        else {
        	$temp = $('#nav a[rel="' + currPage + '"]').show();
        	for (var j = 0; j < numLimit; j++) {
        		$temp = $temp.prev().show();
        	}
        	$temp = $('#nav a[rel="' + currPage + '"]').show();
        	for (var j = 0; j < numLimit; j++) {
        		$temp = $temp.next().show();
        	}
        }
    }).find('a.active').trigger('click');

	});