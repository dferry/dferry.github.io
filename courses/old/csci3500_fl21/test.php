<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><head>

<style>
table.schedule td {
	height: 4em;
	overflow: visible;
}

.due {
	background-color:yellow;
}
.inactive {
  pointer-events: none;
  cursor: default;
  color: black;
  text-decoration: none;
}
</style>

<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1"><title>CSCI 3500 - Operating Systems</title></head>

<body><h2 style="text-align: center;"><img alt="SLU logo" src="http://cs.slu.edu/~dferry/SLU_logo_horz.png" style="height:5em"><br></h2><h2 style="text-align: center;">CSCI 3500: Operating Systems - Class Page<br>

</h2><h2 style="text-align: center;">Fall 2018</h2>

<table style="width: 100%; text-align: left;" border="0" cellpadding="2" cellspacing="2"> <tbody> <tr>
    <td style="vertical-align: top; font-weight: bold; width: 163px;">Instructor</td> 
    <td style="vertical-align: top; width: 1019px;"><span style="font-family: monospace;"><a href="mailto:david.ferry@slu.edu">David Ferry</a>,  <a href="http://cs.slu.edu/~dferry/">Homepage</a></span></td> 
</tr>

<tr>
    <td style="vertical-align: top; font-weight: bold; width: 163px;">Course Web Site</td> 
    <td style="vertical-align: top; width: 1019px;"><span style="font-family: monospace;"><a href="http://cs.slu.edu/~dferry/courses/csci3500">http://cs.slu.edu/~dferry/courses/csci3500/</a></span></td>
</tr>

<tr>
    <td style="vertical-align: top; font-weight: bold; width: 163px;">Course meeting times</td> 
    <td style="vertical-align: top; width: 1019px;">Monday, Wednesday, &amp; Friday from 11:00 - 11:50, Ritter Hall Rm. 115</td> 
</tr> 

<tr>
    <td style="vertical-align: top; width: 163px;"><span style="font-weight: bold;">Midterm exam</span><br> </td> 
    <td style="vertical-align: top; width: 1019px;">October 12th<br> </td>
</tr> 

<tr>
    <td style="vertical-align: top; width: 163px;"><span style="font-weight: bold;">Final exam</span><br> </td> 
    <td style="vertical-align: top; width: 1019px;">Dec 14th, 8:00 - 8:50<br> </td>
</tr> 

<tr>
    <td style="vertical-align: top; font-weight: bold; width: 163px;">Office hours</td>
    <td style="vertical-align: top; width: 1019px;">See <a href="http://cs.slu.edu/~dferry/schedule.html">my schedule</a></td> 
</tr> 

<!--
<tr>
    <td style="vertical-align: top; font-weight: bold; width: 163px;">Prerequisites</td>
    <td style="vertical-align: top; width: 1019px;">CSE 422S (Operating Systems) and C/C++ programming experience</td> </tr> 
-->

<!--
<tr> 
    <td style="vertical-align: top; width: 163px;">
<span style="font-weight: bold;">TA</span><br> </td> 
    <td style="vertical-align: top; font-weight: bold; width: 1019px;"><span style="font-weight: normal;">Benny Hill (bah2 AT cse.wustl.edu)</span><br style="font-weight: normal;"><span style="font-weight: normal;">Office Hours: Tu, Th 2pm-3pm</span> </td> </tr> </tbody> 
-->
</table>

<hr style="width: 100%; height: 2px;">

<font size=+2><strong>Contents</strong></font>
<ol>
  <li><a href="#Course Description">Course Description</a>
  <li><a href="#Prerequisites">Prerequisites</a>
  <li><a href="#Studios">Studios</a>
  <li><a href="#Labs">Labs</a>
  <li><a href="#Schedule">Course Schedule</a>
  <li><a href="#gitinfo">SLU Git Repository</a>
  <li><a href="#Textbooks">Textbooks and Other Resources</a>
  <li><a href="#Grading">Grading</a>
  <li><a href="#Academic Honesty">Academic Honesty</a>
  <li><a href="#Academic Support">Academic Support</a>
    <li><a href="#Disability Services">Disability Services</a>
  <li><a href="#Title IX Statement">Title IX Statement</a>
