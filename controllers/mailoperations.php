<?php
    require_once("../models/mail.php");
    $mail=new mail();

    // Creat a route for saving email config
    if(isset($_POST['saveemailconfig'])){
        $emailaddress=$_POST['emailaddress'];
        $password=$_POST['password'];
        $port=$_POST['port'];
        $smtpserver=$_POST['smtpserver'];
        $usessl=$_POST['usessl'];
        echo $mail->saveemailconfig($port,$smtpserver,$emailaddress,$password,$usessl);
    }

    // Create a route for getting email configuration
    if(isset($_GET['getemailconfiguration'])){
        echo $mail->getemailconfig();
    }

    if(isset($_POST['sendemail'])){
        $recipient=$_POST['recipient'];
        $subject=$_POST['subject'];
        $message=$_POST['message'];
        $sender=(isset($_POST['sender']))?$_POST['sender']:'Telephone Directory System';
        echo $mail->sendEmail($recipient,$subject,$message,$sender);
    }

?>