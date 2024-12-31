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

$timezoneString = $data['TimeZone'];
$PostTime = $data['PostTime'];
$timezone = new DateTimeZone( $timezoneString );

$StartDateString = $data['StartDate'];
$StartDate       = new DateTimeImmutable($StartDateString." ".$PostTime, $timezone);
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

//	echo "<p>" . $itemDate->format('Y-m-d H:i:s e') . " | " . $activationDate->format('Y-m-d H:i:s e') . " | " . (($itemDate > $activationDate) ? 'true' : 'false') . "</p>";
//	echo "<p>" . $itemDate->format('Y-m-d') . " | " . $activationDate->format('Y-m-d') ."</p>";

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

	<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1"><title><?php echo $CourseNum . " - " . $CourseName; ?></title></head>

<body><h2 style="text-align: center;"><img alt="SLU logo" src="https://cs.slu.edu/~dferry/SLU_logo_horz.png" style="height:5em"><br></h2><h2 style="text-align: center;"><?php echo $CourseNum . ": " . $CourseName; ?> <br>

</h2><h2 style="text-align: center;"><?php echo $Semester ?></h2>

<table style="width: 100%; text-align: left;" border="0" cellpadding="2" cellspacing="2"> <tbody> <tr>
    <td style="vertical-align: top; font-weight: bold; width: 163px;">Instructor</td> 
    <td style="vertical-align: top; width: 1019px;"><span style="font-family: monospace;"><a href="mailto:faress.hraib@slu.edu">Faress Hraib</a></span></td> 
</tr>

<tr>
<!--    <td style="vertical-align: top; font-weight: bold; width: 163px;">Course Web Site</td> 
    <td style="vertical-align: top; width: 1019px;"><span style="font-family: monospace;"><?php echo $CourseWebsite; ?></span></td>-->
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
    <td style="vertical-align: top; width: 1019px;">TBD, by Zoom appointment for now</td> 
</tr> 

<tr>
    <td style="vertical-align: top; font-weight: bold; width: 163px;">Contact</td>
    <td style="vertical-align: top; width: 1019px;">You may email me at <a href="mailto:faress.hraib@slu.edu">faress.hraib@slu.edu</a></td> 
</tr> 

<!--
<tr> 
    <td style="vertical-align: top; width: 163px;">
<span style="font-weight: bold;">TA</span><br> </td> 
    <td style="vertical-align: top; font-weight: bold; width: 1019px;"><span style="font-weight: normal;">Benny Hill (bah2 AT cse.wustl.edu)</span><br style="font-weight: normal;"><span style="font-weight: normal;">Office Hours: Tu, Th 2pm-3pm</span> </td> </tr> </tbody> 
-->
</table>

<!--<hr style="width: 100%; height: 2px;">
<h1 style="text-align: center;"><a href="https://cs.slu.edu/~goldwasser/seats/seating.php">Daily Seat Tracking: cs.slu.edu/seats/</a></h1>-->

<hr style="width: 100%; height: 2px;">

<font size=+2><strong>Contents</strong></font>
<ol>
                        <li><a href="#Course Description">Course Description</a></li>
                        <li><a href="#Prerequisites">Prerequisites</a></li>
                        <li><a href="#Assignments">Assignments</a></li>
                        <li><a href="#Schedule">Course Schedule</a></li>
                        <li><a href="#Textbooks">Textbooks and Other Resources</a></li>
                        <li><a href="#Grading">Grading</a></li>
                        <li><a href="#Links">Getting MATLAB and Resources</a></li>
                        <li><a href="#Attendance Policy">Attendance Policy</a></li>
                        <li><a href="#Academic Integrity">Academic Integrity</a></li>
                        <li><a href="#Title IX Statement">Title IX Statement</a></li>
                        <li><a href="#Academic Support">Academic Support</a></li>
                        <li><a href="#Disability Services">Disability Services</a></li>
                        <li><a href="#Writing Services">Writing Services</a></li>
                        <li><a href="#Basic Needs Support">Basic Needs Support</a></li>
</ol>

