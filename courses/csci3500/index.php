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
.holiday {
	color: red;
	font-weight: bold;
}
</style>

<?php 

// This file uses a lightweight, PHP-only YAML parser
// https://github.com/mustangostang/spyc
require_once 'spyc.php';
$data = spyc_load_file( 'schedule.yml' );

//schedule format:
// each high level array element is a class day
// each class day has four item arrays: "topic", "readings", "studios", and "labs"
// each element in an Item Array represents a single printed line and has three elements
// the first of three is the text to print
// the second of three is an HTML anchor link
// the third of three is a CSS class applied to the surrounding table element
// if the second or third elements are the empty string they are ignored
// So for example:
//
// $data['Schedule'][0]['topics'][0]['text'] is the text to display for the first
//     topic line on the first day of class, and:
//
// $data['Schedule'][0]['topics'][0]['link'] is the link that goes with that and:
//
// $data['Schedule'][3]['readings'][1]['link'] is the anchor link for the 
//     second reading on the fourth day of class

//echo '<pre><a href="schedule.yml">schedule.yml</a> loaded into PHP:<br/>';
//print_r($data);
//echo '</pre>';

//echo $data['ClassType'];
//echo "\r\n";
//echo $data['ClassTime'];
//echo "\r\n";
//echo $data['Semester'];
//echo "\r\n";

//echo $data['Schedule'][1]['topics'][0]['text'];

//These values are used verbatim on the website
$CourseNum = $data['CourseNum'];
$CourseName = $data['CourseName'];
$CourseWebsite = $data['CourseWebsite'];
$ClassTime   = $data['ClassTime'];
$Semester    = $data['Semester'];
$MidtermTime = $data['MidtermTime'];
$FinalTime   = $data['FinalTime'];

//These values control how the schedule generator works
$ClassType   = $data['ClassType'];
$SchedColor1 = $data['SchedColor1'];
$SchedColor2 = $data['SchedColor2'];
$SchedHeaderColor = $data['SchedHeaderColor'];

$StartDateString = $data['StartDate'];
$StartDate       = new DateTimeImmutable($StartDateString);
$hours	         = $data['LinkActivationHours'];

$holidays = $data['Holidays'];

for( $i = 0; $i < count($holidays); $i++ ){
	$holidays[$i]['datetime'] = new DateTimeImmutable($holidays[$i]['date']);
}

//The printCell function expects an Item Array, described below in the comments,
// and prints its content inside a <th></th> tag, applying anchor tags and CSS styles
// as indicated
function printCell( $itemArray, $itemDate, $activationDate ){

	//echo implode( "|", $itemArray);

	$styles = getStyles( $itemArray );
	
	if( empty($styles) ){
		echo "\t<th>";
	} else {
		echo "\t<th class=\"$styles[0]";
		for( $i = 1; $i<count($styles); $i++ ){
			echo ", $styles[$i]";
		}
		echo "\">\r\n";
	}

	for( $i = 0; $i < count($itemArray); $i++ ){
		if($i > 0 ){
			echo "<br>\r\n";
		}
		if( $itemArray[$i]['link'] == "" or $itemDate > $activationDate){
			echo $itemArray[$i]['text'];
		} else {
			echo "<a href=\"{$itemArray[$i]['link']}\">{$itemArray[$i]['text']}</a>";
		}
	}

	echo "</th>\r\n";
	
}

//The style of each line 
function getStyles( $item ){

	$styles = array();

	foreach( $item as $i ){
		if( $i['class'] != "" )
			$styles[] = $i['class'];
	}

	return $styles;
}


//Takes two DateTimeImmutable objects and returns whether they
//refer to any time on the same day
function isSameDay( $x, $y ){

	if( $x->format('Y-m-d') == $y->format('Y-m-d') ){
		return true;
	}
	return false;
	
}

//Takes a DateTimeImmutable object and the holidays list and returns
//which specific holiday the DateTimeImmutable is, or NULL otherwise
function whichHoliday( $date, $holidays ){

	for( $i = 0; $i < count($holidays); $i++ ){
		if( isSameDay( $date, $holidays[$i]['datetime'] ) ){
			return $i;
		}
	}

	return NULL;
}


?>

<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1"><title>CSCI 3500 - Operating Systems</title></head>

<body><h2 style="text-align: center;"><img alt="SLU logo" src="https://cs.slu.edu/~dferry/SLU_logo_horz.png" style="height:5em"><br></h2><h2 style="text-align: center;"><?php echo $CourseNum . ": " . $CourseName; ?> - Class Page<br>

</h2><h2 style="text-align: center;"><?php echo $Semester ?></h2>

