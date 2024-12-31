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
    <td style="vertical-align: top; width: 163px;"><span style="font-weight: bold;">Midterm exams</span><br> </td> 
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

		<p>No textbook is required for this course.</p>

<!--
                <p>Recommended course textbook: <i>MATLAB An Introduction with Applications</i> by
                Amos Gilat, Published by Wiley</p>

                <p><i>Note:</i> The textbook is recommended as a supplementary resource for those who wish but is not required. Any recent edition of the book is suitable.</p>

                <p><a href="http://bcs.wiley.com/he-bcs/Books?action=index&itemId=111929925X&bcsId=10760" target="new">(book's website - supplementary videos, example problems, and errata)</a><br/>
-->

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
	<th>Dec 11</th>
	<th>Wed<br>8:00AM</th>
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
                                <td>Attendance</td>
                                <td>10%</td>
                        </tr>
                        <tr>
                                <td>In-Class Participation</td>
                                <td>10%</td>
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
                                <td>10% each</td>
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

<hr style="width: 100%; height: 2px;" />
<h2>Attendance</h2>
<p>Successful students attend all or mostly all class sessions. This is true in my experience <a href="https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0187078">and has been demonstrated in large scale studies</a> as well. In that study, even students who attended nine out of ten class periods had measurably lower class performance than those who attended all classes. However, there is no attendance requirement for this class, and you do not need to get permission when you do miss class. You are an adult and have the freedom to manage your time in whatever way you feel is most useful. Job interviews, conferences, tests in other courses, etc. are all reasonable cases for being absent.</p>
<p>Attendance grade will be determined by taking roll call at the start of class. For credit, you must be in class and respond when your name is called. This will happen approximately 10 times over the course of the semester.</p>
<p>In-Class Participation grade will be determined by responses to online surveys or submissions of in-class work to Canvas. Such activities can only be submitted during class time. Once the submission window closes these activities can no longer be submitted and cannot be made up. Please make sure to participate and click "submit" on all such activities!</p>
<p>Note that in-class assignments such as group work, discussion groups, or attendance assignments cannot be made up outside of class without prior approval from the instructor. Major activities such as quizzes or tests will be listed on the course schedule with ample time to prepare (i.e. there are no "pop quizes").</p>
<p>If you do miss class you should refer to the course schedule to see what was missed and arrange to get course notes from another student. I am always happy to answer questions but I do not repeat full class periods in office hours.</p>
<hr style="width: 100%; height: 2px;" />
<h3>Generative Artificial Intelligence (ChatGPT, LLMs, etc.)</h3>
<p>Three really important points:</p>
<ul>
    <li>Use of generative AI chat systems (GenAI) is allowed subject to important restrictions below.&nbsp;</li>
    <li>Violation of those restrictions is considered cheating and will result in a zero for the assignment or a failing grade for the course.</li>
    <li>The following is the Generative AI policy for this course. Other instructors at the university will have their own policies for their own courses. You are expected to understand and follow course policies for each course individually. My policy below does not apply to any other course, and no other course policies override or modify the policy stated here. Just because Professor XYZ says you can do it, does not mean you can do it in this course.</li>
</ul>
<p>Recent surveys of student behavior suggest that 80% of computing students are using GenAI as a replacement for internet searches, to learn course concepts, or to help troubleshoot faulty code. These informational purposes are allowed and encouraged! GenAI has a wonderful ability to immediately provide you relevant and personalized information in a way that internet searches do not. Searching an error code on Google, for example, will return dozens of results about dozens of people all with their own individual problems, and then you have to sift through all that information to find the one answer that is meaningful to you. In that sense, GenAI can be thought of as a super search engine. As a student, this helps you learn things faster. That's good!</p>
<p>However, GenAI can also be used to cheat. You can ask GenAI to write your program for you, or copy-paste your program and ask it to fix your bugs. That's bad! You won't understand the problems, you won't understand the solutions, and if I ask you to explain your code you won't even be able to tell me how your code works. As a student, this is self-destructive and prevents you from learning.</p>
<p>In general, you are permitted to use GenAI to help yourself learn faster. You are forbidden using GenAI to do your work for you. This is not actually a complicated policy! At the risk of horribly anthropomorphizing technology, imagine GenAI is a human friend sitting next to you. You already understand what kinds of questions are acceptable and which are not. Asking your friend to explain a programming language feature is not cheating. Asking your friend what an error message means is not cheating. Asking your friend to write code for you is cheating. Giving your friend your code and asking them to fix the bugs is cheating. Asking to see your friend's solution and writing your own version is cheating. The fact that you may be asking a GenAI system instead of a human friend does not change whether those things are acceptable or cheating.&nbsp;</p>
<p>If it would be OK to ask a human friend, it's OK to ask ChatGPT. If it would be cheating to ask a human friend, then it's cheating to ask ChatGPT (or Google Gemini, or Github Copilot, etc.).&nbsp;</p>
<p>A few explicit rules:</p>
<ul>
    <li>You ARE NOT allowed to copy any code from GenAI into your work and submit it. Submitting any amount of generated code is cheating!</li>
    <li>A little more subtle- you ARE NOT allowed to copy code from your work into any GenAI system. Copying your code into a GenAI system is considered cheating!</li>
    <li>You ARE NOT allowed to ask GenAI to generate a solution for you and then use that solution as a template for writing your own solution.</li>
    <li>You ARE NOT allowed to use GenAI to generate solutions to any homework, quiz, or test questions for the course.</li>
    <li>You ARE ALLOWED to copy error messages (including automatically generated code snippets) into GenAI systems and ask for clarification.&nbsp;</li>
    <li>You ARE ALLOWED to ask GenAI any informational questions about programming, programming languages, course concepts, etc. You are allowed to use GenAI for brainstorming as well.&nbsp;</li>
</ul>
<p>If you have any questions or want any clarifications to this policy, then please ask me. If you find yourself in an uncertain situation, then please ask me and let me give you advice. This is a brave new world for all of us, and I'm not pretending that I have everything already figured out. I am very willing to be lenient with well-intentioned students who are upfront about how they're using the technology.</p>
<hr style="width: 100%; height: 2px;" />
<h1 class="page-title">Academic Integrity/Honesty</h1>
<p>Academic integrity is the commitment to and demonstration of honest and moral behavior in an academic setting. Since the mission of the University is "the pursuit of truth for the greater glory of God and for the service of humanity," acts of integrity are essential to its very reason for existence. Thus, the University regards academic integrity as a matter of serious importance. Academic integrity is the foundation of the academic assessment process, which in turn sustains the ability of the University to certify to the outside world the skills and attainments of its graduates. Adhering to the standards of academic integrity allows all members of the University to contribute to a just and equitable learning environment that cultivates moral character and self-respect. The full University-level Academic Integrity Policy can be found on the Provost's Office website at:<span>&nbsp;</span><a href="https://www.slu.edu/provost/policies/academic-and-course/academic-integrity-policy.pdf">https://www.slu.edu/provost/policies/academic-and-course/academic-integrity-policy.pdf</a>. &nbsp;</p>
<p>[last updated: May 2024]</p>
<hr style="width: 100%; height: 2px;" />
<h1 class="page-title">Disability Accommodations</h1>
<p><span>Students with a documented disability who wish to request academic accommodations must formally register their disability with the University. Once successfully registered, students also must notify their course instructor that they wish to use their approved accommodations in the course.</span></p>
<p><span>Please contact the Center for Accessibility and Disability Resources (CADR) to schedule an appointment to discuss accommodation requests and eligibility requirements. Most students on the St. Louis campus will contact CADR, located in the Student Success Center and available by email at&nbsp;<a href="mailto:accessibility_disability@slu.edu">accessibility_disability@slu.edu</a>&nbsp;or by phone at 314.977.3484. Once approved, information about a student&rsquo;s eligibility for academic accommodations will be shared with course instructors by email from CADR and within the instructor&rsquo;s official course roster. Students who do not have a documented disability but who think they may have one also are encouraged to contact to CADR. Confidentiality will be observed in all inquiries.</span></p>
<p><span><em>Note: due to accreditation requirements, regulatory differences, and/or location-specific resources, the School of Law, the School of Medicine, and SLU Madrid have their own standard language for syllabus statements related to disability accommodations. Faculty in those units should seek guidance for syllabus requirements from their dean&rsquo;s office.</em></span></p>
<p><span>[last updated: August 2023]</span></p>
<hr style="width: 100%; height: 2px;" />
<h1 class="page-title">Student Success Center</h1>
<p>The Student Success Center (SSC) supports students in reaching their goals in and out of the classroom. Providing a variety of resources, the Student Success Center houses both the Center for Accessibility and Disability Resources (CADR) and Academic Support, which includes Tutoring, Supplemental Instruction, University Writing Services, and Student Success Coaching. The Student Success Center is located in the Busch Student Center, Suite 331, and students can make an appointment with any SSC resource via EAB Navigate. To learn more about the Student Success Center and its resources, please visit:<a href="https://www.slu.edu/life-at-slu/student-success-center/index.php"><span>&nbsp;</span>https://www.slu.edu/life-at-slu/student-success-center/index.php</a>.</p>
<p>[last updated: August 2023]</p>
<hr style="width: 100%; height: 2px;" />
<h1 class="page-title">University Writing Services</h1>
<p>University Writing Services offers one-on-one consultations with trained writing consultants from different disciplines who help with everything from brainstorming, outlining, and proposing research questions to documenting sources, revising, and implementing feedback. These consultations can take place in-person, asynchronously, or via Zoom and can be scheduled through<span>&nbsp;</span><a class="external" href="https://slu.navigate.eab.com/app/#/authentication/remote/" target="_blank" rel="noopener"><span>EAB Navigate &ndash; Student</span><span class="external_link_icon" role="presentation"><span class="screenreader-only">Links to an external site.</span></span></a>. Getting feedback benefits writers at all skill levels on different writing projects (including but not limited to class assignments, conference papers, cover letters, dissertations, group projects, multimedia assignments, personal statements, senior capstone projects, short answer questions on applications, speeches, and theses). For additional information, visit<a href="https://www.slu.edu/life-at-slu/student-success-center/academic-support/university-writing-services/index.php"><span>&nbsp;</span>https://www.slu.edu/life-at-slu/student-success-center/academic-support/university-writing-services/index.php</a><span>&nbsp;</span>or send an email to<span>&nbsp;</span><a href="mailto:writing@slu.edu">writing@slu.edu</a>.</p>
<p>[last updated: August 2023]</p>
<hr style="width: 100%; height: 2px;" />
<h1 class="page-title">University Counseling Center</h1>
<p>The University Counseling Center (UCC) offers free, short-term, solution-focused counseling to Saint Louis University undergraduate and graduate students. UCC counselors are highly trained clinicians who can assist with a variety of issues, such as adjustment to college life, troubling changes in mood, and chronic psychological conditions. To make an appointment for a wellness consultation, call 314-977-8255 (TALK), or visit the clinic on the second floor of Wuller Hall. For after-hours needs, please press #9 after dialing the clinic number.</p>
<p><strong>&nbsp;</strong>[last updated: April 2024]</p>
<hr style="width: 100%; height: 2px;" />
<h1 class="page-title">Wellness</h1>
<p>With our Jesuit commitment to<span>&nbsp;</span><em>cura personalis</em>, the University sees your academic success as connected to your health and well-being and provides resources to support your holistic wellness.</p>
<p>All students experience stressors and challenges at some point, and seeking support is both normal and beneficial. Such challenges may be the result of academic concerns (such as those related to particular assignments or content in a course), or they may be more personal in nature (such as concerns related to relationships, mental health, medical issues, loss, identities, alcohol or drugs, housing or food security, finances, or local/world events, among other things). If you experience these or other difficulties that are impacting your well-being and/or academic work, please consider seeking support from the resources available to you.</p>
<ul>
    <li>For questions or concerns related to this course, please contact me. I am invested in your success and will support your success in the ways I can.&nbsp;</li>
    <li>Additionally, you have access to the many resources SLU provides in support of your personal wellness. You will find a list of available resources on<a href="https://www.slu.edu/wellbeing/index.php"><span>&nbsp;</span>the Well-being page of the SLU website</a>.&nbsp;</li>
</ul>
<p><strong>If you or someone you know is experiencing a crisis</strong>: please consult<span>&nbsp;</span><a href="https://www.slu.edu/life-at-slu/university-counseling/crisis-resources.php">Crisis Support and Warning Signs on the University Counseling Center website</a><span>&nbsp;</span><span>or call the University Counseling Center at 314-977-TALK (8255) and press #9 to be connected to a behavioral health nurse 24/7</span>.</p>
<p>[last updated: April 2024]</p>
<hr style="width: 100%; height: 2px;" />
<h1 class="page-title">Basic Needs Security</h1>
<p><span>Students in personal or academic distress and/or who may be specifically experiencing&nbsp;challenges such as&nbsp;securing food or housing, or having difficulty navigating campus resources,&nbsp;and who believe this may affect their performance in the course, are&nbsp;encouraged to contact the Dean of Students Office (<a href="mailto:deanofstudents@slu.edu">deanofstudents@slu.edu</a>&nbsp;or 314-977-9378) for support. Furthermore, please notify the instructor if you are comfortable in doing so, as this will enable them&nbsp;to assist you with finding the resources you may need.</span></p>
<p><span>[last updated: August 2023]</span></p>

