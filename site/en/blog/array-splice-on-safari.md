
### Why you should **update your Mustache.js**

If your mustache template renders in more then 2-5s on iPad or iPhone
and you want to bring that number **down to 30ms**, have a quick read :)



#### Background

After profiling one web application I've found some worying JS
performance issues on mobile devices. Some of the big templates ware
taking more than 4, 5 or even 10 sekonds to render!! To make things
more fun, only i-devices ware effected.

Short investigation revield that `squashTokens` is taking 99% of that 
time. Turned out that array splice is really slow. Here's the original
function:

~~~~~
function squashTokens(tokens) {
  var lastToken;

  for (var i = 0; i < tokens.length; ++i) {
    var token = tokens[i];

    if (lastToken && lastToken.type === "text" && token.type === "text") {
      lastToken.value += token.value;
      tokens.splice(i--, 1); // Remove this token from the array.
    } else {
      lastToken = token;
    }
  }
}
~~~~~

The fix was simple - instead of manipulating original array, let's build
new one! Simple idea, even simpler implementation.

~~~~~
function squashTokens(tokens) {
  var token, lastToken, squashedTokens = [];

  for (var i = 0; i < tokens.length; ++i) {
    token = tokens[i];

    if (lastToken && lastToken.type === "text" && token.type === "text") {
      lastToken.value += token.value;
    } else {
      lastToken = token;
      squashedTokens.push(token);
    }
  }

  return squashedTokens; 
}
~~~~~



#### Why **V8** was so **Fast**

Why mustache runs so fast on V8?  
I'm not sure if that's true or not, but apparently `splice(index, 1)`
was optimized and runs arround x100 faster then for instance 
`splice(index, 2)` - that's something I need to test :)



#### What **Next**?

I will try to setup browserscope speed tests for mustache.js. 



#### **Testing** The Fix

I did some testing today (9 Nov 2012) on various mobile devices.
You can check the test template in the source of this page or just run
`$('#tpl').html()` in JS console. Data for template is very small and
simple. And here are some interesting numbers:

~~~~~
| Device           | OS        | avg time v-0.7.0 | avg time v-master |
+------------------+-----------+------------------+-------------------+
| ipad2            | iOS 5.1.1 | 4142             | 33                |
| ipad3            | iOS 6.0.0 | 5037             | 34                |
| iphone 5         | iOS 6.0.1 | 3428             | 20                |
| iphone 3GS       | iOS 4.3   | 7925             | 128               |
| experia mini pro | A 2.3.4   | 124              | 95                |
| samsung GT-l9300 | A 4.1.1   | 57               | 30                |
| asus TF101       | A 4.0.3   | 44               | 23                |
~~~~~

If you want, you can run these tests in **your browser**, simply click bellow
buttons (links) and check numbers.

<a class="btn btn-one">Mustache 0.7.0 Test</a>
<table style="margin: -10px 0px 20px 0px;">
<thead>
  <tr>
    <th>total time in ms&amp;nbsp;</th>
    <th>output length</th>
  </tr>
  <tr><td>avg: <span class="avg"></span></td><td></td></tr>
</thead>
<tbody class="out-one"></tbody></table>


<a class="btn btn-two">Mustache master branch Test</a>
<table style="margin: -10px 0px 20px 0px;">
<thead>
  <tr>
    <th>total time in ms&amp;nbsp;</th>
    <th>output length</th>
  </tr>
  <tr><td>avg: <span class="avg"></span></td><td></td></tr>
</thead>
<tbody class="out-two"></tbody>
</table>

<a class="btn btn-three">Mustache 0.5.0-dev Test</a>
<table style="margin: -10px 0px 20px 0px;">
<thead>
  <tr>
    <th>total time in ms&amp;nbsp;</th>
    <th>output length</th>
  </tr>
  <tr><td>avg: <span class="avg"></span></td><td></td></tr>
</thead>
<tbody class="out-three"></tbody>
</table>
JS function used in test.

~~~~~
function benchmark(m) {

        m.clearCache();

        var tic = new Date().getTime();
        var r = m.render(tpl, tplData)
        var toc = new Date().getTime();
}

~~~~~

