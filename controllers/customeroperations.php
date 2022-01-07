<?php
    require_once("../models/customer.php");

    $customer=new customer();

    if(isset($_POST['savecustomer'])){

        $customerid=$_POST['customerid'];
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

        echo $customer->savecustomer($customerid, $customerno, $customername,$classificationid,$telephone,$email,$physicaladdress,$postaladdress,$town,$postalcode,
        $lat,$longitude,$regdocid, $regno,$regdate,$hasbranches,$refno);
    }

    if(isset($_GET['filtercustomers'])){
        $customername=$_GET['customername'];
        echo $customer->filtercustomers($customername);
    }

    if(isset($_GET['getcustomerdetails'])){
        $customerid=$_GET['customerid'];
        echo $customer->getcustomerdetails($customerid);
    }

?>