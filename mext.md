<h2 id="mumps-extensions">Mumps extensions</h2>
<h3 id="how-its-done">How it’s done:</h3>
<p>Write your a source code in a file name</p>
<pre><code>name.mes
</code></pre>
<p>the  framework will load this source mumps and compile it into a:</p>
<pre><code>name.m
</code></pre>
<p>this new source will have the full mumps native lines READY to run inside the mumps</p>
<p>The m framework HTML will build a .mes routine for each &lt;m&gt; group in the HTML:</p>
<pre class=" language-html"><code class="prism  language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>m</span><span class="token punctuation">&gt;</span></span>
START ;
	; MUMPS CODE
	S A=1
	W !,A
	Q
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>m</span><span class="token punctuation">&gt;</span></span>
</code></pre>
<p>so, if this mumps code inside the HTML is a .mes you can use the M extensions , native inside the HTML.<br>
example:</p>
<pre class=" language-html"><code class="prism  language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>m</span><span class="token punctuation">&gt;</span></span>
START	;
	FOR I IN ^MYLIST(10) D
	.W !,I
	Q
<span class="token tag"><span class="token tag"><span class="token punctuation">&lt;/</span>m</span><span class="token punctuation">&gt;</span></span>
</code></pre>

