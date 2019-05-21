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
</table><h4 id="performance">performance</h4>
<p>the .mes files are compiled one time, the next time the routines run , it will run on the .m or better on the .o this will make the performance good the same as for the normal mumps source.</p>
<h4 id="runtime-vs-development">runtime vs development</h4>
<p>On the <em>Runtime</em> systems , you can user the .m source only , you will not need to compile the source a gain.<br>
On the <em>Development</em> system you will need this package in full. Run with it’s development kit , including the .mes framework extension</p>
<h4 id="why-only-on-raspberry-pi">Why only on Raspberry Pi?</h4>
<p>No , we can use mumps framework on three other ways , we first invest for Raspberry pi since it give this peace of hardware a real boost.</p>
<h3 id="other-platform-for-mumps-framwork">other platform for mumps framwork</h3>

<table>
<thead>
<tr>
<th>platform</th>
<th>description</th>
<th>how</th>
</tr>
</thead>
<tbody>
<tr>
<td>Raspberry Pi</td>
<td>all versions , start with zero w</td>
<td>we will publish a full system image</td>
</tr>
<tr>
<td>Linux on the cloud as a server</td>
<td>all linux support gt.m</td>
<td>will publish a guide/aws public image</td>
</tr>
<tr>
<td>Linux on my local station</td>
<td>any station , server on working station</td>
<td>will publish a guide</td>
</tr>
<tr>
<td>Docker</td>
<td>run on cloud or in any docker runtime</td>
<td>will publish an image and a Dockerfile</td>
</tr>
<tr>
<td>Fleet</td>
<td>Use for large scalable systems</td>
<td>behind an AWS load balancer as Docker Kubernetes. will publish a guide</td>
</tr>
</tbody>
</table>
