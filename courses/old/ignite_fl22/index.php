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
  <li><a href="#COVID">COVID-19 Considerations for Fall 2021</a>
  <li><a href="#masks">Fall 2021 Mask Policy</a>
  <li><a href="#Academic Integrity">Academic Integrity</a>
  <li><a href="#Title IX Statement">Title IX Statement</a>
  <li><a href="#Academic Support">Academic Support</a>
  <li><a href="#Disability Services">Disability Services</a>
  <li><a href="#Writing Center">Writing Center</a>
  <li><a href="#Basic Needs Security">Basic Needs Security</a>
</ol>

<hr style="width: 100%; height: 2px;"><p>
<h3><a name="Course Description">Course Description</a></h3>

<p>
Since the dawn of modern computing, thinkers have asked what the limits of
mechanical processes really are. What is it that truly separates the 
intellectual domain of the human mind from problems that can be solved
by an algorithm? Computers are inherently machines that carry out 
instructions mindlessly and repeatedly, so surely there must be some difference
between what that mechanical process can achieve and the boundless creativity
of the human mind. And yet, the mechanical thinking machines have
slowly but steadily expanded what they can do, and
simultaneously encroach on what we once considered to be uniquely
human. Where does this process stop- will there be something left that
separates man from the machines? 
</p>

<p><i>"Two possibilities exist: either we are alone in the Universe or we are not. Both are equally terrifying."</i></p>
<p>- Arthur C. Clarke</p>

<p><b>Course "Big Questions"</b></p>

<ul>
<li>What does it mean for a problem to be solvable by a computer?</li>
<li>Are there problems that humans can solve, but computers can't solve?</li>
<li>Are there problems that computers can solve, that humans can't solve?</li>
<li>What does it mean to be conscious?</li>
<li>What does it mean to be human?</li>
<li>Could computers ever fulfill what it means to be human? If not, what differentiates humans from machines?</li>
</ul>

<p>
The major elements of this course are class meetings, readings, reflections, programming assignments, a course
programming project, and a research project.
Lectures are our time together for instruction on programming concepts and discussion of class readings.
Out of class readings allow you to access concepts beyond what we have time for during class, and also
give you time to digest and reflect on ideas before class discussion.
Reflections are out of class activities along with written journal entries that allow us to experience
class concepts in the real world.
Programming assignments are computer programs I ask you to write to learn programming concepts
and demonstrate mastery. The course programming project is a semester-long project where you will implement
a "chat bot"- a program that attempts to converse with a user as though it is human. The research report
asks you to examine one of our main course questions from a domain of your choosing.
</p>

<p>
Programming Topics Outline:
<ul>
                        <li> What is a program, what is an algorithm</li>
                        <li> Variables: declaring, initializing, using, and modifying</li>
                        <li> Vector/array data: declaring, initializing, using, and modifying</li>
                        <li> Plotting and visualizing data</li>
                        <li> Control structures (if-then/else, for loops, while loops, switch statements)</li>
                        <li> Functions</li>
                        <li> Structuring code effectively</li>
                        <li> Reading/writing data to files</li>
                        <li> Text data and string handling</li>
</ul>
</p>

<p>
Course Concepts Outline:
<ul>
  <li>Algorithms and machines</li>
  <li>Turing tests</li>
  <li>Natural language processing</li>
  <li>Philosophical and religious roots of meaning</li>
  <li>Automation and mechanization</li>
  <li>Human-computer iteraction and designing for the human</li>
  <li>Information theory and data compression</li>
  <li>Computability and complexity theory</li>
  <li>Consciousness</li>
  <li>Free will and determinism</li>
</ul>
</p>

<hr style="width: 100%; height: 2px;"><p>
<h3>Ignatian Pedagogical Paradigm</h3>

<p>Known as "Ignatian" because it is rooted in the Spiritual Exercises of St. Ignatius of Loyola, the founder of the Society of Jesus (the Jesuits), the five elements together comprised (and continue to comprise) the essential components of Jesuits' meditative practices and became integrated with the Jesuits' approach to education in the schools they established around the world.</p>

<p><img src="ignatian.png" width="50%"/></p>

<p>Our goal in this course is not to master material or learn skills, but
rather to cultivate informed, well-rounded opinions on a difficult subject
that has no definite answers. We also seek to develop in each student their
own personal approach to inquiry- you will find that some arguments are
meaningful and persuasive, while others are not, and that is a good thing
to understand about yourself. I will also ask that you have the patience
to understand those arguments you do not find persuasive, and
understand why others do find them persuasive.</p>