<hr style="width: 100%; height: 2px;"><p>
<h3><a name="Course Description">Course Description</a></h3>

                <p>Computing allows scientists and engineers to quantify
                and analyze problems to a terrific degree.
                The particulars of how
                computers are used will vary from field to field and problem
                to problem, but the <i>process</i> of computer programming (or
                more generally- computer-aided problem solving)
                is similar for everybody.
                Computers are machines
                that are incapable of original thought or imagination. Using one
                effectively requires a solid understanding of what a computer is
                and is not capable of, and then the mental plasticity to transform
                the real-world problem into a computer model that (hopefully)
                bears some significance to the original problem that must be solved.
                The goal of this course is to teach students this process of
                solving real-world scientific and engineering problems via
                computer programming.</p>

                <p>
                Learning Outcomes- At the end of this course, students should be able to:
                <ul>
                        <li>Solve word problems with a computer</li>
                        <li>Write a program to solve a parameterized problem (i.e. solve a class of word problems)</li>
                        <li>Simulate simple physical situations deterministically and stochastically</li>
                        <li>Use computer data to support the selection of a solution out of several competing alternatives</li>
                        <li>Use functions to divide a program into small, easy to read and maintain pieces of code</li>
                        <li>Use appropriate control structures (if-else statements, for loops, while loops, etc.) to achieve a desired result and structure code</li>
                </ul>
                </p>

                <p>
                Topical Outline- the topics we will cover in this course (not necessarily in this order)
                are:
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
                        <li> Deterministic simulation</li>
                        <li> Stochastic simulation</li>
                        <li> Analyzing datasets with programming</li>
                </ul>
                </p>


                <p>Catalog Description: <i>Elementary computer programming concepts with an emphasis on problem solving and applications to scientific and engineering applications. Topics include data acquisition and analysis, simulation and scientific visualization.</i></p>



<hr style="width: 100%; height: 2px;"><p>
<h3><a name="Prerequisites">Prerequisites</a></h3>

                <ul>
                        <li>Calculus I or concurrent enrollment in same</li>
                </ul>

<p>Please see the instructor if you're missing a prerequisite or uncertain
about your preparation for this course.</p>

               <hr style="width: 100%; height: 2px;"><p>
                <h3><a name="Textbooks">Textbook</a></h3>

                <p>Recommended course textbook: <i>MATLAB An Introduction with Applications</i> by
                Amos Gilat, Published by Wiley</p>

                <p><i>Note:</i> The textbook is recommended as a supplementary resource for those who wish but is not required. Any recent edition of the book is suitable.</p>

                <p><a href="http://bcs.wiley.com/he-bcs/Books?action=index&itemId=111929925X&bcsId=10760" target="new">(book's website - supplementary videos, example problems, and errata)</a><br/>

<hr style="width: 100%; height: 2px;"><p>
                <h3><a name="Assignments">Assignments</a></h3>

                <p>There will be approximately 10 assignments for this course and a course project. These are a mix of written and programming assignments whose purpose is to apply course concepts.</p>

                <p>Assignments submitted on time will be given full credit. Assignments submitted up to 24 hours late will be given a <b>ten percent penalty</b>. Assignments submitted between 24 hours and 48 hours late will be given a <b>twenty percent penalty</b>. Assignments submitted after 48 hours late will not be given credit, except in the case of extenuating circumstances pre-approved by the instructor.</p>


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
	<th>Class Code</th>
	<th>Readings</th>
	<th>Notes</th>
</tr>

<?php
$currDate = $StartDate; //Current meaning the current iteration of the for-loop
$schedule = $data['Schedule'];

$now = new DateTime( 'now', $timezone );
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
		printCell( $a["first"], $currDate, $activationDate);
		printCell( $a["second"], $currDate, $activationDate);
		printCell( $a["third"], $currDate, $activationDate);
		printCell( $a["fourth"], $currDate, $activationDate);
	}
	$currDate = $currDate->add(new DateInterval('P2D'));
	if($currDate->format('D') == "Sun"){
	        $currDate = $currDate->add(new DateInterval('P1D'));
	}
	echo "</tr>\r\n";
}
?>

<tr style="background-color:<?php echo $bgColor?>;">
	<th>May 11</th>
	<th>Wed<br>12:00PM</th>
	<th class="due" colspan="4">Project Presentations</th> 
