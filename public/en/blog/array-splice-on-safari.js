window.onload = function() {

var tpl = $('#tpl').html();
var tplData = {
  name: 'This is example text, very very long.',
  'list': [
    {
      a: '1', b: '2', c: '3'
    },
    {
      a: 'a', b: 'b', c: 'c'
    },
    {
      a: 'I', b: 'II', c: 'III'
    },
    {
      a: '', b: '', c: ''
    },
    {
      a: '', b: '', c: ''
    },
    {
      a: '', b: '', c: ''
    },
  ]
};
$('.btn-one').click(function() {
        benchmark(Mustache, $('.out-one'));
});
$('.btn-two').click(function() {
        benchmark(MustacheNew, $('.out-two'));
});
$('.btn-three').click(function() {
        benchmark(Mustache5, $('.out-three'));
});

function benchmark(m, out) {

	m.clearCache();

	var tic = new Date().getTime();
	var r = m.render(tpl, tplData);
        var toc = new Date().getTime();

        out.prepend($('<tr><td class="r-time">' + (toc - tic) + '</td><td>' + r.length + '</td></tr>'
		+ '<tr style="display: none;"><td colspan="2">' + r + '</td></tr>'));

	// display ony first 5 and AVG
	var sum = count = 0;
	var tr = $('tr', out).each(function(i, el) {
		el = $(el);
		if (i >= 10) {
			el.hide();
		}
		if (!(i % 2)) {
			console.log(el, $('.r-time', el).html());
			sum += parseInt($('.r-time', el).html());
			count++;
		}
		
	});
	$('.avg', out.parent('table')).html(Math.round(100*sum/count)/100);
	
}

}
