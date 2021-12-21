<?php
    require_once("db.php");

    class user extends db{
        public function checkuserexists($userid,$checkfield,$checkvalue){
            $sql="CALL `sp_checkuserexists`({$userid},'{$checkfield}','{$checkvalue}')";
            return $this->getData($sql)->rowCount()?true:false;
        }

        public function saveuser($userid, $username,$userpassword,$firstname,$lastname,$gender,
            $mobile, $email,$accountactive,$systemadmin,$addedby){
            // check if username has been registered
            if($this->checkuserexists($userid,'username',$username)){
                return "username exists";
            }else if($this->checkuserexists($userid,'mobile',$mobile)) {
                // check if mobile has been registered
                return "mobile exists";
            }else if($this->checkuserexists($userid,'email',$email)){
                // check if email has been registered
                return "email exists";
            }else{
                //save the user
                $sql="CALL `sp_saveuser`({$userid}, '{$username}','{$userpassword}','{$firstname}','{$lastname}',
                '{$gender}',{$mobile},'{$email}',{$accountactive},{$systemadmin},{$addedby})";
                $this->getData($sql);
                return "success";
            }
 
        }
    }

?>