<?php
    class mpesa {
        private $consumerkey='Tq3RenSyB1yuUqnURw15pFLVF06T0Mkm';
        private $consumersecret='l1rXvpOGx4FcECf5';
        private $tokenurl='https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials';
        private $token;
        private $registerlinksurl='https://sandbox.safaricom.co.ke/mpesa/c2b/v1/registerurl';
       
        public function __construct(){
            $this->gettoken();
        }

        private function gettoken(){
            $password=$this->consumerkey.':'.$this->consumersecret;
            $headers = ['Content-Type:application/json'];
            $url = $this->tokenurl;
          
            $curl = curl_init($this->tokenurl);
            curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
            curl_setopt($curl, CURLOPT_RETURNTRANSFER, TRUE);
            curl_setopt($curl, CURLOPT_HEADER, FALSE);
            curl_setopt($curl, CURLOPT_USERPWD,$password);
            $result = curl_exec($curl);
            $status = curl_getinfo($curl, CURLINFO_HTTP_CODE);
            $result = json_decode($result,TRUE);
            $this->token = $result['access_token'];
            curl_close($curl);
        }

        public function showtoken(){
            echo $this->token;
        }

        public function registerurls($validationurl,$confirmationurl){
            // $this->gettoken();
            $curl = curl_init();
            curl_setopt($curl, CURLOPT_URL, $this->registerlinksurl);
            curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type:application/json','Authorization:Bearer '.$this->token)); //setting custom header

            $curl_post_data = array(
              //Fill in the request parameters with valid values
              'ShortCode' =>'600980' ,//$this->shortCode
              'ResponseType' => 'Completed',
              'ConfirmationURL' => $confirmationurl,
              'ValidationURL' => $validationurl
            );
        
            $data_string = json_encode($curl_post_data);
            
            curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($curl, CURLOPT_POST, true);
            curl_setopt($curl, CURLOPT_POSTFIELDS, $data_string);
        
            $curl_response = curl_exec($curl);
           // print_r($curl_response);

            return json_encode($curl_response,true);
        }



    }   

?>