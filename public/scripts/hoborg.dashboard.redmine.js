$.widget("ui.Hoborg_Dashboard_Redmine", {
	options : {},

	_defaults : {
		refresh: 50000,
		colors: {
			green: '#207A20',
			red: '#9E1E1E',
			yellow: '#D0AC41'
		}
	},

	_create : function(options) {
		this.options = $.extend(this._defaults, options);
		
		this.decorate();
		this.init();
	},

	decorate : function() {
	},

	init : function() {
		this.redmineHost = this.element.attr('redmine-url');
		this.mode = 'bar';
		if ($('#meter', this.element).length > 0) {
			console.log($('#meter', this.element));
			this.mode = 'meter';
		}

		$.ajax({
		    dataType: 'xml',
		    url: this.redmineHost + '/issues.xml',
		    data: {
			    'project_id': 'hoborg',
			    'query_id': '3'
			},
		    type: 'GET',
		    context: this,
		    success: function(data) { this.handleData(data); }
		});
		
	},
	
	handleData: function(data) {
		var done = 0;
		var done_nodes = $('done_ratio', $(data));
		done_nodes.each(function(i, el) { done += ($(el).text())/done_nodes.length; });
		
		if ('bar' == this.mode) {
			$('.done_ratio', this.element).text(' ' + Math.round(done) + '%');
			$('.h-widget-progressBar .green', this.element).animate({width: done+'%'}, 1500);
			
			return;
		}
		
		if ('meter' == this.mode) {
			
			var beginDate = new Date(2011, 04, 31);
			var endDate = new Date(2011, 05, 24);
			var l = endDate.getTime() - beginDate.getTime();
			var nowDate = new Date();
			var inSprint = nowDate.getTime() - beginDate.getTime();
			var greenDelta = 7;
			var yellowDelta = 20;
			
			var yellowStart = (inSprint/l*100 - yellowDelta) > 100 ? 100 : ((inSprint/l*100 - yellowDelta) < 0) ? 0 : (inSprint/l*100 - yellowDelta);
			var greenStart = (inSprint/l*100 - greenDelta) > 100 ? 100 : (inSprint/l*100 - greenDelta) < 0 ? 0 : (inSprint/l*100 - greenDelta);
			
			var doneColor = this.options.colors.red;
			if (done > (inSprint/l*100 - yellowDelta) && done < (inSprint/l*100 + yellowDelta)) {
				doneColor = this.options.colors.yellow;
			}
			if (done > (inSprint/l*100 - greenDelta) && done < (inSprint/l*100 + greenDelta)) {
				doneColor = this.options.colors.green;
			}
			
			$('.done_ratio', this.element).text(' ' + Math.round(done) + '%').css({color: doneColor});
			
			var meter = new RGraph.Meter('meter', 0, 100, done);
			meter.Set('chart.background.barcolor1', 'black');
			meter.Set('chart.background.barcolor2', 'black');
			
			meter.Set('chart.green.start', 0); // green is red
			meter.Set('chart.green.end', 100);
			meter.Set('chart.green.color', '#9E1E1E');
	        meter.Set('chart.yellow.start', yellowStart );
	        meter.Set('chart.yellow.end', (inSprint/l*100 + yellowDelta) > 100 ? 100 : (inSprint/l*100 + yellowDelta) );
	        meter.Set('chart.red.start', greenStart ); // red is green
	        meter.Set('chart.red.end', (inSprint/l*100 + greenDelta) > 100 ? 100 : (inSprint/l*100 + greenDelta) );
	        meter.Set('chart.red.color', '#207A20');
	        
	        meter.Set('chart.shadow', true);
	        meter.Set('chart.shadow.color', 'black');
	        meter.Set('chart.shadow.offsetx', 0);
	        meter.Set('chart.shadow.offsety', 0);
	        meter.Set('chart.shadow.blur', 15);
	        
			meter.Draw();
			return;
		}
	}
});

$(document).ready(function() {
	$('div.h-widget-redmine').Hoborg_Dashboard_Redmine();
});
