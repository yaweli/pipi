<h1 id="pipi">pipi</h1>
<p>mFrame project include a full mumps framework running on the Raspberry pi<br>
accessed by the browser (desktop or mobile)<br>
it’s a platform to develop a web apps / desktop apps and websites with mumps as a code<br>
that will generate nice web ui using latest bootstap</p>
<p>His big brother runs this same framework on a docker , or on any linux machine.<br>
<img src="https://pandao.github.io/editor.md/images/logos/editormd-logo-180x180.png" alt=""></p>
<h3 id="features">Features</h3>
<h4 id="mumps-extension-commands">mumps extension commands</h4>
<h4 id="a.-for-loop">a. for loop</h4>
<pre><code>  instead of those line:
</code></pre>
<pre><code>      N I
      S I=""
      F  S I=$O(^MYGLO(V1,V2,V3,I)) Q:I=""  D SOMTHING(I)
      Q
    SOMTHING(I) ;
      : 
      Q
</code></pre>
<p>just use this:</p>
<pre><code>      FOR I IN ^MYGLO(V1,V2,V3) D SOMETHING(I)
</code></pre>
<p>this new smart for loop can work no locals and on globals with any variations including indirecion like this :</p>
<pre><code>      FOR J IN @GLO D IT
</code></pre>
<h4 id="b.-include-routinename">b. #INCLUDE routineName</h4>
<p>this will merge the routineName into my routine,<br>
you can find this usefull when writing tools , and need to access a lot of labels of the tool during the entire routine , so including it will a) keep its current version and b) will let you reference the labels without label^routine - just the “label” which make a routine more clean.</p>
<h4 id="c.-auto-versioning">c. auto versioning</h4>
<p>each time you save the routine (whith changes) if you have a label name VERSION() the tool will automatically increment the subVersion , and add a timestamps , for example :</p>
<pre><code>VERSION()  Q "1.01.006" ;14/03/2019 18:06:52
</code></pre>
<p><a href="mext.md">Learn more</a></p>
<h2 id="the-framework">the framework</h2>
<p>html + mumps - one place development of your application</p>
<h4 id="exmaple-1---simple-html">exmaple 1 - simple html</h4>
<p>A mix of an html page +  javascript + a mumps code , which will run during the load of the page</p>
<pre class=" language-html"><code class="prism  language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>h2</span><span class="token punctuation">&gt;</span></span> Hello world <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>h2</span><span class="token punctuation">&gt;</span></span>
&lt;3&gt; multiplication table <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>h3</span><span class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>hr</span><span class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>m</span><span class="token punctuation">&gt;</span></span>
START	;
	W !,"DATE: ",$H,!
	W !,"<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span> <span class="token attr-name">class</span><span class="token attr-value"><span class="token punctuation">=</span>card</span><span class="token punctuation">&gt;</span></span>"
	W !,"<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span> <span class="token attr-name">class</span><span class="token attr-value"><span class="token punctuation">=</span>card-body</span><span class="token punctuation">&gt;</span></span>"
	F LIN=1:1:10 W "<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>BR</span><span class="token punctuation">&gt;</span></span>" F ROW=1:1:10 W " ",ROW*LIN
	W !,"<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span class="token punctuation">&gt;</span></span>"
	W !,"<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span class="token punctuation">&gt;</span></span>"
  Q   
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>m</span><span class="token punctuation">&gt;</span></span>  
</code></pre>
<p>result:</p>
<p><img src="https://github.com/yaweli/pipi/blob/master/example1.png" alt=""></p>
<h4 id="exmaple-2---interact-with-forms">exmaple 2 - interact with forms</h4>
<p>somtimes on application you need to check and validate a form fields</p>
<pre class=" language-html"><code class="prism  language-html">	<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>form</span><span class="token punctuation">&gt;</span></span>
		enter number: <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>input</span> <span class="token attr-name">id</span><span class="token attr-value"><span class="token punctuation">=</span>id100</span> <span class="token attr-name">type</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>text<span class="token punctuation">"</span></span> <span class="token attr-name">value</span><span class="token attr-value"><span class="token punctuation">=</span>80</span> <span class="token attr-name">name</span><span class="token attr-value"><span class="token punctuation">=</span>var1</span> <span class="token attr-name">onChange</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>mLabel(<span class="token punctuation">'</span>CHECKN<span class="token punctuation">'</span>,this)<span class="token punctuation">"</span></span> <span class="token punctuation">/&gt;</span></span> <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>br</span><span class="token punctuation">/&gt;</span></span>
		enter number: <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>input</span> <span class="token attr-name">id</span><span class="token attr-value"><span class="token punctuation">=</span>id101</span> <span class="token attr-name">type</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>text<span class="token punctuation">"</span></span> <span class="token attr-name">value</span><span class="token attr-value"><span class="token punctuation">=</span>80</span> <span class="token attr-name">name</span><span class="token attr-value"><span class="token punctuation">=</span>var2</span> <span class="token punctuation">/&gt;</span></span> <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>br</span><span class="token punctuation">/&gt;</span></span>
		enter name: <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>input</span> <span class="token attr-name">id</span><span class="token attr-value"><span class="token punctuation">=</span>id102</span> <span class="token attr-name">type</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>text<span class="token punctuation">"</span></span> <span class="token attr-name">value</span><span class="token attr-value"><span class="token punctuation">=</span>80</span> <span class="token attr-name">name</span><span class="token attr-value"><span class="token punctuation">=</span>name1</span> <span class="token punctuation">/&gt;</span></span> <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>br</span><span class="token punctuation">/&gt;</span></span>
	<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>form</span><span class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>m</span><span class="token punctuation">&gt;</span></span>