</tr>

</table></center>



<hr style="width: 100%; height: 2px;"><p>
<h3><a name="Grading">Grading</a></h3>

                <p>Your grade will be determined as follows:</p>

                <table border="3">
                        <tr>
                                <th>Activity</th>
                                <th>Grade Percentage</th>
                        </tr>
                        <tr>
                                <td>Assignments</td>
                                <td>40%</td>
                        </tr>
                        <tr>
                                <td>Project</td>
                                <td>20%</td>
                        </tr>
                        <tr>
                                <td>Midterm Exams</td>
                                <td>20% each</td>
                        </tr>
                        <!--<tr>
           <td>Final</td>
           <td>20%</td>
           </tr>-->

                </table>
                <p>Grading is done on a straight scale (uncurved). The following
                scores are guaranteed. The grading scale may be curved upwards (in your favor)
                at the discretion of the instructor.

                <ul>
                        <li> 93% guarantees an A</li>
                        <li> 90% guarantees an A-</li>
                        <li> 87% guarantees a B+</li>
                        <li> 83% guarantees a B</li>
                        <li> 80% guarantees a B-</li>
                        <li> 77% guarantees a C+</li>
                        <li> 73% guarantees a C</li>
                        <li> 70% guarantees a C-</li>
                        <li> 60% guarantees a D</li>
                </ul>

                </p>



                <hr style="width: 100%; height: 2px;"><p>
                <h3><a name="Links">Links / Resources</a></h3>

                <h4>MATLAB</h4>

                <p>The majority of this course is centered around using MATLAB, a widely used
                software for scientific and engineering computing. You can access
                this software in at least the following ways:</p>

                <ul>
                        <li><p>You can install MATLAB on your personal machine and use it via SLU's license via the
                                instructions <a href="https://www.slu.edu/its/downloads-and-discounts/index.php">here</a>.
                                You will need to scroll down the page to the entry for "MATLAB". Then click through
                                the link there and you will be taken to a Google Doc with instructions for downloading and installing MATLAB.
                                You will need to use your SLU username and ID to login to this Google Doc. </li>

                        <li><p>Online Access: Mathworks supports a browser-based version of MATLAB at
                                <a href="http://matlab.mathworks.com">matlab.mathworks.com</a>. This version of MATLAB will work
                                for this course, but the interface is somewhat different and I am less familiar with how it works.
                                I would suggest installing the local version of MATLAB if you are able, but I have had students
                                do the entire course with this version of MATLAB without difficulty.</li>


                        <li><p>Computer labs: The computers in McDonnell Douglas Hall should all have access to MATLAB. </li>
                </ul>

                <h4>Great reads that deal with computing in an engineering context:</h4>
                <ul>
                        <li><i>Skunk Works: A Personal Memoir of My Years at Lockheed</i> by Ben Rich - Discusses (among other things) how computers helped the F117 stealth fighter achieve a stealthy radar cross section the size of a 3mm ball bearing.</li>
                        <p>
                        <li><i>Failure Is Not an Option: Misson Control From Mercury to Apollo 13 and Beyond</i> by Gene Kranz - Discusses (among other things) the evolution of the computer command and control technology from the early Redstone rocket program through the Apollo program. Includes a great discussion of the infamous 1201 and 1202 program alarms that ocurred in the Apollo Guidance Computer during the Apollo 11 lunar descent phase.</li>
                        <p>
                        <li><i><a href="http://research.microsoft.com/en-us/um/people/mbj/Mars_Pathfinder/Mars_Pathfinder.html">What Really Happened on Mars?</a></i> by Mike Jones and a follow up <a href="http://research.microsoft.com/en-us/um/people/mbj/mars_pathfinder/Authoritative_Account.html">first person account</a> by Mars Pathfinder software team lead Glenn Reeves of NASA's Jet Propulsion Laboratory. Both discuss the cause and resolution of a computer failure that threatened the wildly successful Mars Pathfinder mission. Relatively technical.</li>
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

<p><b>2021-2022 Mandatory Syllabus Statement on In-Person Class Attendance and Participation</b></p>

