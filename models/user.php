<?php
    require_once("db.php");
    class user extends db{

        public function checkUserExists($userid,$checkfield,$checkvalue){
            $sql="CALL `sp_checkuserexists`({$userid},'{$checkfield}','{$checkvalue}')";
            return $this->getData($sql)->rowCount();
        }

        public function saveUser($userid,$username,$userpassword,$firstname ,$lastname,$gender,$mobile, $email,$accountactive,$systemadmin){
            // check if username is already in use
            if($this->checkUserExists($userid,'username',$username)){
                return "username exists";
            }else if($this->checkUserExists($userid,'email',$email)){
                // check if email is already in use
                return "email exists";
            }else if($this->checkUserExists($userid,'mobile',$mobile)){
                 // check if mobile is already in use
                return "mobile exists";
            }else{
                // save the user
                $sql="CALL `sp_saveuser`({$userid}, '{$username}','{$userpassword}','{$firstname}','{$lastname}','{$gender}',{$mobile}, '{$email}',{$accountactive},{$systemadmin},2)";
                $this->getData($sql);
                return "success";
            }
        }

        public function loginUser($username,$userpassword){
            $sql="CALL `sp_getuserlogindetails`('{$username}','{$userpassword}')";
            $rst=$this->getData($sql);
            if($rst->rowCount()){
                $row=$rst->fetch();
                $_SESSION['userid']=$row['userid'];
                $_SESSION['firstname']=$row['firstname'];
                $_SESSION['lastname']=$row['lastname'];
                return "success";
            }else{
                return "invalid";
            }
        }

        public function getLoggedInUserFirstName(){
            return $_SESSION['firstname'].' '. $_SESSION['lastname'];
        }

        

    }
?>
