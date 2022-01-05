<?php
    require_once("../models/settings.php");

    $setting=new settings();

    if(isset($_GET['getclassifications'])){
        echo $setting->getclassification();
    }
    
    if(isset($_GET['getregdocs'])){
        echo $setting->getregdocs();
    }

    if(isset($_GET['getindustries'])){
        echo $setting->getindustries();
    }

?>