<table style="width: 100%; text-align: left;" border="0" cellpadding="2" cellspacing="2"> <tbody> <tr>
    <td style="vertical-align: top; font-weight: bold; width: 163px;">Instructor</td> 
    <td style="vertical-align: top; width: 1019px;"><span style="font-family: monospace;"><a href="mailto:david.ferry@slu.edu">David Ferry</a>,  <a href="http://cs.slu.edu/~dferry/">Homepage</a></span></td> 
</tr>

<tr>
    <td style="vertical-align: top; font-weight: bold; width: 163px;">Course Web Site</td> 
    <td style="vertical-align: top; width: 1019px;"><span style="font-family: monospace;"><?php echo $CourseWebsite; ?></span></td>
</tr>

<tr>
    <td style="vertical-align: top; font-weight: bold; width: 163px;">Course meeting times</td> 
    <td style="vertical-align: top; width: 1019px;"><?php echo $ClassTime ?></td> 
</tr> 

<tr>
    <td style="vertical-align: top; width: 163px;"><span style="font-weight: bold;">Midterm exam</span><br> </td> 
    <td style="vertical-align: top; width: 1019px;"><?php echo $MidtermTime ?><br> </td>
</tr> 

<tr>
    <td style="vertical-align: top; width: 163px;"><span style="font-weight: bold;">Final exam</span><br> </td> 
    <td style="vertical-align: top; width: 1019px;"><?php echo $FinalTime ?><br> </td>
</tr> 

<tr>
    <td style="vertical-align: top; font-weight: bold; width: 163px;">Office hours</td>
    <td style="vertical-align: top; width: 1019px;">See <a href="http://cs.slu.edu/~dferry/schedule.html">my schedule</a></td> 
</tr> 

<tr>
    <td style="vertical-align: top; font-weight: bold; width: 163px;">Contact</td>
    <td style="vertical-align: top; width: 1019px;">You may contact me in person during office hours or during class time, or you may email me at <a href="mailto:dferry@slu.edu">dferry@slu.edu</a>. I am also available to meet by appointment, see <a href="http://cs.slu.edu/~dferry/schedule.html">my schedule</a>.</td> 
</tr> 

<!--
<tr> 
    <td style="vertical-align: top; width: 163px;">
<span style="font-weight: bold;">TA</span><br> </td> 
    <td style="vertical-align: top; font-weight: bold; width: 1019px;"><span style="font-weight: normal;">Benny Hill (bah2 AT cse.wustl.edu)</span><br style="font-weight: normal;"><span style="font-weight: normal;">Office Hours: Tu, Th 2pm-3pm</span> </td> </tr> </tbody> 
-->
</table>

<!--
<hr style="width: 100%; height: 2px;">
<h1 style="text-align: center;"><a href="https://cs.slu.edu/~goldwasser/seats/seating.php">Daily Seat Tracking: cs.slu.edu/seats/</a></h1>
-->

<hr style="width: 100%; height: 2px;">

<font size=+2><strong>Contents</strong></font>
<ol>
  <li><a href="#Course Description">Course Description</a>
  <li><a href="#Prerequisites">Prerequisites</a>
  <li><a href="#Lecture">Lecture</a>
  <li><a href="#Studios">Studios</a>
  <li><a href="#Labs">Labs</a>
  <li><a href="#Schedule">Course Schedule</a>
  <li><a href="#gitinfo">SLU Git Repository</a>
  <li><a href="#Textbooks">Textbooks and Other Resources</a>
  <li><a href="#Grading">Grading</a>
  <li><a href="#Attendance Policy">Attendance</a>
  <li><a href="#Academic Integrity">Academic Integrity</a>
  <li><a href="#Title IX Statement">Title IX Statement</a>
  <li><a href="#Academic Support">Academic Support</a>
  <li><a href="#Disability Services">Disability Services</a>
  <li><a href="#Writing Center">Writing Center</a>
  <li><a href="#Basic Needs Security">Basic Needs Security</a>
</ol>

<hr style="width: 100%; height: 2px;"><p>
<h3><a name="Course Description">Course Description</a></h3>

<p>Operating systems are the bridge between computer hardware and the
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
ask students to apply and analyze OS mechanisms. 
Most class periods will be a mix of questions
and answers over lecture material, deep-dives into one or more of the lecture
topics or practical demonstrations.
Expect a lab assignment approximately every two weeks.</p> 

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
<li>Describe how operating systems facilitate and interact with system libraries and user space programs
<li>Describe the purpose and implementation of major operating system abstractions: processes, threads, virtual memory, and the network stack
<li>Identify the presence/absence of race conditions and resolve race conditions with locking
<li>Write simple concurrent and multi-threaded programs (e.g. with <code>fork()</code> and Pthreads)
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

