<?php
    require_once("../models/customer.php");
    require_once("../models/mail.php");

    $customer=new customer();
    $mail=new mail();

    if(isset($_POST['savecustomer'])){

        $customerid=$_POST['customerid']==""?0:$_POST['customerid'];
        $customerno=$_POST['customerno'];
        $customername=$_POST['customername'];
        $classificationid=$_POST['classificationid'];
        $telephone=$_POST['telephone'];
        $email=$_POST['email'];
        $physicaladdress=$_POST['physicaladdress'];
        $postaladdress=$_POST['postaladdress'];
        $town=$_POST['town'];
        $postalcode=$_POST['postalcode'];
        $lat=$_POST['lat'];
        $longitude=$_POST['longitude'];
        $regdocid=$_POST['regdocid'] ;
        $regno=$_POST['regno'];
        $regdate=$_POST['regdate'];
        $hasbranches=$_POST['hasbranches'];
        $industries=$_POST['industries'];
        $industries=stripcslashes($industries);
        $industries=json_decode($industries,true);
        $refno=mt_rand(10000,100000);
        
        foreach ($industries as $industry) {
            $customer->savetempcustomerindustry($refno,$industry);
        }

        $rst= $customer->savecustomer($customerid, $customerno, $customername,$classificationid,$telephone,$email,$physicaladdress,$postaladdress,$town,$postalcode,
        $lat,$longitude,$regdocid, $regno,$regdate,$hasbranches,$refno);

        if($customerid==0){
            $customerid=$rst['customerid'];
            $amount=$rst['billedamount'];

            // send an email to the customer with payment instructions
            $subject='Account Registration Succesful. Payment Required!';
            $messagebody='Hello '.$customername.',<br/>Your account has been registered successfully.<br/>';
            $messagebody.='To activate the account for display on the online directory, please make a payment using the following process.<br/>';
            $messagebody.='1. Go to MPESA.<br/>';
            $messagebody.='2. Select Lipa na MPESA.<br/>';
            $messagebody.='3. Select Paybill.<br/>';
            $messagebody.='4. Enter Paybill Number <strong>123456</strong>.<br/>';
            $messagebody.='5. Enter Account Number <strong>'.$customerid.'</strong>.<br/>';
            $messagebody.='6. Enter Amount <strong>'.$amount.'</strong>.<br/>';
            $messagebody.='7. Enter Your MPESA pin and send.<br/></br>';
            $messagebody.='Kind Regards.<br/>';
            $messagebody.='Telphone Directory System.';
            $mail->sendEmail($email,$subject,$messagebody,'Telephone Directory System');
            echo "success";

        }
    }

    if(isset($_GET['filtercustomers'])){
        $customername=$_GET['customername'];
        echo $customer->filtercustomers($customername);
    }

    if(isset($_GET['getcustomerdetails'])){
        $customerid=$_GET['customerid'];
        echo $customer->getcustomerdetails($customerid);
    }

    if(isset($_GET['getcustomerindustries'])){
        $customerid=$_GET['customerid'];
        echo $customer->getcustomerindustries($customerid);
    }

    // Create a route for uploading customer logo
    if(isset($_POST['changecustomerlogo'])){
        $customerid=$_POST['customerid'];
        $imagepath='../customer_images/'.mt_rand(100000,9999999).'_'.$_FILES['file']['name'];
        $tempname=$_FILES['file']['tmp_name'];
        // moving the file from temp to permanent location
        if(move_uploaded_file($tempname,$imagepath)){
            // update the path in the database
            echo $customer->changecustomerlogo($customerid,$imagepath);
        }else{
            echo "failed";
        }
    }

    // create a route for saving the customer branch
    if(isset($_POST['savecustomerbranch'])){
        $branchid=$_POST['branchid'];
        $customerid =$_POST['customerid'];
        $branchname=$_POST['branchname'];
        $physicaladdress =$_POST['physicaladdress'];
        $lat =$_POST['lat'];
        $lon =$_POST['lon'];
        $telephone=$_POST['telephone'];
        $email=$_POST['email'];
        echo $customer-> savecustomerbranch($branchid,$customerid, $branchname,$physicaladdress, $lat, $lon, $telephone,$email);
    }

    // route for fetching customer branches

    if(isset($_GET['getcustomerbranches'])){
        $customerid=$_GET['customerid'];
        echo $customer->getcustomerbranches($customerid);
    }

    if(isset($_GET['getcustomerbyclassification'])){
        echo $customer->getcustomerbyclassification();
    }

    if(isset($_GET['getcustomersbyindustry'])){
        echo $customer->getcustomerbyindustry();
    }

?>