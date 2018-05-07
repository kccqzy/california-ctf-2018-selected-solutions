<?php
	if (isset($_SESSION['LAST_ACTIVITY']) && (time() - $_SESSION['LAST_ACTIVITY'] > 1800)) {
    	// last request was more than 30 minutes ago
    	session_unset();     // unset $_SESSION variable for the run-time 
    	session_destroy();   // destroy session data in storage
	}
	$_SESSION['LAST_ACTIVITY'] = time(); // update last activity time stamp

	session_start();

	
	if ($_SERVER['REQUEST_METHOD'] !== 'POST')
	{	
		header("Location: index.php");
		die();
	}
	if((strpos(strtolower($_POST["username"]), "drop") !== false) || (strpos(strtolower($_POST["password"]), "drop") !== false) || (strpos(strtolower($_POST["username"]), "delete") !== false) ||(strpos(strtolower($_POST["password"]), "delete") !== false)|| (strpos(strtolower($_POST["username"]), "alter") !== false) ||(strpos(strtolower($_POST["password"]), "alter") !== false)){
		header("Location: index.php");
		die();
	}
		

		$servername = "mssi_db";
		$username = "root";
		$password = "horse_switch_monopoly_box";
		$dbname = "myDatabase";

		// Create connection
		$conn = new mysqli($servername, $username, $password, $dbname);

		// Check connection
		if ($conn->connect_error) {
		    die("Connection failed: " . $conn->connect_error);
		} 

		$logusername = $_POST["username"];
		$logpassword = $_POST["password"];


	 //    $logusername = mysqli_real_escape_string($conn, $_POST["username"]);
		// $logpassword = mysqli_real_escape_string($conn, $_POST["password"]);

		$result = mysqli_query($conn, "SELECT * FROM users WHERE username='$logusername' AND password='$logpassword'");
		//SQL Injection: What if we type ' UNION SELECT * FROM users WHERE username='admin for the password




		$numrows=0;
	if($result)
	{
		$numrows = mysqli_num_rows($result);
	}


	if($numrows == 1)
	{

		$arr = mysqli_fetch_array($result);

		$_SESSION["username"] = $arr['username'];
		header("Location: search.php");
	}
	else
	{
		header("Location: index.php");
		die();
	}

	$conn->close();

?>
<!DOCTYPE html>
<html>
<head>
<title></title>
</head>
<body>

</body>
</html>
