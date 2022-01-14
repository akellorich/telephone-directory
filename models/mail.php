<?php
    require_once("db.php");
    use PHPMailer\PHPMailer\PHPMailer;
    require_once("../phpmailer/PHPMailer.php");
    require_once("../phpmailer/SMTP.php");
    require_once("../phpmailer/Exception.php");

    class mail extends db {
        private $smtpserver;
        private $smtpport;
        private $emailaddress;
        private $usessl;
        private $password;
        private $username;
        
        public function __construct(){
            $sql="CALL `sp_getemailconfig`()";
            $rst=$this->getData($sql);
            if($rst->rowCount()){
                $rst=$rst->fetch();
                $this->smtpserver=$rst['smtpserver'];
                $this->smtpport=$rst['port'];
                $this->emailaddress=$rst['emailaddress'];
                $this->password=$rst['password'];
                $this->usessl=$rst['usessl'];
            }
        }

        public function saveemailconfig($emailport,$smtpserver,$emailaddress,$emailpassword,$usessl){
            $sql="CALL `sp_saveemailconfig`({$emailport},'{$smtpserver}','{$emailaddress}','{$emailpassword}',$usessl)";
            $this->getData($sql);
            return "success";
        }

        public function getemailconfig(){
            $sql="CALL `sp_getemailconfig`()";
            return $this->getJSON($sql);
        }

        public function sendEmail($recipient,$subject,$message,$sender,$attachment='',$stringattachment='',$filename=''){
            $mail= new PHPMailer();

            $mail->isSMTP();
            $mail->Host=$this->smtpserver;
            $mail->SMTPAuth=true;
            $mail->Username=$this->emailaddress;
            $mail->Password=$this->password;
            $mail->Port=$this->smtpport;
            $mail->SMTPSecure=$this->usessl;

            $mail->isHTML(true);
            $mail->SetFrom($this->emailaddress,$sender);
            $mail->addAddress($recipient);
            $mail->Subject=$subject;
            $mail->Body=$message;
            
            if($attachment!=""){
                $mail->AddAttachment($attachment);
            }

            if($stringattachment!=""){
                $mail->addStringAttachment($stringattachment,$filename);
            }

            if($mail->send()){
                return "success";
            }else{
                return $mail->ErrorInfo;
            }
        }
    }


?>