START ;
   Q
CHECKN ;
	I M&gt;100 D ALERT("BIG"),FOCUS("id100")
	I M&lt;100 D ALERT("SMALL"),FOCUS("id100") ;&gt;
	I M=100 D SETV("id100","CORRECT")
	I M=100 D FOCUS("id102")
	I M=90  D GO("next.html")
	Q
	#INCLUDE %ESLJXI
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>m</span><span class="token punctuation">&gt;</span></span>
</code></pre>
<p>use onChange=mLabel(“LABEL”,this) to instruct the browser to come check the field value in the mumps !</p>

<table>
<thead>
<tr>
<th>actions</th>
<th>description</th>
</tr>
</thead>
<tbody>
<tr>
<td>ALERT</td>
<td>show an error message</td>
</tr>
<tr>
<td>FOCUS</td>
<td>restore focus to a field</td>
</tr>
<tr>
<td>SETV</td>
<td>replace a value inside a form field</td>
</tr>
<tr>
<td>GO</td>
<td>jump to a new url</td>
</tr>
<tr>
<td>…more to come</td>
<td></td>
</tr>
</tbody>
</table><p>The #INCLUDE will help us reference the labels without the name of the routine.<br>
instead of :</p>
<pre class=" language-mumps"><code class="prism  language-mumps">D GO^%ESLJX("aaa.html")
</code></pre>
<p>just write:</p>
<pre class=" language-mumps"><code class="prism  language-mumps">D GO("aaa.html")
</code></pre>
<h4 id="exmaple-3---links">exmaple 3 - links</h4>
<pre class=" language-html"><code class="prism  language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>center</span><span class="token punctuation">&gt;</span></span>
Click on image: 
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>img</span> <span class="token attr-name">src</span><span class="token attr-value"><span class="token punctuation">=</span>/images/tree.jpg</span> <span class="token attr-name">onclick</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>mLabel(<span class="token punctuation">'</span>TREE<span class="token punctuation">'</span>,<span class="token punctuation">'</span>T<span class="token punctuation">'</span>)<span class="token punctuation">"</span></span> <span class="token punctuation">/&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>br</span><span class="token punctuation">&gt;</span></span>
Click on a link:
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>a</span> <span class="token attr-name">href</span><span class="token attr-value"><span class="token punctuation">=</span>#</span> <span class="token attr-name">onclick</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>mLabel(<span class="token punctuation">'</span>GOINFO<span class="token punctuation">'</span>,<span class="token punctuation">'</span>G<span class="token punctuation">'</span>)<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>Info<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>a</span><span class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>m</span><span class="token punctuation">&gt;</span></span>
START	;
	Q
