$.widget('ui.Hoborg_Dashboard_DateTime', {
	options : {},

	_defaults : {
		refresh: 50000,
		months: ['January', 'February', 'March', 'April', 'May', 'June', 
		         'July', 'August', 'September', 'October', 'November', 'December'],
		days: ['Sunday', 'Monday', "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
	},

	_create : function(options) {
		this.options = $.extend(this._defaults, options);
		
		this.decorate();
		this.init();
	},

	decorate : function() {
	},

	init : function() {
		this.handleTick();
	},
	
	handleTick: function() {
		var now = new Date();
		var h = now.getHours();
		var m = now.getMinutes();
		h = h < 10 ? '0'+h : h;
		m = m < 10 ? '0'+m : m
		
		$('.time', this.element).text(h + ':' + m);
		$('.pmam', this.element).text('');
		$('.date', this.element).text(now.getDate() + ' ' + this.options.months[now.getMonth()]);
		$('.day', this.element).text(this.options.days[now.getDay()]);
		$('.year', this.element).text(' ' + now.getFullYear());
		
	}
});

$(document).ready(function() {
	$('div.h-widget-dateTime').Hoborg_Dashboard_DateTime();
});
