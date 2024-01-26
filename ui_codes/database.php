<?php
    $mysqli = new mysqli("dbase.cs.jhu.edu","23fa_lyang101","L8oEWEROgd","23fa_lyang101_db");
    if (mysqli_connect_errno()) {
        printf("Connect failed: %s<br>", mysqli_connect_error());
        exit();
    }
?>

