<?php
 if(preg_match("/^[  a-zA-Z]+/", $_REQUEST['name'])){
 $name=$_REQUEST['name'];
  //connect  to the database
 $db=mysql_connect  ("Name", "User",  "Password*") or die ('I cannot connect to the      database  because: ' . mysql_error());
 //-select  the database to use
 $mydb=mysql_select_db("Table Name");
  //-query  the database table
  $sql="SELECT  ID, CourseName, ExamBoard FROM subjects WHERE CourseName LIKE '%" . $name .  "%' ";
   //-run  the query against the mysql query function
   $result=mysql_query($sql);
    //-create  while loop and loop through result set
    while($row=mysql_fetch_array($result)){
      $CourseName  =$row['CourseName'];
      $ID=$row['ID'];
      $ExamBoard=$row['ExamBoard'];
  //-display the result of the array
  echo "<ul>\n";
  echo "<li>" . "<a  href=\"search.php?id=$ID\">"   .$CourseName . " " .  "</a></li>\n" ;
  echo  $ExamBoard . " " .  "</a>\n";
  echo "</ul>";
}
?>
