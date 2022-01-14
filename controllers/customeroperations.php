<?php
    require_once("../models/customer.php");

    $customer=new customer();

    if(isset($_POST['saevcustomer'])){

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
        $hasbranches=$_POST['hasbranches'];
        $regdate=$_POST['regdate'];
        $refno=mt_rand(1000,9999);
        
        echo $customer->savecustomer($customerid, $customerno, $customername,$classificationid,$telephone,$email,$physicaladdress,$postaladdress,$town,$postalcode,
        $lat,$longitude,$regdocid, $regno,$regdate,$hasbranches,$refno);
    }

?>