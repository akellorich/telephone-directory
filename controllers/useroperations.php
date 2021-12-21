<?php
    require_once("../models/user.php");
    $user = new user();

    if(isset($_POST['saveuser'])){
        $userid=$_POST['userid'];
        $username=$_POST['username'];
        $firstname=$_POST['firstname'];
        $lastname=$_POST['lastname'];
        $gender=$_POST['gender'];
        $password=md5($_POST['password']);
        $email=$_POST['email'];
        $mobile=$_POST['mobile'];

        $accountactive=isset($_POST['accountactive'])?$_POST['accountactive']:1;
        $systemadmin=isset($_POST['systemadmin'])?$_POST['systemadmin']:0;
        $addedby=isset($_POST['addedby'])?$_POST['addedby']:2;

        echo $user->saveuser($userid, $username,$password,$firstname,$lastname,$gender,
        $mobile, $email,$accountactive,$systemadmin,$addedby);

    }
?>