</ol>

<hr style="width: 100%; height: 2px;"><p>
<h3><a name="Course Description">Course Description</a></h3>

<p>Operating systems are the fundamental bridge between computer hardware and the
software programs we create and use. As a concept, operating systems are one
of the oldest software disciplines, yet they continue to adapt and reinvent
themselves as the computing landscape evolves. Modern operating systems must
tackle the same challenges of the original mainframes, but must also meet the
varied needs of personal computers, severs, mobile/embedded devices, and
virtualized systems.</p>

<p>
The four elements of this course are lectures, studios, labs, and exams.
Studios are short assignments intended to be completed primarily within class
time and to augment lecture topics. Labs are longer assignments that will
ask students to apply and analyze OS mechanisms. Most class periods will
consist of a short lecture followed by studio time. Expect a lab assignment
approximately every two weeks.</p> 

<p>
Topical outline:
<ul>
  <li>The operating system, system libraries, and user applications
  <li>System calls and interrupts
  <li>User programs, processes, and threads
  <li>Processor sharing and operating system scheduling
  <li>Race conditions, locks, and mutual exclusion
  <li>The address space abstraction and virtual memory address translation
  <li>Virtual memory via paged memory and historical approaches
  <li>File systems and disk organization
  <li>7-layer OSI and 4-layer TCP/IP networking models
  <li>Sockets programming
  <li>Read, write, and execute permissions and institutional access models
</ul>
</p>

<p>
Assessment Objectives- at the completion of this course, students will be able to:
<ul>
<li>Describe how operating systems facilitate and interact with system libraries and user space programs via the system call and interrupt mechanisms
<li>Describe the purpose and implementation of major operating system abstractions: processes, threads, virtual memory, and the network stack
<li>Identify the presence/absence of race conditions and resolve race conditions with locking
<li>Reason about concurrency in programming, and write concurrent (multiple process) programs
<li>Write simple multi-threaded programs (e.g. with Pthreads and OpenMP)
<li>Write simple networked programs (e.g. with sockets programming)
</ul>
</p>

<p><i><b>Catalog Description:</b>Theory and practice of operating systems, with emphasis on one of the UNIX family of operating systems. File organization and database systems. Focus on a multi-user system in the client-server model. Hands-on experience.</i></p>

<hr style="width: 100%; height: 2px;"><p>
<h3><a name="Prerequisites">Prerequisites</a></h3>
<ul>
  <li>CSCI 2100 - Data Structures
  <li>One of: CSCI 2400 - Computer Architecture or ECE 3217 - Computer Architecture and Organization 
  <li>Some experience: C or C++
  <li>Some experience: object-oriented programming
  <li>Studios and lab assignments are constructed around the Linux terminal, prior
experience is beneficial but not required
</ul>

<p>Please see the instructor if you're missing a prerequisite or uncertain
about your preparation for this course.</p>

<hr style="width: 100%; height: 2px;"><p>
<h3><a name="Studios">Studios</a></h3>

<p>Computer science is an eminently <i>practical</i> discipline, and
studios are daily assignments intended to complement and reinforce lectures
through practice.
Studios will be completed in a team of two students. Students from different
teams may discuss studios, but sharing of code or solutions is strictly
prohibited.</p>

<p>Studios are due approximately quarterly. 
The midterm exam and other cirumstances
may modify this, see the complete course schedule below.</p> 

<p> 
Studios will be graded on a trimodal scale: complete, partial credit, or no credit.
Studios that are turned in late or not turned in at all will receive
no credit, studios graded as partial will receive 60% credit.</p>

<hr style="width: 100%; height: 2px;"><p>
<h3><a name="Labs">Labs</a></h3>

<p>There will be five lab assignments for this course. These are programming assignments whose purpose is to apply course concepts and to analyze operating system mechanisms. As such, each lab will require a written report detailing your findings in addition to a code submission.</p>