<!--
<hr style="width: 100%; height: 2px;"><p>
<h3><a name="Lecture">Lecture and Synchronous Meetings</a></h3>

<p>Studies show that traditional lecture is not a great use of class time for
many students. We will implement the flipped classroom strategy, where
students consume the traditional lecture content outside of class on their own time
and then come prepared to explore topics further. Our synchronous meetings will always
have time for your questions on lecture topics, and we will often have deep-dive
practical excerises as well. The remainder of our synchronous meetings will be
time for you to work with a partner on studios and/or lab assignments.</p>

<p>Lectures are recorded and should be watched prior to attending class for the day.
Links to individual lectures will be avialable on the course schedule at least 48 hours
prior to the start of class.</p>

-->

<hr style="width: 100%; height: 2px;"><p>
<h3><a name="Studios">Studios</a></h3>

<p>Computer science is an eminently <i>practical</i> discipline, and
studios are daily assignments intended to complement and reinforce lectures
through practice.
Studios will be completed in a team of two students. Students from different
teams may discuss studios, but sharing of code or solutions is strictly
prohibited.</p>

<p><b>Studios will be submitted via the Git repository. Every student
should have a copy of their studio solutions in their own repository,
even if you work with a group.</b></p>

<p>Studios are due Friday of the week after they are assigned. 
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



<center><table class="schedule" style="border-collapse: collapse; border: 4px solid black;" style="width:100%">


<tr style="border-bottom: 4px solid black; background-color:<?php echo $SchedHeaderColor?>">
	<th style="width:10%">Date</th>
	<th style="width:10%">Day</th>
	<th>Topic</th>
	<th>Readings</th>
	<th>Studios</th>
	<th>Labs</th>
</tr>

<?php
$currDate = $StartDate; //Current meaning the current iteration of the for-loop
$schedule = $data['Schedule'];

$now	= new DateTime(date('Y-m-d'));
$activateInterval = new DateInterval("PT{$hours}H");
$activationDate = $now->add($activateInterval);

$bgColor = $SchedColor1;

for( $i = 0; $i < count($schedule); $i++ ){
	$a = $schedule[$i];

	if( $currDate->format('D') == "Fri" ){
		echo "<tr style=\"border-bottom: 4px solid black; background-color:$bgColor;\">\r\n";
		if( $bgColor == $SchedColor1 ){
			$bgColor = $SchedColor2;
		} else {
			$bgColor = $SchedColor1;
		}
	}
	else{
		echo "<tr style=\"border-bottom: 1.25px solid black; background-color:$bgColor;\">\r\n";
	}

	$isHoliday = whichHoliday( $currDate, $holidays );
	if( !is_null($isHoliday) ){
		
		$i--; //The day is incremented below, so we "redo" the for loop for the correct school day
		echo "\t<th>" . $currDate->format('M d') . "</th>\r\n"; //Print Month, Day
		echo "\t<th>" . $currDate->format('D') . "</th>\r\n";   //Print Day Of Week
		echo "\t<th class=\"holiday\" colspan=\"4\" >" . $holidays[$isHoliday]['text'] . "</th>\r\n";
	} else {

		echo "\t<th>" . $currDate->format('M d') . "</th>\r\n"; //Print Month, Day
		echo "\t<th>" . $currDate->format('D') . "</th>\r\n";   //Print Day Of Week
		printCell( $a["topics"], $currDate, $activationDate);
		printCell( $a["readings"], $currDate, $activationDate);
		printCell( $a["studios"], $currDate, $activationDate);
		printCell( $a["labs"], $currDate, $activationDate);
	}
	$currDate = $currDate->add(new DateInterval('P2D'));
	if($currDate->format('D') == "Sun"){
	        $currDate = $currDate->add(new DateInterval('P1D'));
	}
	echo "</tr>\r\n";
}
?>

<tr style="background-color:<?php echo $bgColor?>;">
	<th>Dec 14</th>
	<th>Wed</th>
	<th class="due" colspan="4">Final Exam</th> 
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

<p>Reccomended Course textbook: <i>Modern Operating Systems</i> by 
Tanenbaum and Bos. Either the 3rd or 4th Edition works fine.
A classic computing textbook on the fundamentals of
operating systems, with a bent towards Unix-like operating systems. This
book is not required for the course, rather it is a secondary source
of information that provides a more comprehensive and textbook-like presentation
of the material for students who prefer this. 
I will not be assigning homework from the book or taking
test questions from the book. Access to the book's companion website is
not required and will not be used during this course.</p>

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