<script src="//get.hoborglabs.com/mustache-test/mustache.js"></script>
<script src="//get.hoborglabs.com/mustache-test/mustache.new.js"></script>
<script src="//get.hoborglabs.com/mustache-test/mustache.0.5.js"></script>
<script type="text/template" id="tpl">
<div class="this will create a lot of tokens to squash">
	<p>{{name}}</p>
	<p class="mollis quis malesuada sit amet fermentum a sem">Lorem ipsum dolor sit ament. Praesent elementum, risus id laoreet gravida, ligula odio sagittis ante, id gravida purus libero vel quam. Cras nec augue ac sem ornare fermentum. Mauris nulla lacus, commodo non hendrerit id, ullamcorper eget nisi. Fusce at nisi sed velit sollicitudin tincidunt eu non magna.</p>
	<ul>
		<li class="auctor eros ac lacus euismod tristique">Maecenas neque ligula, porttitor vel congue sed, bibendum nec lectus. Donec vitae tortor ipsum, vitae facilisis velit. Praesent vehicula diam non lacus consequat a vestibulum velit mollis. Fusce interdum gravida risus, sed pharetra urna convallis nec. Suspendisse potenti.</li>
		<li>
			<div>
				<p>{{name}}</p>
				<p class="mollis quis malesuada sit amet fermentum a sem">Lorem ipsum dolor sit ament. Praesent elementum, risus id laoreet gravida, ligula odio sagittis ante, id gravida purus libero vel quam. Cras nec augue ac sem ornare fermentum. Mauris nulla lacus, commodo non hendrerit id, ullamcorper eget nisi. Fusce at nisi sed velit sollicitudin tincidunt eu non magna.</p>
				<a href="">Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. In vehicula ornare facilisis.</a>
			</div>
		</li>
		<li>
			<p class="mollis quis malesuada sit amet fermentum a sem">Lorem ipsum dolor sit ament. Praesent elementum, risus id laoreet gravida, ligula odio sagittis ante, id gravida purus libero vel quam. Cras nec augue ac sem ornare fermentum. Mauris nulla lacus, commodo non hendrerit id, ullamcorper eget nisi. Fusce at nisi sed velit sollicitudin tincidunt eu non magna.</p>
			<p class="mollis quis malesuada sit amet fermentum a sem">Lorem ipsum dolor sit ament. Praesent elementum, risus id laoreet gravida, ligula odio sagittis ante, id gravida purus libero vel quam. Cras nec augue ac sem ornare fermentum. Mauris nulla lacus, commodo non hendrerit id, ullamcorper eget nisi. Fusce at nisi sed velit sollicitudin tincidunt eu non magna.</p>
			<p class="mollis quis malesuada sit amet fermentum a sem">Lorem ipsum dolor sit ament. Praesent elementum, risus id laoreet gravida, ligula odio sagittis ante, id gravida purus libero vel quam. Cras nec augue ac sem ornare fermentum. Mauris nulla lacus, commodo non hendrerit id, ullamcorper eget nisi. Fusce at nisi sed velit sollicitudin tincidunt eu non magna.</p>
		</li>
	</ul>
	{{#list}}
	<div>
		<div>
			<ul>
				<li>{{ a }}</li>
				<li>
					<p class="mollis quis malesuada sit amet fermentum a sem">Lorem ipsum dolor sit ament. Praesent elementum, risus id laoreet gravida, ligula odio sagittis ante, id gravida purus libero vel quam. Cras nec augue ac sem ornare fermentum. Mauris nulla lacus, commodo non hendrerit id, ullamcorper eget nisi. Fusce at nisi sed velit sollicitudin tincidunt eu non magna.</p>
				</li>
				<li>{{ b }}</li>
				<li>
					<p class="mollis quis malesuada sit amet fermentum a sem">Lorem ipsum dolor sit ament. Praesent elementum, risus id laoreet gravida, ligula odio sagittis ante, id gravida purus libero vel quam. Cras nec augue ac sem ornare fermentum. Mauris nulla lacus, commodo non hendrerit id, ullamcorper eget nisi. Fusce at nisi sed velit sollicitudin tincidunt eu non magna.</p>
				</li>
				<li>{{ c }}</li>
				<li>
					<p class="mollis quis malesuada sit amet fermentum a sem">Lorem ipsum dolor sit ament. Praesent elementum, risus id laoreet gravida, ligula odio sagittis ante, id gravida purus libero vel quam. Cras nec augue ac sem ornare fermentum. Mauris nulla lacus, commodo non hendrerit id, ullamcorper eget nisi. Fusce at nisi sed velit sollicitudin tincidunt eu non magna.</p>
				</li>
			</ul>
		</div>
	</div>
	{{/list}}
<p>{{name}}</p>
        <p class="mollis quis malesuada sit amet fermentum a sem">Lorem ipsum dolor sit ament. Praesent elementum, risus id laoreet gravida, ligula odio sagittis ante, id gravida purus libero vel quam. Cras nec augue ac sem ornare fermentum. Mauris nulla lacus, commodo non hendrerit id, ullamcorper eget nisi. Fusce at nisi sed velit sollicitudin tincidunt eu non magna.</p>
        <ul>
                <li class="auctor eros ac lacus euismod tristique">Maecenas neque ligula, porttitor vel congue sed, bibendum nec lectus. Donec vitae tortor ipsum, vitae facilisis velit. Praesent vehicula diam non lacus consequat a vestibulum velit mollis. Fusce interdum gravida risus, sed pharetra urna convallis nec. Suspendisse potenti.</li>
                <li>
                        <div>
                                <p>{{name}}</p>
                                <p class="mollis quis malesuada sit amet fermentum a sem">Lorem ipsum dolor sit ament. Praesent elementum, risus id laoreet gravida, ligula odio sagittis ante, id gravida purus libero vel quam. Cras nec augue ac sem ornare fermentum. Mauris nulla lacus, commodo non hendrerit id, ullamcorper eget nisi. Fusce at nisi sed velit sollicitudin tincidunt eu non magna.</p>
                                <a href="">Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. In vehicula ornare facilisis.</a>
                        </div>
                </li>
                <li>
                        <p class="mollis quis malesuada sit amet fermentum a sem">Lorem ipsum dolor sit ament. Praesent elementum, risus id laoreet gravida, ligula odio sagittis ante, id gravida purus libero vel quam. Cras nec augue ac sem ornare fermentum. Mauris nulla lacus, commodo non hendrerit id, ullamcorper eget nisi. Fusce at nisi sed velit sollicitudin tincidunt eu non magna.</p>
                        <p class="mollis quis malesuada sit amet fermentum a sem">Lorem ipsum dolor sit ament. Praesent elementum, risus id laoreet gravida, ligula odio sagittis ante, id gravida purus libero vel quam. Cras nec augue ac sem ornare fermentum. Mauris nulla lacus, commodo non hendrerit id, ullamcorper eget nisi. Fusce at nisi sed velit sollicitudin tincidunt eu non magna.</p>
                        <p class="mollis quis malesuada sit amet fermentum a sem">Lorem ipsum dolor sit ament. Praesent elementum, risus id laoreet gravida, ligula odio sagittis ante, id gravida purus libero vel quam. Cras nec augue ac sem ornare fermentum. Mauris nulla lacus, commodo non hendrerit id, ullamcorper eget nisi. Fusce at nisi sed velit sollicitudin tincidunt eu non magna.</p>
                </li>
        </ul>

        {{#list}}
        <div>
                <div>
                        <ul>
                                <li>{{ a }}</li>
                                <li>
                                        <p class="mollis quis malesuada sit amet fermentum a sem">Lorem ipsum dolor sit ament. Praesent elementum, risus id laoreet gravida, ligula odio sagittis ante, id gravida purus libero vel quam. Cras nec augue ac sem ornare fermentum. Mauris nulla lacus, commodo non hendrerit id, ullamcorper eget nisi. Fusce at nisi sed velit sollicitudin tincidunt eu non
 magna.</p>
                                </li>                                <li>{{ b }}</li>
                                <li>
                                        <p class="mollis quis malesuada sit amet fermentum a sem">Lorem ipsum dolor sit ament. Praesent elementum, risus id laoreet gravida, ligula odio sagittis ante
, id gravida purus libero vel quam. Cras nec augue ac sem ornare fermentum. Mauris nulla lacus, commodo non hendrerit id, ullamcorper eget nisi. Fusce at nisi sed velit sollicitudin tincidunt eu non
 magna.</p>                                </li>                                <li>{{ c }}</li>
                                <li>
                                        <p class="mollis quis malesuada sit amet fermentum a sem">Lorem ipsum dolor sit ament. Praesent elementum, risus id laoreet gravida, ligula odio sagittis ante
, id gravida purus libero vel quam. Cras nec augue ac sem ornare fermentum. Mauris nulla lacus, commodo non hendrerit id, ullamcorper eget nisi. Fusce at nisi sed velit sollicitudin tincidunt eu non
 magna.</p>
                                </li>                        </ul>
                </div>        </div>
        {{/list}}

</div>
</script>
<script src="/static/en/blog/array-splice-on-safari.js"></script>