<p>Some labs will require a team of two students, while others are individual projects. Students from different teams may discuss the lab assignments <b>only during course meeting times</b>. Students from the same team are of course encouraged to discuss and work on lab assignments at any time. </p> 

<p>Labs submitted on time (as determined by electronic time stamp) are eligible for full credit. Labs submitted up to 24 hours late will be given a <b>ten percent penalty</b>. Labs submitted between 24 and 48 hours late will be given a <b>twenty percent penalty</b>. Labs submitted after 48 hours late will not be given credit, except in the case of extenuating circumstances pre-approved by the instructor.</p>

<hr style="width: 100%; height: 2px;"><p>
<h3><a name="Schedule">Course Schedule</a></h3>

A tentative course schedule is below. <b>Note that this schedule may change
over the course of the semester.</b> When changes occur, students will be 
given enough advance notice so that readings and 
other preparation may be accommodated. 


<?php

class schedRow
{
	public $date;
	public $topicBefore;
	public $topicAfter;
	public $readingsBefore;
	public $readingsAfter;
	public $studiosBefore;
	public $studiosAfter;
	public $labsBefore;
	public $labsAfter;

	public function __construct($date, $tB, $tA, $rB, $rA, $sB, $sA, $lB, $lA)
	{
		$this->date = $date;
	}
}

$sched=array();

$row = new schedRow();


?>



<center><table class="schedule" border="4" style="width:100%">


<tr>
	<th style="width:15%">Date</th>
	<th>Topic</th>
	<th>Readings</th>
	<th>Studios</th>
	<th>Labs</th>
</tr>

<tr>
	<th>Aug 27</th>
	<th>Intro to OS</th>
	<th>MOS 1.1 - 1.3</th>
	<th><i>Make sure you can login<br>for next time</i></th>
	<th><a href="labs/01_syscalls.html">Lab 1 Assigned</a><br/></th>
</tr>

<tr>
	<th>Aug 29</th>
	<th>Types of OSes, OS concepts</th>
	<th>MOS 1.4 and 1.5</th> 
 	<th><a href="studios/01_hello_world.html">Studio 1</a></th>
	<th></th>
</tr>

<tr>
	<th>Aug 31</th>
	<th><a href="./labs/crypt_example.c">Lab 1 Discussion<br>(ecb_crypt example)</a></th>
	<th></th>
 	<th><a href="studios/02_in_out.html">Studio 2</a></th>
	<th></th>
</tr>

<tr>
	<th>Sep 3</th>
	<th colspan=4 style="color:red;">No class: Labor Day</th>
</tr>

<tr>
	<th>Sep 5</th>
	<th>System calls and OS architectures</th>
	<th>MOS 1.6 - 1.8<br>
	<code>man syscalls</code></th>
	<th><a href="studios/03_pointers.html">Studio 3</a></th>
	<th><span style="text-decoration:line-through;color:red">Lab 1 Due</span></th>
</tr>

<tr>
	<th>Sep 7</th>
	<th>Processes</th>
	<th>MOS 2.1</th>
	<th><a href="studios/04_errors.html">Studio 4</a></th>
	<th class="due">Lab 1 Due</th>
</tr>

<tr>
	<th>Sep 10</th>
	<th><code>fork()</code>, <code>exec()</code>, <code>wait()</code>, and <code>kill()</code></th>
	<th></th>
 	<th><a href="studios/05_fork.html">Studio 5</a></th>
	<th><a href="labs/02_processes.html">Lab 2 Assigned</a></th>
</tr>

<tr>
	<th>Sep 12</th>
	<th>Lab 2 Discussion</th>
	<th></th>
	<th><a href="studios/06_strtok.html">Studio 6</a></th>
	<th></th>
</tr>

<tr>
	<th>Sep 14</th>
	<th>Pipes, <code>stdin</code>, <code>stdout</code></th>
	<th>MOS 2.2</th>
	<th><a href="studios/07_pipes.html">Studio 7</a></th>
	<th></th>
</tr>