<!--
<div style="outline: 4px dashed red; margin:auto; width:80%">
<h3>Grading Modifications Due to COVID-19 Course Changes</h3>

<p>The novel coronavirus has completely changed how the second half of this
course will be taught, and it has completely rearranged our personal lives
as well. I want to be as sensitive to this as possible, while also upholding
the original goals and objectives of the course. To that end, the following
grading policy provides a greater degree of flexibility. It is not
possible to do worse under the new grading policy relative to the old grading
policy, so the new policy will apply to all students. </p>

<p>However, if you feel you are unable to complete any coursework due to the
ongoing crisis please let me know as soon as possible and I may make additional
accomodations based on any additional factors you feel are relevant.</p>

<h3>Revised Grading Policy</h3>

<ol>
<li>Studio and lab deadlines are now flexible, but you MUST email me at least 24 hours
before the original deadline to request an extension and we MUST agree on
a reasonable future due date. Of course, exigent circumstances will continue to
be considered in all cases. 
<li>All studios are expected to be completed as before.
<li>Labs 4 and 5 are optional- if you complete one of these labs I will drop your
lowest lab grade, and if you complete both then I will drop the two lowest lab grades.
In other words, 50% of your final grade will be determined by your three highest
lab grades.
</ol>
</div>
-->

<p>There are three activities for which you will receive credit in this course: studios, labs, and exams. Studios are daily guided assignments primarily designed to familiarize students with course concepts and development tools (i.e. knowledge and comprehension tasks). Lab assignments will ask students to apply general course concepts and analyze OS design alternatives. A midterm and final exam will evaluate your technical understanding of course concepts.</p>

<p>Studios are graded on the following scale: complete, partial credit, or no credit. Studios will not be turned back with detailed comments. Labs and exams will be graded on a points scale and will be turned back with comments. My goal is to return lab assignments to you within nine days of the deadline, which is an additional 48 hours for late submissions plus one week for grading time. Similarly, my goal is to return exams to you within one week.</p>

<p>Extensions on labs and studios are generally not granted aside from major unexpected events. You have at least a week to complete and submit any studio in this course, and at least two weeks for any lab assignment- it is assumed that this is sufficient for you to work around things such as sporting events or academic conferences on your own time. Please note the automatic 48-hour late policy for lab assignments.</p>

<p>I am happy to work with you on rescheduling exams if you are away from campus for slu-sponsored travel, but you must notify me at least two weeks ahead of time (and note that the exam dates are provided as of the first day of class). <b>Make up exams outside of this policy will only be given for severe and documented reasons.</b></p>

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
<li>Copying small pieces of code from man pages, online references or other sources is generally acceptable, but to be safe you should check with me first. <b>Code from such sources must be cited</b> with a comment denoting the start and finish of the copied section. Knowing how to use online references effectively is an essential skill for modern software developers and I don't want to discourage you from using such sources for understanding APIs and how to call complex functions. It is often the case that there is an expected "right way" to accomplish a specific task such as creating a pThreads thread or binding a socket to an address- lookups of this nature are equivalent to using a textbook or language reference and are fine. Looking up "How do I write my own malloc()" or "How to build my own shell" on the other hand is cheating. If you are in doubt, ask first!</li>
<li>Copied code that is not cited will be considered plagiarism and will be treated as cheating. Citing your code protects you from this. However, copying large portions of code is still grounds for a reduction in grade, even if it is not cheating. Please check with the instructor if you are copying more than a line or two of code!  
</ul>

<hr>

<H2>
<a name="Attendance Policy">Attendance</a>
</H2>

<p>Successful students attend all or mostly all class sessions. This is true
in my experience <a href="https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0187078">and has been demonstrated in large scale studies</a> as well.
In that study, even students who attended nine out of ten class periods had
measurably lower class performance than those who attended all classes. However,
there is no attendance requirement for this class, and you do not need to
get permission when you do miss class. You are an adult and have
the freedom to manage your time in whatever way you feel is most useful.
Job interviews, conferences, tests in other courses, etc. are all reasonable
cases for being absent.</p> 

<p>Note that in-class assignments such as tests or quizes cannot be made
up outside of class without prior approval from the instructor. All such
activities will be listed course schedule with ample time to prepare
(i.e. there are no "pop quizes").</p>

<p>If you do miss class you should refer to the course schedule to see what was
missed and arrange to get course notes from another student. I am always happy
to answer questions but I do not repeat full class periods in office hours.</p> 

<?php include "../statements.html" ?>

</body>
</html>
