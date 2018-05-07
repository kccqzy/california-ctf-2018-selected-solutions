<?php
   $errorMessage = "";
   if($_SERVER["REQUEST_METHOD"] == "GET" && isset($_GET["verification_code"])){
	   $verification_code = $_GET["verification_code"];

		   if($verification_code == 48750)
       {
          session_start();
          $_SESSION['login'] = 1;
          header("Location: flag.php");
          header("HTTP/1.1 302 found");
        }
        else{
          $errorMessage = "Login Failed :( ";
          header("Location: index.php");
          header("HTTP/1.1 200 ok");
        }
     }
?>

<!DOCTYPE html>
<html>
<head>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</head>
	<title>BookFace Password Reset</title>
</head>
<body>

<section class="container">
<h2>BookFace Password Reset</h2>

</section>


<section class="container jumbotron">
    <div class="row">
	    <div class="col-md-4">
			<form action="index.php" method="get">
				<div class="form-group">
					5-Digit Verification Code: <input type="text" name="verification_code" class="form-control">
			    	<button type="submit" class="btn btn-info">Submit</button>
				</div>
			</form>
		</div>
    </div>
  <div class="col-md-4" style="color: red;">
  <?php
        echo $errorMessage;
        if(isset($_GET['verification_code']))
            echo $_GET["verification_code"]. " is incorrect";
     ?>
  </div>
</section>

</body>
</html>
