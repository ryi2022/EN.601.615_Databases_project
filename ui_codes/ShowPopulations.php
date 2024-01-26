<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>ShowPopulations</title>
</head>
<body>
<?php 
require_once('./database.php');
$country = $_POST['country'];
$query = "CALL ShowPopulations('".$country."');";


if ($mysqli->multi_query($query)) {
    if ($result = $mysqli->store_result()) {
        while ($row = $result->fetch_row()) {
            if($row[0] == "Country does not exist in database."){
              echo "<h1>Country does not exist in database.</h1>";
              echo "<a href='./index.html'><button>Return</button></a>"; 
              exit();
            }
            echo "<strong>Country name:</strong> ".$row[0];
            echo "<br/>";
            echo "<strong>Total population:</strong> ".$row[1];
            echo "<br/>";
            echo "<br/>";
            echo "<strong>Yearly average of</strong> ";
            echo "<br/>";
            echo "&nbsp;&nbsp;&nbsp;&nbsp;Doctor population: ".$row[2];
            echo "<br/>";
            echo "&nbsp;&nbsp;&nbsp;&nbsp;Nursing personnel population:".$row[3];
            echo "<br/>";
            echo "&nbsp;&nbsp;&nbsp;&nbsp;Have basic washing facility population (rural area):".$row[4];
            echo "<br/>";
            echo "&nbsp;&nbsp;&nbsp;&nbsp;Have basic washing facility population (urban area):".$row[5];
            echo "<br/>";
            echo "&nbsp;&nbsp;&nbsp;&nbsp;Have basic washing facility population (in total):".$row[6];
            echo "<br/>";
            echo "&nbsp;&nbsp;&nbsp;&nbsp;Use basic sanitation service population (rural area):".$row[7];
            echo "<br/>";
            echo "&nbsp;&nbsp;&nbsp;&nbsp;Use basic sanitation service population (urban area):".$row[8];
            echo "<br/>";
            echo "&nbsp;&nbsp;&nbsp;&nbsp;Use basic sanitation service population (total):".$row[9];
            echo "<br/>";
            echo "<br/>";
            echo "<a href='./index.html'><button>Return</button></a>"; 
            }
        $result->close();
      } 
} else {
    echo "<h1>Failed</h1>";
    printf($mysqli->error);
    echo "<a href='./index.html'><button>Return</button></a>"; 
    exit();
  }
 ?>
</body>
</html>
