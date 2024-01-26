<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>QueryResults</title>
</head>
<body>


<?php 
require_once('./database.php');
$selection = $_GET['queries'];
$query = "CALL ".$selection.";";

$first_row = 0;
if ($mysqli->multi_query($query)) {
    if ($result = $mysqli->store_result()) {
        while ($row = $result->fetch_row()) {
            if($selection == "Get1"){
              echo "<h4>The countries with an urbanization rate over 80% and basic sanitation facilities below the average: </h4>".$row[0];
              echo "<br/>";
              echo "<br/>";
              echo "<a href='./index.html'><button>Return</button></a>"; 
              exit();
            }
            if($selection == "Get2"){
              if ($first_row == 0) {
                $first_row = 1;
                echo "<h4>The top 10 countries in terms of educational investment and their trends in adolescent pregnancy rates from 2010 to 2019: </h4>";
                echo "<table border='1'>";
                echo "<tr><th>Country&nbsp;&nbsp;</th><th>&nbsp;&nbsp;Year&nbsp;&nbsp;</th><th>Adolescent Birth Rate (per 1000 women aged 15-19 years)</th></tr>";
                printf("<tr><td>%s</td><td>%s</td><td>%s</td></tr>", 
                $row[0], $row[1], $row[2]);
              }else{
                printf("<tr><td>%s</td><td>%s</td><td>%s</td></tr>", 
                $row[0], $row[1], $row[2]);
              }              
            }
            if ($selection == "Get3"){
              if ($first_row == 0) {
                $first_row = 1;
                echo "<h4>Among the 10 countries with the highest tax rates, the ones where the female suicide rate once exceeded the male suicide rate: </h4>";
                echo $row[0];
              }else{
                echo "<br/>";
                echo $row[0];
              }  
            }
            if($selection == "Get4"){
              if ($first_row == 0) {
                $first_row = 1;
                echo "<h4>The countries where the smoking rate among women has been higher than men, with birth rates, urbanization rates, and health expenditures: </h4>";
                echo "<table border='1'>";
                echo "<tr><th>Country&nbsp;&nbsp;</th><th>Birth rate</th><th>Urbanization rate</th><th>Out of pocket health expenditure ratio</th></tr>";
                printf("<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>", 
                $row[0], $row[1], $row[2], $row[3]);
              }else{
                printf("<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>", 
                $row[0], $row[1], $row[2], $row[3]);
              }              
            }
            if ($selection == "Get5"){
              if ($first_row == 0) {
                $first_row = 1;
                echo "<h4>The countries where the basic hand washing facility prevelance was below average in 2017 and the incidence of malaria was over 70% that year: </h4>";
                echo $row[0];
              }else{
                echo "<br/>";
                echo $row[0];
              }  
            }
            if($selection == "Get6"){
              if ($first_row == 0) {
                $first_row = 1;
                echo "<h4>The countries with low GDP per capita but high life satisfaction scores and the trends in their suicide rates from 2010 to 2020: </h4>";
                echo "<table border='1'>";
                echo "<tr><th>Country&nbsp;&nbsp;</th><th>&nbsp;&nbsp;Year&nbsp;&nbsp;</th><th>Average suicide rate</th></tr>";
                printf("<tr><td>%s</td><td>%s</td><td>%s</td></tr>", 
                $row[0], $row[1], $row[2]);
              }else{
                printf("<tr><td>%s</td><td>%s</td><td>%s</td></tr>", 
                $row[0], $row[1], $row[2]);
              }              
            }
            if($selection == "Get7"){
              if ($first_row == 0) {
                $first_row = 1;
                echo "<h4>The countries with a corruption rate greater than 0.5 and with the highest suicide rates, and the GDP, minimum wage, and total tax rate: </h4>";
                echo "<table border='1'>";
                echo "<tr><th>Country&nbsp;&nbsp;</th><th>GDP (*10^9);</th><th>Minimum wage (in local currency)</th><th>Total tax rate</th></tr>";
                printf("<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>", 
                $row[0], $row[1], $row[2], $row[3]);
              }else{
                printf("<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>", 
                $row[0], $row[1], $row[2], $row[3]);
              }              
            }
            if($selection == "Get8"){
              if ($first_row == 0) {
                $first_row = 1;
                echo "<h4>The five countries with the least nursing services and their rates of infant mortality: </h4>";
                echo "<table border='1'>";
                echo "<tr><th>Country&nbsp;&nbsp;</th><th>Infant mortality</th></tr>";
                printf("<tr><td>%s</td><td>%s</td></tr>", 
                $row[0], $row[1]);
              }else{
                printf("<tr><td>%s</td><td>%s</td></tr>", 
                $row[0], $row[1]);
              }              
            }
            if($selection == "Get9"){
              if ($first_row == 0) {
                $first_row = 1;
                echo "<h4>The countries with the highest average annual incidence of tuberculosis, with their CO2 emissions and gasoline prices: </h4>";
                echo "<table border='1'>";
                echo "<tr><th>Country&nbsp;&nbsp;</th><th>CO2 emission (in tons)</th><th>Gasoline price (in local currency per liter)</th></tr>";
                printf("<tr><td>%s</td><td>%s</td><td>%s</td></tr>", 
                $row[0], $row[1], $row[2]);
              }else{
                printf("<tr><td>%s</td><td>%s</td><td>%s</td></tr>", 
                $row[0], $row[1], $row[2]);
              }              
            }
            if($selection == "Get10"){
              if ($first_row == 0) {
                $first_row = 1;
                echo "<h4>The countries with a labor force participation rate over 0.7 and an unemployment rate below 0.05, with their scores for life satisfaction and average nursing personnel ratio: </h4>";
                echo "<table border='1'>";
                echo "<tr><th>Country&nbsp;&nbsp;</th><th>Happiness</th><th>Nursing and midwifery personnel (per 10000)</th></tr>";
                printf("<tr><td>%s</td><td>%s</td><td>%s</td></tr>", 
                $row[0], $row[1], $row[2]);
              }else{
                printf("<tr><td>%s</td><td>%s</td><td>%s</td></tr>", 
                $row[0], $row[1], $row[2]);
              }              
            }
          }
        echo "</table>";
        echo "<br/>";
        echo "<br/>";
        echo "<a href='./index.html'><button>Return</button></a>"; 
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
