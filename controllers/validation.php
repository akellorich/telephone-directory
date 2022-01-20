<?php
    require_once("../models/db.php");

    $db=new db();

    $mpesaResponse = file_get_contents('php://input');
   
    $jsonMpesaResponse = json_decode($mpesaResponse, true);

    $response = '{"ResultDesc": "Confirmation Received Successfully","ResultCode": 0}';

    $customerid=$jsonMpesaResponse['BillRefNumber'];
    // check that the tenant exists and that their balance is correct
    $sql="CALL sp_getcustomerbalance({$customerid})";
    //echo $sql."<br/>";
    $rst=$db->getData($sql);
    if($rst->rowCount()){
        // check if amountpaid is the same as the customer's balance
        $customerbalance=$rst->fetch()['customerbalance'];
        $amountpaid=$jsonMpesaResponse['TransAmount'];
        if($customerbalance==$amountpaid){
            $response = '{"ResultDesc": "Confirmation Received Successfully","ResultCode": 0}';
        }else{
            $errormessage="Sorry amount payabale should be ".$customerbalance;
            $response = '{"ResultDesc": '.$errormessage.',"ResultCode": 1}';
            // save the validation in a log file
            $logFile = "../logfiles/failed_validations.txt"; 
            $errormessage="Sorry amount paid should be ".$customerbalance;
            $response = '{"ResultDesc": '.$errormessage.',"ResultCode": 1}';
            // save the validation in a log file
            $logFile = "failed_validations.txt"; 
            $log = fopen($logFile, "a");
            fwrite($log, $mpesaResponse);
            fclose($log);
        }
    }else{
        $response = '{"ResultDesc": "Sorry account number does not exist","ResultCode": 1}';
        $logFile = "../logfiles/failed_validations.txt"; 
        $log = fopen($logFile, "a");
        fwrite($log, $mpesaResponse);
        fclose($log);
    }
    // else{
    //     $response = '{"ResultDesc": "Sorry, we did not find the number: '.$customerno.' in our system.","ResultCode": 1}';
    //     $mobilenumber=$jsonMpesaResponse['MSISDN'];
    //     $message="Sorry, we did not find the account number:  ".$customerno." in our system. Kindly correct then try again";
    //     $sms->sendSMS($mobilenumber,$message);  
    // }
    echo $response;

/*
    {
        "TransactionType":"",
        "TransID":"LGR219G3EY",
        "TransTime":"20170727104247",
        "TransAmount":"10.00",
        "BusinessShortCode":"600134",
        "BillRefNumber":"4231",
        "InvoiceNumber":"",
        "OrgAccountBalance":"",
        "ThirdPartyTransID":"",
        "MSISDN":"254727709772",
        "FirstName":"John",
        "MiddleName":"Doe",
        "LastName":""
    }
*/

?>