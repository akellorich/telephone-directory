<?php
    require_once("db.php");
    class customer extends db{
    
        public function savecustomer($customerid, $customerno, $customername,$classificationid,$telephone,$email,$physicaladdress,$postaladdress,$town,$postalcode,
            $lat,$longitude,$regdocid, $regno,$regdate,$hasbranches,$refno){
            
            $addedby=isset($_SESSION['userid'])?$_SESSION['userid']:2;
            $regdate=$this->mySQLDate($regdate);

            $sql="CALL `sp_savecustomer`({$customerid}, '{$customerno}','{$customername}',{$classificationid},
            {$telephone},'{$email}','{$physicaladdress}','{$postaladdress}','{$town}','{$postalcode}',{$lat},{$longitude},
            {$regdocid}, '{$regno}', {$addedby},'{$regdate}',{$hasbranches},'{$refno}')";
            $this->getData($sql);

            return "success"; 
            
        }

        public function savecustomerindustry(){

        }

    }
?>