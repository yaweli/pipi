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
<h3 id="the-extension-guide">the extension guide</h3>

<table>
<thead>
<tr>
<th>command</th>
<th>for</th>
<th>translated to</th>
</tr>
</thead>
<tbody>
<tr>
<td>FOR I IN ^GL(1) D IT</td>
<td>loop thru a list</td>
<td>N I S I="" F  S I=$O(^GL(1,I)) Q:I=""  D IT</td>
</tr>
<tr>
<td>#INCLUDE</td>
<td>include a routine inside my code</td>
<td></td>
</tr>
<tr>
<td>VERSION()</td>
<td>auto add versen for each update</td>
<td>VERSION() Q “1.01.001”</td>
</tr>
</tbody>
</table>