<tr>
	<th>Sep 17</th>
	<th>Threads</th>
	<th></th>
 	<th><a href="studios/08_signals.html">Studio 8</a></th> 
	<th></th>
</tr>

<tr>
	<th>Sep 19</th>
	<th>Pthreads, C++11 threads</th>
	<th>MOS 2.3</th>
 	<th><a href="studios/09_threads.html">Studio 9</a></th> 
	<th></th>
</tr>

<tr>
	<th>Sep 21</th>
	<th>Race conditions, critical sections, locks, and atomicity</th>
	<th>MOS 2.5.1</th>
	<th class="due"><a href="studios/10_race.html">Studio 10</a><br>
	Studios 1 through 7 Due</th>
	<th></th>
</tr>

<tr>
	<th>Sep 24</th>
	<th>Mutexes, semaphores</th>
	<th></th>
	<th><a href="studios/11_mutex.html">Studio 11</a></th>
	<th class="due">Lab 2 Due</th>
</tr>

<tr>
	<th>Sep 26</th>
	<th>Atomic Instructions</th>
	<th><!--<a class="inactive" href="in_class/locks.c">locks.c</a>--></th>
 	<th><a href="studios/12_atomics.html">Studio 12</a></th>
 	<th><a href="labs/03_threads.html">Lab 3 Assigned</a><br>
	<a href="labs/crypt_demo.c">crypt_demo.c</a></th>
</tr>

<tr>
	<th>Sep 28</th>
	<th>Lab 3 Discussion</th>
	<th></th>
	<th></th>
	<th></th>
</tr>

<tr>
	<th>Oct 1</th>
	<th>OpenMP, Cilk Plus</th>
	<th>MOS 2.4</th>
 	<th><a href="studios/13_openmp.html">Studio 13</a></th>
	<th></th>
</tr>

<tr>
	<th>Oct 3</th>
	<th>Batch and interactive scheduling</th>
	<th></th>
	<th><a href="studios/14_openmp2.html">Studio 14</a></th>
	<th></th>
</tr>

<tr>
	<th>Oct 5</th>
	<th>Real-time scheduling</th>
	<th></th>
	<th></th>
	<th></th>
</tr>

<tr>
	<th>Oct 8</th>
	<th>Cooperative and Preemptive Scheduling</th>
	<th></th>
	<th>
	<th class="due">Lab 3 Due</th>
</tr>

<tr>
	<th>Oct 10</th>
	<th>Midterm review <a class="inactive" href="in_class/csci3500_midterm_examples.pdf">(example questions)</a></th>
	<th></th>
	<th class="due">Studios 8 through 14 Due</th>
	<th></th>
</tr>

<tr class="due">
	<th>Oct 12</th>
	<th>Midterm Exam</th>
	<th></th>
	<th></th>
	<th></th>
</tr>

<tr>
	<th>Oct 15</th>
	<th>Memory management</th>
	<th>MOS 3.1</th>
 	<th><a class="inactive" href="studios/14_physical_mem.html">Studio 15-a</a></th>
	<th></th>
</tr>

<tr>
	<th>Oct 17</th>
	<th>Address spaces and swapping</th>
	<th>MOS 3.2</th>
 	<th><a class="inactive" href="studios/15_memory.html">Studio 15-b</a></th>
	<th></th>
</tr>

<tr>
	<th>Oct 19</th>
	<th>Virtual memory and paging</th>
	<th></th>
 	<th><a class="inactive" href="studios/16_page_tables.html">Studio 16</a></th>
	<th></th>
</tr>

<tr>
	<th>Oct 22</th>
	<th colspan=4 style="color:red;">No class: Fall Break</th>
</tr>

<!--
<tr>
	<th>Mar 12</th>
	<th colspan=4 rowspan=3 style="color:red;">No class: Spring Break</th>
</tr>
<tr><th>Mar 14</th></tr>
<tr><th>Mar 16</th></tr>
-->	

