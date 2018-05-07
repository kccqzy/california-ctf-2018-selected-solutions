<?php 
	session_start();
	if (isset($_SESSION['LAST_ACTIVITY']) && (time() - $_SESSION['LAST_ACTIVITY'] > 1800)) {
    	// last request was more than 30 minutes ago
    	session_unset();     // unset $_SESSION variable for the run-time 
    	session_destroy();   // destroy session data in storage
	}
	$_SESSION['LAST_ACTIVITY'] = time(); // update last activity time stamp
	
	if(! isset($_SESSION['username'])){
		header("Location: login.php");
		die();
	}

	$servername = "mssi_db";
	$username = "root";
	$password = "horse_switch_monopoly_box";
	$dbname = "myDatabase";

	// Create connection
	$conn = new mysqli($servername, $username, $password, $dbname);

	$type = "none";
	if(isset($_GET['type'])){
		$type = $_GET['type'];
		if((strpos(strtolower($type), "drop") !== false) || (strpos(strtolower($type), "delete") !== false) || (strpos(strtolower($type), "alter") !== false)){
			header("Location: index.php");
			die();
		}
	}

?>

<!DOCTYPE html>
<html>
<head>
<title>Seach Page</title>
</head>
<body>

Let's learn a little bit about subsets. <br>
Look at this set of animals: {Deer, Goat, Sheep, Human, Pig, Bear, Lion, Gray Wolf, Dolphin} <br><br>
You can make subsets of these animals by what they eat: <br>
Carnivores, Omnivores, and Herbivores. <br><br>
Below, you can see how the animals are grouped. <br>

<form>
	<input type="submit" name="type" value="carnivore">
	<input type="submit" name="type" value="herbivore">
  	<input type="submit" name="type" value="omnivore">
</form>

<?php

	$response = mysqli_query($conn, "SELECT Name FROM Animals WHERE type = '$type'");
	// Type: "' UNION SELECT password FROM users WHERE username = 'Admin"
	// Answer: "' UNION SELECT flag FROM flags WHERE id = '1"

	echo "<table>
  			<tr>
    			<th align='left'>Animals</th>
  			</tr>";
  	if($response)
  	{
		while($row = mysqli_fetch_array($response)){
			echo "<tr>
    				<td>".$row['Name']."</td>
  				</tr>";
		}
	}
	echo "</table>";

?>

</body>
</html>