<p>The cyclic structure above hints at, we will attempt to engage our
course topic multiple times and in multiple ways. We will intersperse our
reading, discussions, and programming with activities and reflections that
ask us to continually evaluate and re-evaluate the opinions we are forming.</p>

<hr style="width: 100%; height: 2px;"><p>
<h3>Course Activities</h3>

<p><b>Readings-</b> We will do readings out of our course text as well as from
other sources. These are to be completed by class on the day they are listed on the schedule, as they may form the basis for the activities in class that day.</p>

<p><b>Class Discussion-</b> A substantial component of our course will be
wrestling with readings and concepts together in community. Our courses'
Big Questions are inherently tied to the human experience, so more human
experiences are a broader base for understanding!</p>

<p><b>Reflections-</b> I will periodically ask you to produce short written
reflections on specific readings, concepts, or course Big Questions. These
are an opportunity for you to take stock of your own thoughts and feelings
and put these into words.</p>

<p><b>Programming Assignments-</b> A major experiential learning component of
this course is for each student to do substantial programming activities
themselves. A technical understanding of how computer programs are
constructed will help inform the student as to how machines do their
"thinking," or lack thereof.</p>

<p><b>Programming Project-</b> Our programming assignments all feed into a
substantial individual project- building a chat-bot that is designed to
interact with (and potentially fool) people into thinking that it is
a real person. Discussion of chat-bots and what they mean will be a major
element in this class.</p>

<p><b>Research Project-</b> A culminating presentation for the course will be
to research and present a unique take on humanity, the human/computer 
experience, or how humans interact with computers. This presentation asks 
you to approach one of our Big Questions from a perspective outside of
computer science and programming: biology, psychology, philosophy, religion,
etc. In lieu of a final exam you will present this perspective during the last week or two of class.</p>

<hr style="width: 100%; height: 2px;"><p>
<h3>University Core</h3>

<p>The Saint Louis University Core is an academic program intentionally structured to facilitate student achievement of both holistic and component-level student learning outcomes (SLOs). <a href="https://www.slu.edu/provost/policies/academic-and-course/policy_course-syllabus_12-12-18.pdf">SLU&rsquo;s Course Syllabus Policy</a> requires that learning outcomes appear on all syllabi. Below, you will find a table with the University Core and Core Component SLOs indicated. Please copy the boilerplate below and insert it into your syllabus.</p>

<p><strong>Ignite Seminar</strong></p>
<p>This course is part of the Saint Louis University Core, an integrated intellectual experience completed by all baccalaureate students, regardless of major, program, college, school or campus. The Core offers all SLU students the same unified approach to Jesuit education guided by SLU&rsquo;s institutional mission and identity and our nine undergraduate <a href="https://www.slu.edu/provost/university-undergraduate-core/core-student-learning-outcomes.php">Core Student Learning Outcomes</a> (SLOs).</p>

<table style="border: 1px solid;" width="696">
<tbody >
<tr>
<td style="background-color: lightgrey; border: 1px solid;"  width="696">
<p><strong>Ignite Seminar</strong> is one of 19 Core Components. The University Core SLO(s) that this component is designed to intentionally advance are listed below:</p>
</td>
</tr>
<tr>
<td style="background-color: lightblue" width="696">
<p><strong>University Core Student Learning Outcomes</strong></p>
<p>The Core SLO(s) that this component is intentionally designed to advance are:</p>
</td>
</tr>
<tr>
<td width="696">
<p>SLO 1: Examine their actions and vocations in dialogue with the Catholic, Jesuit tradition</p>
</td>
</tr>
<tr>
<td width="696">
<p>SLO 2: &nbsp;Integrate knowledge from multiple disciplines to address complex questions</p>
</td>
</tr>
<tr>
<td width="696">
<p>SLO 3: Assess evidence and draw reasoned conclusions</p>
</td>
</tr>
<tr>
<td width="696">
<p>SLO 5: Analyze how diverse identities influence their lives and the lives of others</p>
</td>
</tr>
</tbody>
</table>
<p>&nbsp;</p>
<table style="border: solid 1px;" width="696">
<tbody>
<tr>
<td style="background-color: lightgrey; border: solid 1px;" width="696">
<p>Additionally, the Core Component-level Student Learning Outcomes are listed below:</p>
</td>
</tr>
<tr>
<td style="background-color: lightblue;" width="696">
<p><strong>Component-level Student Learning Outcomes</strong></p>
<p>Students who complete this course will be able to:</p>
</td>
</tr>
<tr>
<td width="696">
<p>&middot; Recognize that both personal and social <strong>context</strong> shapes all learning.</p>
</td>
</tr>
<tr>
<td width="696">
<p>&middot; Characterize how the <strong>experience </strong>of learning through a distinct disciplinary or interdisciplinary mode of inquiry shapes knowledge of ourselves, our communities, and our world.</p>
</td>
</tr>
<tr>
<td width="696">
<p>&middot; <strong>Reflect </strong>on learning experiences to arrive at a deeper understanding of who they are as scholars and citizens.</p>
</td>
</tr>
<tr>
<td width="696">
<p>&middot; <strong>Evaluate</strong> the ways in which new knowledge illuminates routes towards future action, and identify possible actions one might take in the service of humanity.</p>
</td>
</tr>
<tr>
<td width="696">
<p>&middot; Identify, evaluate, and utilize a variety of SLU library source materials to complete a course assignment.</p>
</td>
</tr>
</tbody>
</table>