GOINFO	;
	D GO("info.html")
	Q
TREE	;
	D GO("tree.html")
	Q
	#INCLUDE %ESLJXI
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>m</span><span class="token punctuation">&gt;</span></span>
</code></pre>
<h3 id="embeded-bootstrap">Embeded bootstrap</h3>
<p>it will be nice if the farmework will include support for bootstrap and include<br>
the js files and the css files without the need to enter a long lines.<br>
So the framework come the packs.</p>
<h4 id="bootstrap-4--jquery-popper">bootstrap 4 + jquery +popper</h4>
<pre class=" language-html"><code class="prism  language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>m#import</span> <span class="token attr-name">mpak1</span> <span class="token punctuation">/&gt;</span></span>
</code></pre>
<p><strong>mpak1</strong> : This will include all the html need to use the bootstrap + jquery</p>
<h5 id="example-1---simple-bootstrape-button">example 1 - simple bootstrape button</h5>
<pre class=" language-html"><code class="prism  language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>m#import</span> <span class="token attr-name">mpak1</span> <span class="token punctuation">/&gt;</span></span>

INFO PAGE:<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>BR</span><span class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>m</span><span class="token punctuation">&gt;</span></span>
START	;
	Q
BACK	;
	D GO^%ESLJX("start.html")
	Q
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>m</span><span class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>HR</span><span class="token punctuation">&gt;</span></span>
&lt;button type="button" class="btn btn-primary" onclick="mLabel('BACK','b')""&gt;Back<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>button</span><span class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>hr</span><span class="token punctuation">&gt;</span></span>
</code></pre>
<p><img src="https://github.com/yaweli/pipi/blob/master/EXAMPLE2.png" alt=""></p>
<h5 id="example-2---more-nice-bootstrap-elements">example 2 - more nice bootstrap elements</h5>
<pre class=" language-html"><code class="prism  language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>m#import</span> <span class="token attr-name">mpak1</span> <span class="token punctuation">/&gt;</span></span>


<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>form</span><span class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span> <span class="token attr-name">class</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>pos-f-t<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>
  <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span> <span class="token attr-name">class</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>collapse<span class="token punctuation">"</span></span> <span class="token attr-name">id</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>navbarToggleExternalContent<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span> <span class="token attr-name">class</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>bg-dark p-4<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>
		<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>div</span> <span class="token attr-name">class</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>btn-group bg-dark p-4<span class="token punctuation">"</span></span> <span class="token attr-name">role</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>group<span class="token punctuation">"</span></span> <span class="token attr-name">aria-label</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>Button group<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>
		  <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>button</span> <span class="token attr-name">type</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>button<span class="token punctuation">"</span></span> <span class="token attr-name">class</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>btn btn-secondary<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>img</span> <span class="token attr-name">width</span><span class="token attr-value"><span class="token punctuation">=</span>30</span> <span class="token attr-name">class</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>img-fluid<span class="token punctuation">"</span></span> <span class="token attr-name">src</span><span class="token attr-value"><span class="token punctuation">=</span>/im/set.png</span> <span class="token punctuation">/&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>button</span><span class="token punctuation">&gt;</span></span>
		  <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>button</span> <span class="token attr-name">type</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>button<span class="token punctuation">"</span></span> <span class="token attr-name">class</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>btn btn-secondary<span class="token punctuation">"</span></span> <span class="token attr-name">onclick</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>mLabel(<span class="token punctuation">'</span>GOINFO<span class="token punctuation">'</span>,<span class="token punctuation">'</span>i<span class="token punctuation">'</span>)<span class="token punctuation">"</span></span> <span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>img</span> <span class="token attr-name">width</span><span class="token attr-value"><span class="token punctuation">=</span>30</span> <span class="token attr-name">class</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>img-fluid<span class="token punctuation">"</span></span> <span class="token attr-name">src</span><span class="token attr-value"><span class="token punctuation">=</span>/im/inf.png</span> <span class="token punctuation">/&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>button</span><span class="token punctuation">&gt;</span></span>  
		<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span class="token punctuation">&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span class="token punctuation">&gt;</span></span>
  <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span class="token punctuation">&gt;</span></span>
  <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>nav</span> <span class="token attr-name">class</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>navbar navbar-dark bg-dark<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>button</span> <span class="token attr-name">class</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>navbar-toggler<span class="token punctuation">"</span></span> <span class="token attr-name">type</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>button<span class="token punctuation">"</span></span> <span class="token attr-name">data-toggle</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>collapse<span class="token punctuation">"</span></span> <span class="token attr-name">data-target</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>#navbarToggleExternalContent<span class="token punctuation">"</span></span> <span class="token attr-name">aria-controls</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>navbarToggleExternalContent<span class="token punctuation">"</span></span> <span class="token attr-name">aria-expanded</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>false<span class="token punctuation">"</span></span> <span class="token attr-name">aria-label</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>Toggle navigation<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>
      <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>span</span> <span class="token attr-name">class</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>navbar-toggler-icon<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>span</span><span class="token punctuation">&gt;</span></span> 
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>button</span><span class="token punctuation">&gt;</span></span>
    <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>h5</span> <span class="token attr-name">class</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>text-white h4<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>Pi zero W board manager<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>h5</span><span class="token punctuation">&gt;</span></span>
  <span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>nav</span><span class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>div</span><span class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>form</span><span class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>m</span><span class="token punctuation">&gt;</span></span>
