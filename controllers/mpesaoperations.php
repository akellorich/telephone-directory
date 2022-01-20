<?php
    require_once("../models/mpesanew.php");
    $mpesa=new mpesa();
    $mpesa->showtoken();
    if(isset($_POST['registerurl'])){
        $validationurl=$_POST['validationurl'];
        $confirmationurl=$_POST['confirmationurl'];
        echo $mpesa->registerurls($validationurl,$confirmationurl);
    }
?>