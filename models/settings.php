<?php
    require_once("db.php");

    class settings extends db{

        public function getclassification(){
            $sql="CALL  `sp_getexistingclassifications`(1)";
            return $this-> getJSON($sql);
        }

        public function getindustries(){
            $sql="CALL  `sp_getexistingindustries`(1)";
            return $this-> getJSON($sql);
        }

        public function getregdocs(){
            $sql="CALL  `sp_getexistingregistrationdocuments`(1)";
            return $this-> getJSON($sql);
        }
    }

?>