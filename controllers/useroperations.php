<?php
    require_once("../models/user.php");

    $user= new user();

    if(isset($_POST['saveuser'])){
        $userid=$_POST['userid'];
        $username=$_POST['username'];
        $firstname=$_POST['firstname']; 
        $lastname=$_POST['lastname'];
        $gender=$_POST['gender'];
        $userpassword=md5($_POST['password']);
        $mobile=$_POST['mobile'];
        $email=$_POST['email'];
        $accountactive=isset($_POST['accountactive'])?1:0;
        $systemadmin=isset($_POST['systemadmin'])?1:0;
        echo $user->saveUser($userid,$username,$userpassword,$firstname ,$lastname,$gender,$mobile, $email,$accountactive,$systemadmin);
    }

    if(isset($_POST['loginuser'])){
        $username=$_POST['username'];
        $userpassword=md5($_POST['password']);
        echo $user->loginUser($username,$userpassword);
    }

    if(isset($_GET['getuserfirstname'])){
        echo $user->getLoggedInUserFirstName();
    }

?>