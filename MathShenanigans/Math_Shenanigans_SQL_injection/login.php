<?php
	if (isset($_SESSION['LAST_ACTIVITY']) && (time() - $_SESSION['LAST_ACTIVITY'] > 1800)) {
    	// last request was more than 30 minutes ago
    	session_unset();     // unset $_SESSION variable for the run-time 
    	session_destroy();   // destroy session data in storage
	}
	$_SESSION['LAST_ACTIVITY'] = time(); // update last activity time stamp

	session_start();

	if (isset($_SESSION['LAST_ACTIVITY']) && (time() - $_SESSION['LAST_ACTIVITY'] > 1800)) {
    	// last request was more than 30 minutes ago
    	session_unset();     // unset $_SESSION variable for the run-time 
    	session_destroy();   // destroy session data in storage
	}
	$_SESSION['LAST_ACTIVITY'] = time(); // update last activity time stamp

	if(session_status() == PHP_SESSION_ACTIVE){

		if(isset($_SESSION['username'])){
			header("Location: /search.php");
		}	
	}
?>
<html><head>
<title>Login</title>
</head>
<body>
<h1>Login</h1>


<form action="/process.php" method="post">
	Enter your username: <input name="username" type="text"> <br>
	Enter your password: <input name="password" type="password"> <br>
	<input name="login" type="submit">
	
</form>





</body></html>