<tr>
	<th>Oct 24</th>
	<th>Exam Discussion</th>
	<th></th>
	<th></th>
	<th><!-- <a class="inactive" href="studios/csci3500_midterm_fl_2016_reinforcement.docx">Midterm Reinforcement</a> --></th>
</tr>

<tr>
	<th>Oct 26</th>
	<th>Page tables and the TLB</th>
	<th></th>
	<th><a class="inactive" href="studios/17_tlb.html">Studio 17</a></th>
	<th></th>
</tr>


<tr>
	<th>Oct 29</th>
	<th>Lab 4 Discussion</th>
	<th></th>
	<th></th>
 	<th><a class="inactive" href="labs/04_malloc.html">Lab 4 Assigned</a></th>
</tr>

<tr>
	<th>Oct 31</th>
	<th>Page Replacement Algorithms</th>
	<th></th>
 	<th><a class="inactive" href="studios/18_page_replacement.html">Studio 18</a></th> 
	<th></th>
</tr>

<tr>
	<th>Nov 1</th>
	<th>Linux Memory Maps</th>
	<th></th>
	<th></th>
	<th></th>
</tr>

<!--
<tr>
	<th>Mar 30</th>
	<th colspan=4 style="color:red;">No class: Good Friday</th>
</tr>

<tr>
	<th>Apr 2</th>
	<th colspan=4 style="color:red;">No class: Easter Monday</th>
</tr>
-->

<tr>
	<th>Nov 5</th>
	<th>Files and the File System</th>
	<th></th>
	<th><a class="inactive" href="studios/19_files.html">Studio 19</a></th>
	<th></th>
</tr>

<tr>
	<th>Nov 7</th>
	<th>File allocation on disk</th>
	<th></th>
	<th class="due">Studios 15-a through 19 Due</th>
	<th></th>
</tr>

<tr>
	<th>Nov 9</th>
	<th>Directory structure and Inodes</th>
	<th></th>
	<th><a class="inactive" href="studios/20_file_systems.html">Studio 20</a></th>
	<th></th>
</tr>

<tr>
	<th>Nov 12</th>
	<th>OSI and TCP/IP Models of Networking</th>
	<th></th>
 	<th><a class="inactive" href="studios/21_networking.html">Studio 21</a></th>
	<th></th>
</tr>

<tr>
	<th>Nov 14</th>
	<th>Physical and Data Link Layers</th>
	<th></th>
 	<th><a class="inactive" href="studios/22_datalink.html">Studio 22</a></th>
	<th class="due">Lab 4 Due</th>
</tr>

<tr>
	<th>Nov 16</th>
	<th>Network Layer</th>
	<th></th>
	<th><a class="inactive" href="studios/23_network.html">Studio 23</a></th>
	<th></th>
</tr>

<tr>
	<th>Nov 19</th>
	<th>Transport Layer</th>
	<th></th>
	<th><a class="inactive" href="studios/24_sockets.html">Studio 24</a></th>
	<th></th>
</tr>


<tr>
	<th>Nov 21</th>
	<th colspan=4 style="color:red;">No class: Thanksgiving Break</th>
</tr>

<tr>
	<th>Nov 23</th>
	<th colspan=4 style="color:red;">No class: Thanksgiving Break</th>
</tr>


<tr>
	<th>Nov 26</th>
	<th>Session Layer</th>
	<th></th>
	<th></th>
	<th></th>
</tr>

<tr>
	<th>Nov 28</th>
	<th>Presentation and Application Layers</th>
	<th></th>
 	<th><a class="inactive" href="studios/25_applications.html">Studio 25</a></th>
	<th></th>
</tr>

<tr>
	<th>Nov 30</th>
	<th>Lab 5 Discussion</th>
	<th></th>
	<th></th>
 	<th><a class="inactive" href="labs/05_chat.html">Lab 5 Assigned</a></th>
</tr>

<tr>
	<th>Dec 3</th>
	<th>Security Concerns - CIA</th>
	<th></th>
	<th class="due">Studios 20 through 25 Due</th>
	<th></th>
</tr>

<tr>
	<th>Dec 5</th>
	<th>Secure Systems and a Trusted Computing Base</th>
	<th></th>
	<th></th>
	<th></th>