START	; next screen
	D CARD("QUOT","BODY","W30%")
	D CARD("JOBH","JOBB","W30%")
	D CARD("IPH","IPB","W30%")
	Q
JOBH	W "Job" Q
JOBB	W JB    Q
IPH	W "I.P" Q
IPB	W VRU("REMOTE_ADDR") Q
	; 
QUOT ;
	W "Horolog"
	Q
BODY ;
	W $H
	Q
GOINFO ;
	D GO("pizinfo.html")
	Q
	#INCLUDE %ESBSI
	#INCLUDE %ESLJXI
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>m</span><span class="token punctuation">&gt;</span></span>
</code></pre>
<p>this time the mumps also generated a bootstrap elements with it’s library.<br>
you can combine BS elements as html and also BS generated inside the mumps , it’s up to you.</p>
<p><img src="https://github.com/yaweli/pipi/blob/master/EXAMPLE3.png" alt=""><br>
note:<br>
to use and include mumps bootstrap library : #INCLUDE %ESBSI then you can use to use the D CARD()</p>
<h3 id="accessing-the-gpio-on-the-pi">accessing the GPIO on the pi</h3>
<pre class=" language-html"><code class="prism  language-html">GPIO	;
	S GL=$NA(^W(JB,11)) K @GL
	D ACTIV(GL)
	w "<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>TABLE</span> <span class="token attr-name">BORDER</span><span class="token attr-value"><span class="token punctuation">=</span>2</span><span class="token punctuation">&gt;</span></span>" D  W "<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>TABLE</span><span class="token punctuation">&gt;</span></span>"
	.W "<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>TR</span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>TH</span><span class="token punctuation">&gt;</span></span>GPIO<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>TH</span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>TH</span><span class="token punctuation">&gt;</span></span>DIR<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>TH</span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>TH</span><span class="token punctuation">&gt;</span></span>Current Value<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>TH</span><span class="token punctuation">&gt;</span></span><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>TR</span><span class="token punctuation">&gt;</span></span>"
	.FOR I IN @GL D
	..S X=^(I)
	..W "<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>TR</span><span class="token punctuation">&gt;</span></span>" D  W "<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>TR</span><span class="token punctuation">&gt;</span></span>"
	...W "<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>TD</span><span class="token punctuation">&gt;</span></span>",X,"<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>TD</span><span class="token punctuation">&gt;</span></span>" ; /sys/class/gpio/gpio14 
	...W "<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>TD</span><span class="token punctuation">&gt;</span></span>",$$DIR^%ESGP(X),"<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>TD</span><span class="token punctuation">&gt;</span></span>" ; in / out
	...W "<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>TD</span><span class="token punctuation">&gt;</span></span>",$$VAL^%ESGP(X),"<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>TD</span><span class="token punctuation">&gt;</span></span>" ; 0/1
	Q
BACK ;
	D GO^%ESLJX("start.html")
	Q
