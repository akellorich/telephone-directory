<?php
        header("Content-Type: application/json");
        require_once('../models/db.php');
        require_once("../models/mail.php");
        require_once("../models/customer.php");

        $db=new db();
        $mail=new mail();
        $customer=new customer();


        $response = '{"ResultDesc": "Confirmation Received Successfully","ResultCode": 0}';
        // Response from M-PESA Stream
        $mpesaResponse = file_get_contents('php://input');
        $jsonMpesaResponse = json_decode($mpesaResponse, true); // We will then use this to save to database
        // Extract the fields we need
        $customerid=$jsonMpesaResponse['BillRefNumber'];
        $paymentmoderef=$jsonMpesaResponse['TransID'];
        $amount=$jsonMpesaResponse['TransAmount'];
        $paymentdate=$jsonMpesaResponse['TransTime'];
        $paymentmode='MPESA';

        // check if transaction code has been used previously
        $sql="CALL sp_checktransactioncode('{$paymentmoderef}')";
        $rst=$db->getData($sql);
        if($rst->rowCount()){
            $response = '{"ResultDesc": "The transaction code already exists","ResultCode": 1}' ;
            echo $response;
        }else{
            $sql="CALL sp_getcustomerdetails({$customerid})";
            $rst=$db->getData($sql);
            if($rst->rowCount()){ 
                // save the payment
                $sql="CALL `sp_savecustomerpayment`({$customerid},'{$paymentmode}','{$paymentmoderef}',{$amount})";
                $db->getData($sql); 
                // tell MPESA its sucessfull;
                echo $response;
                // Send the customer ack email
                $customername=$customer->getcustomername($customerid);
                $customeremail=$customer->getcustomeremail($customerid);

                $subject='MPESA Payment Received Successfully '. $paymentmoderef;
                $message="Hello ".$customername.",<br/> We have received your payment of KSH.".$amount." via ".$paymentmode." Reference number ".$paymentmoderef."<br/>";
                $message.="Thank you.<br/>Kind Regards<br/><br/>Telephone Directory System";
                $mail->sendEmail($customeremail,$subject,$message,"Telephone Directory System");

            }else{
                $response = '{"ResultDesc": "Customer account does not exist","ResultCode": 1}' ;
                echo $response;
            }
        }
    
        // write to file
        $logFile = "../logfiles/success_confirmation.txt";
        $log = fopen($logFile, "a");
        fwrite($log, $mpesaResponse);
        fclose($log); 
       

?>