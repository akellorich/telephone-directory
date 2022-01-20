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
            // echo $sql."<br/>";
            return $this->getData($sql)->fetch(); 
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

        public function getcustomerindustries($customerid){
            $sql="CALL `sp_getcustomerindustries`({$customerid})";
            return $this->getJSON($sql);
        }

        public function changecustomerlogo($customerid,$imagepath){
            $sql="CALL `sp_changecustomerlogo`({$customerid},'{$imagepath}')";
            $this->getData($sql);
            return "success";
        }

        public function savecustomerbranch($branchid,$customerid, $branchname,$physicaladdress, $lat, $lon, $telephone,$email){
            $sql="CALL `sp_savecustomerbranch`({$branchid},{$customerid},'{$branchname}','{$physicaladdress}',{$lat}, {$lon},{$telephone},'{$email}')";
            $this->getData($sql);
            return "success";
        }

        public function getcustomerbranches($customerid){
            $sql="CALL `sp_getcustomerbranches`({$customerid})";
            return $this->getJSON($sql);
        }

        public function getcustomername($customerid){
            $sql="CALL `sp_getcustomerdetails`({$customerid})";
            // $rst=$this->getData($sql);
            // $row=$rst->fetch();
            // return $row['customername'];
            return $this->getData($sql)->fetch()['customername'];
        }

        public function getcustomeremail($customerid){
            $sql="CALL `sp_getcustomerdetails`({$customerid})";
            return $this->getData($sql)->fetch()['email'];
        }

        public function getcustomerbyclassification(){
            $sql="CALL `sp_getcustomerbyclassification`()";
            return $this->getJSON($sql);
        }

        public function getcustomerbyindustry(){
            $sql="CALL `sp_summarizecustomerbyindustry`()";
            return $this->getJSON($sql);
        }

    }
?>