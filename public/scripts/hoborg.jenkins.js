$.widget("ui.Hoborg_Jenkins", {
	options : {},

	_defaults : {
		refresh: 50000
	},

	_create : function(options) {
		this.options = $.extend(this._defaults, options);
		
		this.decorate();
		this.init();
	},

	decorate : function() {
	},

	init : function() {
		this.jenkinsHost = this.element.attr('jenkins-url');
		$.ajax({
		    dataType: 'json',
		    url: this.jenkinsHost + '/api/json',
		    data: {
			    'tree': 'views[name,jobs[name,color,url,healthReport[description,iconUrl,score]]]'
			},
		    type: 'GET',
		    context: this,
		    success: function(data) { this.handleData(data)}
		});
	},
	
	handleData: function(data) {
		if (!data) {
			return;
		}
		var list = $('ul.h-jenkins-projects', this.element).empty();
		$.each(data.views[0].jobs, 
			$.proxy(function(i, e) { list.append(this.buildStatusRow(e)); }, this)
		);
	},
	
	buildStatusRow: function(job) {
		var li = $('<li style="background-image: url(\'' + this.jenkinsHost + '/images/24x24/' + job.color + '.png\')"></li>');
		li.append($('<span class="h-jenkins-jobname">' + job.name + '</span><span>, status: '+ job.healthReport[0].score +'/100</span>'));
		li.append(this.buildStatusIcon(job.healthReport[0]));
		
		return li;
	},
	
	buildStatusIcon: function(healtReport) {
		var imgSrc = this.jenkinsHost + '/images/24x24/' + healtReport.iconUrl;
		var img = $('<img align="center" src="' + imgSrc + '" alt="' + healtReport.description + '" title="' + healtReport.description + '"/>');
		return img;
	}
});

$(document).ready(function() {
	$('div.h-jenkins').Hoborg_Jenkins();
});

/**
 * JSONP callback function for handling JSON data from Jenkins API
 * @param data
 * @return
 */
function jsonp_Hoborg_Jenkins_handleData(data) {
	$('div.h-jenkins').Hoborg_Jenkins('handleData', data);
}