FLASH ;  FLASH THE RED LIGHT - RUN THIS IN JOB CMD
	;
	D EXP(14)
	D SETDIR(14,"out") H 1
	F  D FLASH1
	Q
FLASH1	;
	D SETVAL(14,1) H 1
	D SETVAL(14,0) H 1
	Q
	#INCLUDE %ESGPI
	Q
	;
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>m</span><span class="token punctuation">&gt;</span></span>

<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>HR</span><span class="token punctuation">&gt;</span></span>
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>button</span> <span class="token attr-name">type</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>button<span class="token punctuation">"</span></span> <span class="token attr-name">class</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>btn btn-primary<span class="token punctuation">"</span></span> <span class="token attr-name">onclick</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>mLabel(<span class="token punctuation">'</span>BACK<span class="token punctuation">'</span>,<span class="token punctuation">'</span>b<span class="token punctuation">'</span>)<span class="token punctuation">"</span></span><span class="token punctuation">&gt;</span></span>Back<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>button</span><span class="token punctuation">&gt;</span></span>

<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>BR</span><span class="token punctuation">&gt;</span></span>
to make the red light on the pi flash every second<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>br</span><span class="token punctuation">&gt;</span></span>
bash script code example:
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>pre</span><span class="token punctuation">&gt;</span></span>
#!/bin/sh
cd /sys/class/gpio
echo "14" &gt; unexport
echo "14" &gt; export
cd gpio14
echo out &gt; direction
sleep 1
while true
do
        echo "1" &gt; value
        sleep 1
        echo "0" &gt; value
        sleep 1
done

if you start it on pi startup (using /etc/rc.local) the pi will flash the light forever
</code></pre>
<p><img src="https://github.com/yaweli/pipi/blob/master/led.png" alt=""></p>
<p>see it works:<br>
<a href="https://drive.google.com/file/d/1-1Cs0CPVFwJA_8xEhxe5D6U4bHGuoUnG/view?usp=sharing">https://drive.google.com/file/d/1-1Cs0CPVFwJA_8xEhxe5D6U4bHGuoUnG/view?usp=sharing</a></p>
<p>one way is to run a bash script , to flash the light every second , also add it to the linux startup</p>
<p>from th mumps with %ESGP you can</p>
<p>action|description|same as command<br>
–|-----<br>
1|get the value or direction for each gpio|cat value<br>
1|get a list of all live gpio|ls gpio*<br>
2|set the value of the direction of the pin|echo out&gt;direction<br>
4|set the value of the pin|echo “1” &gt; value<br>
5|start / stop gpio pin by export function|echo “14”&gt;export</p>
<h4 id="cgi-environment">cgi environment</h4>
<p>the mumps include the VRU() vectore with all the linux environment where the cgi include envirment for the session posted from you browser.<br>
examples:</p>
<pre class=" language-mumps"><code class="prism  language-mumps">VRU("QUERY_STRING")="a=Start&amp;REDUCI=ELI"
VRU("REMOTE_ADDR")="192.168.88.9"
VRU("REMOTE_PORT")=62994
VRU("REQUEST_METHOD")="GET"
VRU("REQUEST_SCHEME")="http"
VRU("REQUEST_URI")="/cgi-bin/es?a=Start&amp;REDUCI=ELI"
VRU(:)
</code></pre>
<p>the form variables from the url:</p>
<pre class=" language-mumps"><code class="prism  language-mumps">%PARK("REDUCI")="ELI"
%PARK("a")="Start"
</code></pre>
<p>headers</p>
<pre class=" language-mumps"><code class="prism  language-mumps">VR("Referer")="http://elilap/proj/piz/"
VR("User-Agent")="Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:66.0) Gecko/20100101 Firefox/66.0"
</code></pre>
<p>…and more, depends on the apache webserver</p>
<h3 id="mumps-enviroment-system-wide">Mumps enviroment system wide</h3>
<p>connect by ssh to getinto the linux enviroment<br>
to log into the gtm (mumps) enter <strong>m</strong></p>
<pre class=" language-sh"><code class="prism  language-sh">eli@eli-laptop:~/projects/mumps$ m

