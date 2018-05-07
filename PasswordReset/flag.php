<?php
session_start();
if (!(isset($_SESSION['login']) && $_SESSION['login'] !='')) {
	header ("Location: index.php");
}
?>

<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title></title>
  </head>
  <body>
    <h1>flag{zuck_it_suckerberg}</h1>
  </body>
</html>
