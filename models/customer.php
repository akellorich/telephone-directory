<?php
    require_once("db.php");
    class customer extends db{
    
        public function savecustomer($customerid, $customerno, $customername,$classificationid,$telephone,$email,$physicaladdress,$postaladdress,$town,$postalcode,
            $lat,$longitude,$regdocid, $regno,$regdate,$hasbranches,$refno){
            $regdate=$this->mySQLDate($regdate);
            $addedby=isset($_SESSION['userid'])?$_SESSION['userid']:2;
           
            $sql="CALL `sp_savecustomer`({$customerid}, '{$customerno}','{$customername}',{$classificationid},
            {$telephone},'{$email}','{$physicaladdress}','{$postaladdress}','{$town}','{$postalcode}',{$lat},{$longitude},
            {$regdocid}, '{$regno}', {$addedby},'{$regdate}',{$hasbranches},'{$refno}')";
            $this->getData($sql);
            return "success"; 
            
        }

        public function savetempcustomerindustry($refno,$industryid){
            $sql="CALL `sp_savetempcustomerindustry`('{$refno}',{$industryid})";
            $this->getData($sql);
        }

        public function filtercustomers($customername){
            $sql="CALL `sp_filtercustomers`('{$customername}')";
            return $this->getJSON($sql);
        }

        public function getcustomerdetails($customerid){
            $sql="CALL `sp_getcustomerdetails`({$customerid})";
            return $this->getJSON($sql);
        }

    }
?>