<p>The health and well-being of SLU’s students, staff, and faculty are critical concerns, as is the quality of our learning environments.  Accordingly, the following University policy statements on in-person class attendance are designed to preserve and advance the collective health and well-being of our institutional constituencies and to create the conditions in which all students have the opportunity to learn and successfully complete their courses.</p>

 <OL>
<LI>Students who exhibit any <a href="https://www.cdc.gov/coronavirus/2019-ncov/symptoms-testing/symptoms.html">potential COVID symptoms</a> (those that cannot be attributed to some other medical condition the students are known to have, such as allergies, asthma, etc.) shall absent themselves from any in-person class attendance or in-person participation in any class-related activity until they have been evaluated by a qualified medical official.   Students should contact the <a href="https://www.slu.edu/life-at-slu/student-health/index.php">University Student Health Center</a> for immediate assistance.</LI>
<LI>
Students (whether exhibiting any of potential COVID-19 symptoms or not, and regardless of how they feel) who are under either an isolation or quarantine directive issued by a qualified health official must absent themselves from all in-person course activities per the stipulations of the isolation or quarantine directive.  
</LI>
<LI>
Students are responsible for notifying their instructor of an absence as far in advance as possible; when advance notification is not possible, students are responsible for notifying each instructor as soon after the absence as possible. Consistent with the <a href="https://catalog.slu.edu/academic-policies/academic-policies-procedures/attendance/">University Attendance Policy</a>, students also are responsible for all material covered in class and must work with the instructor to complete any required work. In situations where students must be absent for an extended period of time due to COVID-19 isolation or quarantine, they also must work with the instructor to determine the best way to maintain progress in the course as they are able based on their health situation. 
</LI>
<LI>
Consistent with the <a href="https://catalog.slu.edu/academic-policies/academic-policies-procedures/attendance/">University Attendance Policy</a>, students may be asked to provide medical documentation when a medical condition impacts a student’s ability to attend and/or participate in class for an extended period of time. 
</LI>
<LI>As a temporary amendment to the current <a href="https://catalog.slu.edu/academic-policies/academic-policies-procedures/attendance/">University Attendance Policy</a>, all absences due to illness or an isolation/quarantine directive issued by a qualified health official shall be considered “Authorized” absences. </LI>
</OL>


<hr>
<H2>
<a name="COVID">COVID-19 Considerations for Spring 2022</a>
</H2>

<p>
<b>Notification of absences:</b> You do not need to notify the instructor
that you are missing a regular class meeting. Notify the
instructor as early as possible if you have a conflict with exam times.
</p>

<p>
<b>Student Absences:</b> It is the responsibility of the student
to accommodate their absence. Make arrangements in advance with another
student to get a report of synchronous class activities and their notes 
for the day.</p> 

<p><b>Late work:</b> Severe illness is a reasonable basis to request an extension
on lab assignments. However, my experience is that extensions tend to do more harm
than good for many as once you get behind on work it can be difficult to catch up.
All students would be well-served by starting assignments early especially with the
uncertainty due to COVID-19.</p>

<p><b>Grading policy changes:</b> If circumstances require it, certain graded elements
of the course may be eliminated or replaced with a substitute. In the case of
substitution the new assignment will have the same point-values as the old assignment:
for example if the midterm exam is replaced with a programming project that programming
project will be worth 15% of your final grade. In the case of elimination the
point-values assigned to the activity group will not change: for example if we eliminate
one of the five lab assignments then the remaining four will collectively still be worth
50% of the final grade.</p>

<hr>
<H2>
<a name="masks">Mandatory Syllabus Statement on Face Masks (2021-2022)</a>
</H2>

<p>Throughout the COVID-19 pandemic, key safeguards like face masks have allowed SLU to safely maintain in-person learning. If public health conditions and local, state, and federal restrictions demand it, the University may require that all members of our campus community wear face masks indoors.</p>

<p><b>Therefore, any time a University-level face mask requirement is in effect, face masks will be required in this class.</b> This expectation will apply to all students and instructors, unless a medical condition warrants an exemption from the face mask requirement (see below). </p>

<p><b>When a University-wide face mask requirement is in effect,</b>the following will apply:</p>