</tr>

<tr>
	<th>Dec 7</th>
	<th>Permission Domains and Permission Management</th>
	<th></th>
	<th></th>
	<th class="due">Lab 5 Due</th>
</tr>

<tr>
	<th>Dec 10</th>
	<th>Final Exam Review</th>
	<th></th>
	<th></th>
	<th></th>
</tr>

<tr style="background-color:yellow">
	<th>Dec 14</th>
	<th>Final Exam - 8:00AM to 8:50AM</th>
	<th></th>
	<th></th>
	<th></th>
</tr>

</table></center>

<hr style="width: 100%; height: 2px;"><p>
<h3><a name="gitinfo">SLU Git Repository</a></h3>

<p>All studios and labs will be submitted via individual course
Git repositories that are housed at SLU. You will find your
repository already has a directory structure that provides a place
for all lab and studio assignments. Your work must be in the
appropriate location for the instructor to find it and count it
for credit.</p>

<p><a href="git-info.pdf">A short guide to using SLU's git resources</a></p>


<hr style="width: 100%; height: 2px;"><p>
<h3><a name="Textbooks">Textbook and Class Resources</a></h3>

<p>Required Course textbook: <i>Modern Operating Systems, 4th Ed.</i> by 
Tanenbaum and Bos. A classic computing textbook on the fundamentals of
operating systems, with a bent towards Unix-like operating systems.

<p><b>Linux skills references:</b></p>

<p>References for Linux software development.</p>

<ul>
  <p><li><a href="http://heather.cs.ucdavis.edu/~matloff/UnixAndC/Editors/ViIntro.html"><code>vi</code> tutorial</a></p>
  <p><li>Another <a href="http://www.tutorialspoint.com/unix/unix-vi-editor.htm"><code>vi</code> tutorial</a></p>
  <p><li><a href="http://www.jesshamrick.com/2012/09/10/absolute-beginners-guide-to-emacs/"><code>emacs</code> tutorial</a></p>
  <p><li>Another <a href="http://www2.lib.uchicago.edu/keith/tcl-course/emacs-tutorial.html"><code>emacs</code> tutorial</a></p>
</ul>

<p><b>Software resources:</b></p>

<ul>
  <p><li><a href="https://chrome.google.com/webstore/detail/secure-shell/pnhechapfaindjhompbnflcldabbghjo?hl=en">Secure Shell</a>: My favorite terminal client- runs through the Chrome browser on nearly any platform. Gives a great, consistent interface between Windows, Mac, and Linux. If you've only ever used PuTTY you should really try something else!</p>

  <p><li><a href="https://www.google.com/#q=windows%20shell%20emulator">Google Search for Shell Emulators</a>: Find something that works for you!</p>
  <p><li><a href="https://winscp.net/eng/download.php">WinSCP</a>: Easily transfer files between your Windows machine and the departmental Linux machines.</p>
  <p><li><a href="http://man7.org/linux/man-pages/man1/scp.1.html"><code>scp</code> manual page</a>: Transfer files between your Mac/Linux machine and the departmental Linux machines.</p>
</ul>

<p><b>Linux kernel hacking references:</b></p>

<p>We aren't doing any kernel hacking in this course, but these are great
references if you're interested.</p>

<ul>
	<p><li><i>Linux Kernel Development</i> by Robert Love, 2010. 
This is an excellent, compact, and inexpensive text that gives the reader a good
understanding of kernel design and critical kernel source code. 
Written by a Linux kernel veteran.</p> 
	<p><li><i>
