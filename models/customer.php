<?php
    require_once("db.php");
    class customer extends db{
    
        public function savecustomer($customerid, $customerno, $customername,$classificationid,$telephone,$email,$physicaladdress,$postaladdress,$town,$postalcode,
            $lat,$longitude,$regdocid, $regno){
            
            $addedby=isset($_SESSION['userid'])?$_SESSION['userid']:2;
           
            $sql="CALL `sp_savecustomer`({$customerid}, '{$customerno}','{$customername}',{$classificationid},
            {$telephone},'{$email}','{$physicaladdress}','{$postaladdress}','{$town}','{$postalcode}',{$lat},{$longitude},
            {$regdocid}, '{$regno}', {$addedby})";
            $this->getData($sql);
            return "success"; 
            
        }

        public function savecustomerindustry(){

        }

    }
?>