<UL>
<LI>Students who attempt to enter a classroom without wearing masks will be asked by the instructor to put on their masks prior to entry. Students who remove their masks during a class session will be asked by the instructor to resume wearing their masks.</LI>
<LI>Students and instructors may remove their masks briefly to take a sip of water but should replace masks immediately. The consumption of food will not be permitted.</LI>
<LI></LI>

<LI>Students who do not comply with a request by a SLU instructor to wear a mask in accordance with the University’s Interim Policy on Face Masks may be subject to disciplinary actions per the rules, regulations, and policies of Saint Louis University, including but not limited to those outlined in the <i>Student Handbook</i>.  Non-compliance with this policy may result in disciplinary action, up to and including any of the following:</LI>

<UL>
<LI>dismissal from the course(s)</LI>
<LI>removal from campus housing (if applicable)</LI>
<LI>dismissal from the University</LI>
</UL>

<LI>To immediately protect the health and well-being of all students, instructors, and staff, instructors reserve the right to cancel or terminate any class session at which any student fails to comply with faculty or staff request to wear a mask in accordance with University policy.</LI>
</UL>

<p><b>When a University-wide face mask requirement is not in effect,</b> students and instructors may choose to wear a face mask or not, as they prefer for their own individual comfort level.</p>

<p><b>ADA Accommodations for Face Mask Requirements</b><br>
Saint Louis University is committed to maintaining an inclusive and accessible environment. Individuals who are unable to wear a face mask due to medical reasons should contact the Office of Disability Services (students) or Human Resources (instructors) to initiate the accommodation process identified in the University’s <a href="https://www.slu.edu/human-resources/pdfs/policies/americans-disabilities-act-policy.pdf">ADA Policy</a>. Inquiries or concerns may also be directed to the <a href="https://www.slu.edu/general-counsel/institutional-equity-diversity/index.php">Office of Institutional Equity and Diversity</a>. Notification to instructors of SLU-approved ADA accommodations should be made in writing prior to the first class session in any term (or as soon thereafter as possible).</p>

<hr>
<H2>
<a name="Academic Integrity">Academic Integrity</a>
</H2>

<P>
<em>Academic integrity is honest, truthful and responsible
conduct in all academic endeavors.</em>
The mission of Saint Louis University is "the pursuit of truth for the
greater glory of God and for the service of humanity."
Accordingly, all acts of falsehood demean and compromise the
corporate endeavors of teaching, research, health care, and
community service via which SLU embodies its mission. The
University strives to prepare students for lives of personal and
professional integrity, and therefore regards all breaches of
academic integrity as matters of serious concern.
</p>
<p>
The governing
University-level Academic Integrity Policy was adopted in Spring
2015, and can be accessed on the Provost's Office website at: <a
href="https://www.slu.edu/provost/policies/academic-and-course/policy_academic-integrity_6-26-2015.pdf">https://www.slu.edu/provost/policies/academic-and-course/policy_academic-integrity_6-26-2015.pdf</a>.
</p>
<p>
Additionally, each SLU College, School, and Center has adopted its own
academic integrity policies, available on their respective
websites. All SLU students are expected to know and abide by
these policies, which detail definitions of violations,
processes for reporting violations, sanctions, and
appeals. Please direct questions about any facet of academic
integrity to your faculty, the chair of the department of your
academic program, or the Dean/Director of the College, School or
Center in which your program is housed. Specific College of Arts
and Sciences Academic Honesty Policies and Procedures may be
<a href="http://www.slu.edu/arts-and-sciences/student-resources/academic-honesty.php">
found here</a>.
</p>


<hr>
<H2>
<A name="Title IX Statement">Title IX Statement</A>
</H2>

<p>
Saint Louis University and its faculty are committed to supporting our students and seeking an environment that is free of bias, discrimination, and harassment. If you have encountered any form of sexual harassment, including sexual assault, stalking, domestic or dating violence, we encourage you to report this to the University. If you speak with a faculty member about an incident that involves a Title IX matter, <b>that faculty member must notify SLU’s Title IX Coordinator and share the basic facts of your experience</b>. This is true even if you ask the faculty member not to disclose the incident. The Title IX Coordinator will then be available to assist you in understanding all of your options and in connecting you with all possible resources on and off campus.
</p>