<hr style="width: 100%; height: 2px;"><p>
<p><i><b>Catalog Description:</b>What does it mean to be human, and how close can a computer get? This class explores the theory of what is and is not computable, as well as definitions for what it means to have conscious human thought, and how those two concepts relate. This course also serves as an introduction to computer programming and asks that the student experience and reflect on how people interact with computers to solve complex, modern problems as well as how computing is shaping the human experience.</i></p>

<hr style="width: 100%; height: 2px;"><p>
<h3><a name="Prerequisites">Prerequisites</a></h3>
<ul>
  <li>No prerequisites, no programming experience required.
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
	<th>Homeworks</th>
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
		echo "\t<th class=\"holiday\" colspan=\"3\" >" . $holidays[$isHoliday]['text'] . "</th>\r\n";
	} elseif ( !is_null($isFixedDay) )  { 
		$i--; //The day is incremented below, so we "redo" the for loop for the correct school day
		echo "\t<th>" . $currDate->format('M d') . "</th>\r\n"; //Print Month, Day
		echo "\t<th>" . $currDate->format('D') . "</th>\r\n";   //Print Day Of Week
		printCell( $fixedDays[$isFixedDay]["topics"], $currDate, $activationDate);
		printCell( $fixedDays[$isFixedDay]["readings"], $currDate, $activationDate);
		printCell( $fixedDays[$isFixedDay]["studios"], $currDate, $activationDate);
		//printCell( $fixedDays[$isFixedDay]["labs"], $currDate, $activationDate);
	} else {

		echo "\t<th>" . $currDate->format('M d') . "</th>\r\n"; //Print Month, Day
		echo "\t<th>" . $currDate->format('D') . "</th>\r\n";   //Print Day Of Week
		printCell( $a["topics"], $currDate, $activationDate);
		printCell( $a["readings"], $currDate, $activationDate);
		printCell( $a["studios"], $currDate, $activationDate);
		//printCell( $a["labs"], $currDate, $activationDate);
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

</table></center>

<hr style="width: 100%; height: 2px;"><p>
<h3><a name="gitinfo">SLU Git Repository</a></h3>

<p>All homeworks will be submitted via individual course
Git repositories that are housed at SLU. You will find your
repository already has a directory structure that provides a place
for all lab and studio assignments. Your work must be in the
appropriate location for the instructor to find it and count it
for credit.</p>

<p><a href="git-info.pdf">A short guide to using SLU's git resources</a></p>


<hr style="width: 100%; height: 2px;"><p>
<h3><a name="Textbooks">Textbook and Class Resources</a></h3>

<p>Required Course Book: <i>The Most Human Human</i> by 
Brian Christian.</p>


<hr style="width: 100%; height: 2px;"><p>

<h3>Grading Policy</h3>


<table border="3">
<tr>
	<th>Activity</th>
	<th>Grade Percentage</th>
</tr>
<tr>
	<td>Homeworks</td>
	<td>50%</td>
</tr>
<tr>
	<td>Reflections</td>
	<td>10%</td>
</tr>
<tr>
	<td>Programming Project</td>
	<td>20%</td>
</tr>
<tr>
	<td>Research Presentation</td>
	<td>20%</td>
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

<p>Most work assigned in this course, is
expected to be completed individually. 
The sharing of written work or significant
portions of code between students is strictly prohibited. </p>

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

<p>If you do miss class you should refer to the course schedule to see what was
missed and arrange to get course notes from another student. I am always happy
to answer questions but I do not repeat full class periods in office hours.</p> 

<?php include "../statements.html" ?>

</body>
</html>
