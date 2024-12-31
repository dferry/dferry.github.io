<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><head>

<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1"><title>CSCI 3500 - Operating Systems</title></head>

<h2 style="text-align: center;">CSCI 3500: Studio 4<br></h2>
<h2 style="text-align: center;">Program Arguments</h2>

<hr style="width: 100%; height: 2px;">


<p></p>

<p>In this studio, you will:</p>

<ol>
  <li>Process command line arguments
  <li>Convert numeric arguments to integral types
</ol>

<hr style="width: 100%; height: 2px;"><p>
<p>
Please complete the required exercises below, as well as any optional
enrichment exercises that you wish to complete.</p> 

<p>
As you work through these exercises, please record your answers in a text
file. When finished, submit your work via the Git repository.</p> 

<!--by sending your text file and
source code to <strong>dferry@slu.edu</strong>
with the phrase <strong>
Arguments
</strong> in the subject line.</p> -->

<p><strong> Make sure that the name of each person who worked on these exercises
is listed in the first answer, and make sure you number each of your responses
so it is easy to match your responses with each exercise.</strong></p>
<hr style="width: 100%; height: 2px;"><p>

<p><h3>Required Exercises</h3></p>

<ol>
<p><li>As the answer to the first exercise, list the names of the people who
worked together on this studio.</p>

<p><li>Download <a href="pointers.c">this file</a> as a starting point. 
Open up the file and look at <code>linString</code> and
<code>winString</code>. These variables demonstrate two different
ways that you can declare character strings in C. Convince yourself of this
by printing both strings with <code>printf()</code>. The correct format
specifier to print a string looks like this:</p>

<p><code>printf("%s\n", string_pointer);</code></p>

<p><li>Before we go any further, let's set up a <i>Makefile</i> in order to
make compiling your program easy. This is a special file that specifies how
to compile your project, so rather than having to invoke GCC every time you
want to re-build your program, you can simply use the command 
<code>make</code>.</p>

<p>Create a new file called "Makefile". Inside, on the first line, create a new
<i>target</i> by typing "<code>all:</code>". On the next line, first press TAB,
and then type your compilation instructions 
(<code>gcc -o pointers pointers.c</code>). Save and quit your file.

<p>Now type <code>make</code> at the Linux terminal. This command automatically
looks for a Makefile in the current directory, and if it can find one, it will
execute the instructions found under <code>all:</code>. The <code>make</code>
program will print out the commands it executes so you can verify if it is
working correctly. Makefiles can get much more complicated, but this simple
method is suitable for small software projects.</p>

<p>Leave the answer to this exercise blank, but attach your Makefile when you
submit this studio. Note that a Makefile is mandatory for submitting Lab 1!</p>


<p><li>Now back to pointers.
In C, a string is simply a consecutive sequence of characters in memory with
an associated string pointer . (Notice that
the definition of our strings both use <code>char</code> as their base type.)
</p>

<p>We can access a string by <i>dereferencing</i> the string pointer. A pointer
points to data in memory, and dereferencing that pointer gives us the
<i>value</i> of the data. You've already done dereferencing through the use
of the square bracket <i>index notation</i>. The code
<code>linString[0]</code> gives you the first character of 
<code>linString</code>, the code <code>linString[1]</code> gives you the
second character, etc.</p>

<p>Print out each character of <code>linString</code> using a loop with
index notation.</p>

<p><li>The <i>dereference operator</i> in C is the asterisk (<code>*</code>) 
and is fundamental to using pointers. We
already know that a pointer stores the memory address of data (i.e. it points
to data). Just like indexing a pointer, the dereference operator obtains the 
<i>value</i> of the data that is pointed to.</p>

<p>If the pointer <code>winString</code> is a pointer to a
character, what character does it point to? In other words, what 
do you think is the value
of the dereference operation on <code>winString</code>?</p>

<p><li>Check your answer to the last exercise by dereferencing
<code>winString</code> and printing it out. The dereference operator is the
asterisk when placed to the left of a pointer. You can print out a single
character like so:</p>

<p><code>printf("%c\n", *pointer_to_string);</code></p>

<p>What was printed?</p>

<p><li>One useful way to use pointers is with <i>pointer arithmetic</i>.
The index notation you just used is essentially pointer arithmetic,
and in fact the C standard defines index notation in terms of pointer
arithmetic.</p>

<p>What character is stored in the byte after the first character of
<code>winString</code>?
Try printing the value of the next few bytes of <code>winString</code> using
pointer arithmetic. To do so, add one, two, or three to the pointer before 
dereferencing. For example: <code>*(pointer_to_string + 1)</code>.</p>

<p><li>Use a loop to
print the entire contents of <code>winString</code> using pointer arithmetic.
</p>

<p><li>You can also use pointers to assign values rather than simply read
values. This is done by assigning a value to a dereferenced pointer (using
either index notation or pointer arithmetic). For example, the following two
statements turn the <code>'d'</code> in "<code>Windows!</code>" into a 
<code>'u'</code>:</p>

<p><code>winString[3] = 'u';</code></p>
<p><code>*(winString + 3) = 'u';</code></p>

<p>Write the code to change the string "<code>Windows!</code>" into the
string <code>"Linux!  "</code>. Then, print <code>winString</code> again.
Copy and paste your program output as the answer to this exercise.</p>

<p><li>As has been said a few times already, pointers simply point to 
data that resides in memory. I've got one last experiment to convince you
of this, if you don't believe me already.</p>

<p>Open up your compiled executable file in a text editor. You will see a lot
of gibberish but you'll also see a few recognizable things. Use the search
function of your editor to search for the strings <code>"Linux!"</code> and
<code>"Windows!"</code>. Can you find them?</p>

<p>Now, being slightly careful, use your text editor to change 
<code>Windows!</code> to <code>Solaris!</code> and save the file. What happens
when you re-run the program?</p>

<p><i>Note: This is not the advisable way to modify a program!</i></p>

</ol>

<p><h3>Optional Enrichment Exercises</h3></p>
<ol>
<p><li>No optional exercises</p>

</ol>

<hr style="width: 100%; height: 2px;"><p>