<p>
Anna Kratky is the Title IX Coordinator at Saint Louis University (DuBourg Hall, room 36; <a href="mailto:anna.kratky@slu.edu">anna.kratky@slu.edu</a>; 314-977-3886). If you wish to speak with a confidential source, you may contact the counselors at the University Counseling Center at 314-977-TALK or make an anonymous report through SLU’s Integrity Hotline by calling 1-877-525-5669 or online at <a href="http://www.lighthouse-services.com/slu">http://www.lighthouse-services.com/slu</a>. To view SLU’s policies, and for resources, please visit the following web addresses: <a href="https://www.slu.edu/about/safety/sexual-assault-resources/index.php">https://www.slu.edu/about/safety/sexual-assault-resources/index.php</a> and <a href="https://www.slu.edu/general-counsel">https://www.slu.edu/general-counsel</a>.
</p>

<p>
IMPORTANT UPDATE: SLU’s Title IX Policy (formerly called the Sexual Misconduct Policy) has been significantly revised to adhere to a new federal law governing Title IX that was released on May 6, 2020. Please take a moment to review the new policy and information on the following web address: <a href="https://www.slu.edu/about/safety/sexual-assault-resources/index.php">https://www.slu.edu/about/safety/sexual-assault-resources/index.php</a>. Please contact the Anna Kratky, the Title IX Coordinator, with any questions or concerns.
</p>


<hr>

<H2>
<A name="Academic Support">Supporting Student Success</A>
</H2>

<p>
In recognition that people learn in a variety of ways and that
learning is influenced by multiple factors (e.g., prior
experience, study skills, learning disability), resources to
support student success are available on campus. The Student
Success Center, a one-stop shop, which assists students with
academic and career related services, is located in the Busch
Student Center (Suite&nbsp;331). Students can visit <a
href="https://www.slu.edu/life-at-slu/student-success-center/">https://www.slu.edu/life-at-slu/student-success-center/</a> to learn more about tutoring services,
university writing services, disability services, and academic coaching.
<hr>

<H2>
<A name="Disability Services">Disability Services</A>
</H2>
<p>
Students with a documented disability who wish to request
academic accommodations <b>must</b> contact Disability Services to
discuss accommodation requests and eligibility
requirements. Once successfully registered, the student also
<b>must</b>  notify the course instructor that they wish to access
accommodations in the course.
</p>
<p>
Please contact Disability Services, located within the Student
Success Center, at <a href="mailto:Disability_services@slu.edu">Disability_services@slu.edu</a> or 314-977-3484
to schedule an appointment. Confidentiality will be observed
in all inquiries. Once approved, information about academic
accommodations will be shared with course instructors via email
from Disability Services and viewed within Banner via the
instructor’s course roster.
</p>
<p>
Note: Students who do not have a documented disability but who
think they may have one are encouraged to contact Disability Services.
</p>

<hr>
<H2>
<A name="Writing Center">University Writing Services</A>
</H2>
<p>Students are encouraged to take advantage of University Writing Services in the Student Success Center; getting feedback benefits writers at all skill levels. Trained writing consultants can help with writing projects, multimedia projects, and oral presentations. University Writing Services offers one-on-one consultations that address everything from brainstorming and developing ideas to crafting strong sentences and documenting sources. For more information, visit <a href="https://www.slu.edu/life-at-slu/student-success-center/">https://www.slu.edu/life-at-slu/student-success-center/</a> or call the Student Success Center at 314-977-3484.</p>

<hr>
<H2>
<A name="Basic Needs Security">Basic Needs Security</A>
</H2>
<p>Students in personal or academic distress and/or who may be specifically experiencing challenges such as securing food or difficulty navigating campus resources, and who believe this may affect their performance in the course, are encouraged to contact the Dean of Students Office (<a href="mailto:deanofstudents@slu.edu">deanofstudents@slu.edu</a> or 314-977-9378) for support. Furthermore, please notify the instructor if you are comfortable in doing so, as this will enable them to assist you with finding the resources you may need.</p>



</body>
</html>

