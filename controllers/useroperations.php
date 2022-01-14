<?php
    require_once("../models/user.php");
    require_once("../models/mail.php");

    $user= new user();
    $mail=new mail();

    if(isset($_POST['saveuser'])){
        // generate activation code
        $activationcode=mt_rand(10000,99999);
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
        $emailbody='Hello '.$firstname.' '.$lastname.',<br>Welcome to telephone directory service.<br>Your account has been created and needs activation.<br>Kindly Use the activation code <h2>'.$activationcode.'</h2> to activate your account .<br> Kind Regards<br/>Telephone Directory Team<br/>';
        $emailsubject='Telephone Directory Account Activation';
        echo $user->saveUser($userid,$username,$userpassword,$firstname ,$lastname,$gender,$mobile, $email,$accountactive,$systemadmin,$activationcode);
        // send the email to the user
        $mail->sendEmail($email,$emailsubject,$emailbody,'Telephone Directory Team');
    }

    if(isset($_POST['loginuser'])){
        $username=$_POST['username'];
        $userpassword=md5($_POST['password']);
        echo $user->loginUser($username,$userpassword);
    }

    if(isset($_GET['getuserfirstname'])){
        echo $user->getLoggedInUserFirstName();
    }

    if(isset($_POST['resetpassword'])){
        $email=$_POST['email'];
        $rst=$user->getuserwithemail($email);
        //  check if the user exists 
        if($rst->rowCount()){
            $rst=$rst->fetch();
            $userid=$rst['userid'];
            $fullname=$rst['firstname']. ' '.$rst['lastname'];
            // Change the password
            $password=mt_rand(100000,999999);
            // email the user the new password 
            echo $user->changeuserpassword($userid,md5($password));
            $subject='Telephone Directory App Password Reset';
            $message='Hello '.$fullname.'<br/> Your password for Telephone Directory App has been reset successfully.<br>Your new password is <h2>'.$password.'</h2><br/>Thank you.<br> Telephone Directory System';
            // Email user their new password
            $mail->sendEmail($email,$subject,$message,'Telephone Directory Team');
        }else{
            echo "not exists";
        }
    }

?>