<a href="http://proquest.safaribooksonline.com/book/operating-systems-and-server-administration/linux/0596005652">Understanding the Linux Kernel</a></i> 
	by Bovet and Cesati, 2006. This is a more
	exhaustive reference to the kernel than Love's book, covering many data structures
	and code snippets in detail. Available online for free through the university's subscription
	to the O'Riley Safari service.</p>
	<p><li><i><a href="https://lwn.net/Kernel/LDD3/">Linux Device Drivers</a></i>
	by Corbet, Rubini, and Kroah-Hartman, 2005. The definitive book on hardware
	device drivers for Linux. Contains some useful reference material over kernel modules, kernel
	development, kernel locking, timing, and other topics. Available online for free through
	lwn.net.</p>
	<p><li><i><a href="http://lwn.net">LWN.net</a></i> is a news and information outlet
	for the open source community. They often run very high quality articles about kernel
	development, kernel architecture, and kernel mechanisms. When I can't find any good
	references, searching for "LWN (my_topic)" is usually helpful.</p>
	<p><li><i><a href="http://linuxjournal.com">Linux Journal</a></i> is a magazine covering
	the Linux community. They often run very high quality articles about kernel development,
	kernel architecture, and kernel mechanisms. Similar to above, searching for
	"Linux Journal (my_topic)" often yields good results.</p>
	<p><li><a href="http://lxr.free-electrons.com/source/?v=4.1">Linux Cross Reference
	by <i>free-electrons.com</i></a> This tool easily allows you to browse the Linux source 
	code as well as search for identifiers.</p>
	<p><li><i><a href="http://www.kernel.org">kernel.org</a></i> the go-to website
	for Linux kernel source code.</p>
</ul>

<hr style="width: 100%; height: 2px;"><p>
<h3><a name="Grading">Grading</a></h3>

<p>There are three activities for which you will receive credit in this course: studios, labs, and exams. Studios are daily guided assignments primarily designed to familiarize students with course concepts and development tools (i.e. knowledge and comprehension tasks). Lab assignments will ask students to apply general course concepts and analyze OS design alternatives. A midterm and final exam will evaluate your technical understanding of course concepts.</p>

<p>Studios are graded on the following scale: complete, partial credit, or no credit. Studios will not be turned back with detailed comments. Labs and exams will be graded on a points scale and will be turned back with detailed comments.</p>

<p><b>Make up exams will only be given for severe and documented reasons.</b></p>

<p>Your grade will be determined as follows:</p>

<table border="3">
<tr>
	<th>Activity</th>
	<th>Grade Percentage</th>
</tr>
<tr>
	<td>Studios</td>
	<td>20%</td>
</tr>
<tr>
	<td>Labs</td>
	<td>50%</td>
</tr>
<tr>
	<td>Midterm</td>
	<td>15%</td>
</tr>
<tr>
	<td>Final</td>
	<td>15%</td>
</tr>

</table>

<p>Grading is done on a straight scale (uncurved). The following scores are guaranteed. The grading scale may be curved upwards (in your favor)
at the discretion of the instructor.

<ul>
<li> 93% guarantees an A
<li> 90% guarantees an A-
<li> 87% guarantees a B+
<li> 83% guarantees a B
<li> 80% guarantees a B-
<li> 77% guarantees a C+
<li> 73% guarantees a C
<li> 70% guarantees a C-
<li> 60% guarantees a D
</ul>

</p>

<p>Most work assigned in this course, other than exams and some labs, is
expected to be completed collaboratively. Student teams may change from
assignment to assignment, but the sharing of written work or significant
portions of code between teams is strictly prohibited. </p>

<p>Some specific guidelines for this course:</p>

<ul>
<li>Code you submit as solutions to the programming assignments must be written by you or your team. You are not allowed to copy code from other students.</li>
<li>Copying pieces of code from in-class examples is allowed, but <b>you must cite the source of such code</b> with a comment denoting the start and finish of the copied section.</li>
<li>Copying small pieces of code from man pages, online references or other sources is generally acceptable, but to be safe you should check with me first. <b>Code from such sources must be cited</b> with a comment denoting the start and finish of the copied section.</li>
<li>Copied code that is not cited will be considered plagiarism and will be treated as cheating. Citing your code protects you from this. However, copying large portions of code is still grounds for a reduction in grade, even if it is not cheating. Please check with the instructor if you are copying more than a few lines of code!  
</ul>

<!--#include file="syllabus_statements.html" -->

</body>
</html>
