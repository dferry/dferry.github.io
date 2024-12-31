<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><head>

<style>
table.schedule td th {
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
$FinalDay    = $data['FinalDay'];
$FinalDayOfWeek = $data['FinalDayOfWeek'];

//These values control how the schedule generator works
$ClassType   = $data['ClassType'];
$SchedColor1 = $data['SchedColor1'];
$SchedColor2 = $data['SchedColor2'];
$SchedHeaderColor = $data['SchedHeaderColor'];

$StartDateString = $data['StartDate'];
$StartDate       = new DateTimeImmutable($StartDateString);
$hours	         = $data['LinkActivationHours'];

$holidays = $data['Holidays'];
$fixedDays = $data['FixedDays'];

for( $i = 0; $i < count($holidays); $i++ ){
	$holidays[$i]['datetime'] = new DateTimeImmutable($holidays[$i]['date']);
}
for( $i = 0; $i < count($fixedDays); $i++ ){
	$fixedDays[$i]['datetime'] = new DateTimeImmutable($fixedDays[$i]['date']);
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


?>

<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1"><title><?php echo $CourseNum . ": " . $CourseName; ?> - Class Page</title></head>

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
</ol>

<hr style="width: 100%; height: 2px;"><p>
<h3><a name="Course Description">Course Description</a></h3>

<p>
Modern software architects and engineers care every bit as much about
<i>where</i> and <i>how</i> software executes as they do about <i>what</i>
the software does. Modern systems are expected to be <i>performant</i>,
<i>scalable</i>, <i>efficient</i>, <i>maintainable</i>, <i>secure</i>, 
and more. These are
challenging problems, because they are less concerned with <i>what</i> the
system does, and much more concerned about <i>how</i> a system does it. 
</p>

<p>Most requirements for software systems are written as a set of of
<i>functional constraints</i> in the sense of a mathematical function. A
program is seen as a tool for transforming inputs into outputs, and the program 
is the function that accomplishes that transformation. However, the challenges
listed above are <i>non-functional constraints</i> and cannot be expressed in
such a manner. If they were, our life would be easier! We could simply write
the bit of code that ensures our system is scalable, and then we'd be done.
Instead, verifying that a system is scalable requires checking that the
entire system is scalable- which is not only a global qualification, but
an entirely non-obvious one at that.
</p>

<p><b>Course "Big Questions"</b></p>

<ul>
<li>What does a modern, medium-scale software system look like?</li>
<li>What tools does an engineer have at their disposal to manage <i>how</i>
and <i>where</i> code executes?</li>
<li>What is concurrency and concurrent programming, and how can it be used?</li>
<li>What is parallel programming, and how can it be used?</li>
<li>At the low technical level, how are medium-scale systems composed out of
collections of components?</li>
</ul>

<p>The five elements of this course are lectures, studios, quizzes, labs, 
and exams.
Studios are short assignments intended to be completed primarily within class 
time and to augment lecture topics. Quizzes will be given to assess reading
and mastery of out-of-class material assignments.
Labs are longer assignments that will ask students to apply and analyze
system mechanisms. Expect a lab assignment approximately every two weeks.</p>

<p>
Topical outline:
<ul>
  <li>Rust basics- mutability, data types, ownership, borrowing</li>
  <li>Component management and deployment</li>
  <li>Benchmarking</li>
  <li>Tracing, telemetry, and system health</li>
  <li>Service oriented architecture and distributed systems</li>
  <li>Sockets programming</li>
  <li>7-layer OSI networking model</li>
  <li>User programs, processes, threads, and processor sharing</li>
  <li>Parallel programming</li>
  <li>Race conditions, locks, mutual exclusion</li>
  <li>Deadlock</li>
</ul>
</p>

<hr style="width: 100%; height: 2px;"><p>
<h3>Course Activities</h3>

<p><b>Readings-</b> We will do readings out of course texts as well as from
other sources. These are to be completed by class on the day they are listed on the schedule, as they may form the basis for the activities in class that day.</p>

<p><b>Quizzes-</b> These are short, in-class assignments designed to test your
knowlege and comprehension of out-of-class readings.

<p><b>Studios-</b> Computer Science is an eminently <i>practical</i>
discipline, and studios are daily assignments intended to complement and
reinforce class material with daily practice.</p>

<p><b>Reflections-</b> I will periodically ask you to produce short written
reflections on specific readings, concepts, or course Big Questions. These
are an opportunity for you to take stock of your own thoughts and feelings
and put these into words.</p>

<p><b>Labs-</b> A major experiential learning component of
this course is for each student to do substantial programming activities
themselves. A technical understanding of how distributed medium-scale
systems are implemented will show students for themselves how such systems
really work at a technical level.</p>



<hr style="width: 100%; height: 2px;"><p>
<p><i><b>Catalog Description:</b>An exploration of computing systems with a strong emphasis on how systems interact with each other. Topics will include concurrent and parallel programming, network communication, and computer security. In addition to foundational knowledge, the course includes simulating, benchmarking, and testing such systems.</i></p>

<hr style="width: 100%; height: 2px;"><p>
<h3><a name="Prerequisites">Prerequisites</a></h3>
<ul>
  <li>(CSCI 2500 - Computer Organization and Systems, with a grade of C- or
higher) OR (ECE 2205, ECE 3217, and ECE 3225)</li>
  <li>A basic knowledge of Linux programming and the Linux command line</li>
</ul>

<p>Please see the instructor if you're uncertain
about your preparation for this course.</p>

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
	$isFixedDay = whichHoliday( $currDate, $fixedDays );
	if( !is_null($isHoliday) ){
		
		$i--; //The day is incremented below, so we "redo" the for loop for the correct school day
		echo "\t<th>" . $currDate->format('M d') . "</th>\r\n"; //Print Month, Day
		echo "\t<th>" . $currDate->format('D') . "</th>\r\n";   //Print Day Of Week
		echo "\t<th class=\"holiday\" colspan=\"4\" >" . $holidays[$isHoliday]['text'] . "</th>\r\n";
	} elseif ( !is_null($isFixedDay) )  { 
		$i--; //The day is incremented below, so we "redo" the for loop for the correct school day
		echo "\t<th>" . $currDate->format('M d') . "</th>\r\n"; //Print Month, Day
		echo "\t<th>" . $currDate->format('D') . "</th>\r\n";   //Print Day Of Week
		printCell( $fixedDays[$isFixedDay]["topics"], $currDate, $activationDate);
		printCell( $fixedDays[$isFixedDay]["readings"], $currDate, $activationDate);
		printCell( $fixedDays[$isFixedDay]["studios"], $currDate, $activationDate);
		printCell( $fixedDays[$isFixedDay]["labs"], $currDate, $activationDate);
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
	<th><?php echo $FinalDay ?></th>
	<th><?php echo $FinalDayOfWeek ?></th>
	<th class="due" colspan="4">Final Exam</th> 
</tr>
<!--
<tr style="background-color:<?php echo $bgColor?>;">
	<th>May 12</th>
	<th>Friday</th>
	<th class="due" colspan="4">Lab 4 Due</th>
</tr>
-->

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

<p>Preferred Course Book: <i><a href="https://rust-book.cs.brown.edu/">Improving
the Rust Book</a></i> by Will Crichton and Shriram Krishnamurthi, based on
<i>The Rust Programming Language</i> by Steve Klabnik and Carol Nichols, with
contributions from the Rust Community.</p>

<p>Alternative Course Book: <i><a href="https://doc.rust-lang.org/book/">The
Rust Programming Language</a></i> by Steve Klabnik and Carol Nichols, with
contributions from the Rust Community.</p>

<hr style="width: 100%; height: 2px;"><p>

<h3>Grading Policy</h3>


<table border="3">
<tr>
	<th>Activity</th>
	<th>Grade Percentage</th>
</tr>
<tr>
	<td>Attendance</td>
	<td>10%</td>
</tr>
<tr>
	<td>Labs</td>
	<td>40%</td>
</tr>
<tr>
	<td>Studios</td>
	<td>20%</td>
</tr>
<tr>
	<td>Quizzes</td>
	<td>10%</td>
</tr>
<tr>
	<td>Midterm and Final Exams</td>
	<td>10% each</td>
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

<p>Work assigned in this course, is expected to be completed individually. 
The sharing of written work or significant portions of code between students is strictly prohibited. </p>

<hr style="width: 100%; height: 2px;"><p>


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

<p>Attendance grade will be determined by taking roll call at the start of
class. For credit, you must be in class and respond when your name is called.
This will happen approximately 10 times over the course of the semester.</p>

<p>If you do miss class you should refer to the course schedule to see what was
missed and arrange to get course notes from another student. I am always happy
to answer questions but I do not repeat full class periods in office hours.</p> 

<?php include "../statements.html" ?>

</body>
</html>