MGR&gt;
</code></pre>
<p>This mumps is DSM style which have a subdevistions of database OR namespaces we call UCI.<br>
first login will take you to the MGR uci<br>
all routines from MGR can be see on all other uci’s</p>
<p>switch between uci’s  enter <strong>D ^%UCI</strong> then the 3 upper case uci name</p>
<pre class=" language-mumps"><code class="prism  language-mumps">MGR&gt;D ^%UCI

GT.M V6.3-005 Linux x86_64 JOB 26712
UCI : ELI
WELCOME TO E.S. GTM 1.01
J26712 I/dev/pts/3
----------------------------
ELI&gt;
</code></pre>
<p>view the uci’s globals - __D ^%G __</p>
<pre class=" language-mumps"><code class="prism  language-mumps">ELI&gt;D ^%G


Global ^W()
        W()
Global ^%ZUCI
        %ZUCI
^%ZUCI("ELI") =
^%ZUCI("ELI","G") = /gtm/ELI.gld
^%ZUCI("ELI","R") = /gtm/eli/r/ /gtm/mgr/r/ /gtm/
^%ZUCI("MGR") =
^%ZUCI("MGR","G") = /gtm/MGR.gld
^%ZUCI("MGR","R") = /gtm/mgr/r/ /gtm/
Global ^
</code></pre>
<p>we are using dsm style global listing , include a lot of extensions , will be documented later on.</p>
<h3 id="gtm-management">gtm management</h3>
<p>login with ssh to the linux<br>
enter <strong>gman</strong></p>
<pre class=" language-sh"><code class="prism  language-sh">eli@eli-laptop:~/projects/mumps$ gman
Mumps manager
1 - gtm system
2 - uci
options :
1
 1 - start gtm
 2 - stop gtm
 option?
1 - gtm system
2 - uci
N - CREATE NEW UCI
D - DELETE UCI
F - FIRST TIME CREATE MGR
S - SHOW UCI INFO
M - MOUNT UCI
options:
</code></pre>
<p>Gtm management will be documented later<br>
management gtm will let you</p>
<ol>
<li>start and stop gtm</li>
<li>create remove or mount a uci</li>
<li>first time create the MGR uci</li>
</ol>
<h3 id="routine-utilities">routine utilities</h3>
<p>in addition to the GTM own utility (like %RO/%RI/%RD/%RSE/…)<br>
the m framework come wi a set of % utility routines. part of the are the source of the runs framework and other part is the mumps general utility<br>
routines:</p>

<table>
<thead>
<tr>
<th>routine name</th>
<th>description</th>
</tr>
</thead>
<tbody>
<tr>
<td>%ESD</td>
<td>date and time manipulation</td>
</tr>
<tr>
<td>%ESS</td>
<td>string and general manipulation</td>
</tr>
<tr>
<td>%ZU</td>
<td>UCI manipulation</td>
</tr>
<tr>
<td>%ESF</td>
<td>Files manipulations</td>
</tr>
<tr>
<td>%ESLIB</td>
<td>Html web development</td>
</tr>
<tr>
<td>%ESGP</td>
<td>Pi GPIO utility</td>
</tr>
<tr>
<td>%ESBS</td>
<td>bootstrape web utility</td>
</tr>
<tr>
<td>%ESLJX</td>
<td>ajax</td>
</tr>
<tr>
<td>%ESLJXI</td>
<td>ajax include</td>
</tr>
<tr>
<td>%ESDEV</td>
<td>m framework internal routine</td>
</tr>
<tr>
<td>%ESET</td>
<td>Error trap</td>
</tr>
<tr>
<td>%ESRL</td>
<td>mumps macro extensions</td>
</tr>
<tr>
<td>%ESWS</td>
<td>cgi engine</td>
</tr>
<tr>
<td>%ZGL</td>
<td>D ^%G source</td>
</tr>
<tr>
<td>%UCI</td>
<td>mapped to D ^%ZU</td>
</tr>
<tr>
<td>%G</td>
<td>mapped to D ^%ZGL</td>
</tr>
<tr>
<td>%MGR</td>
<td>jump to uci MGR</td>
</tr>
</tbody>
</table><p><strong>MGR</strong> uci will contain all the %routines + all the %globals</p>

