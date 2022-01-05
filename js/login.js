$(document).ready(()=>{
    let usernamefield=$("#username"),
        passwordfield=$("#password") ,
        signinbutton=$("#login"),
        notifications=$("#notifications"),
        inputfields=$("input")
    
    signinbutton.on("click",()=>{
        // check for blank fields
        let username=usernamefield.val(),
            password=passwordfield.val(),
            errors=""

        errors=username=="" ?"Please provide username":password==""?errors="Please provide password": ""
       
        if(errors!=""){
            errors=`
            <div class='alert alert-info alert-dismissible fade show'><i class='fas fa-info-circle fa-lg'></i> ${errors}
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
            </div>` 
            notifications.html(errors)
        }else{
            errors=`
                <div class='alert alert-info'> 
                    <i class="fas fa-hourglass-half fa-lg"></i> 
                    Logging you in, please wait ...
                </div>`
            notifications.html(errors)
            
            $.post(
                "controllers/useroperations.php",
                {
                    loginuser:true,
                    username,
                    password
                },
                (data)=>{
                    data=$.trim(data)
                    if(data=="invalid"){
                        errors=`
                            <div class='alert alert-danger'> 
                                <i class="fas fa-exclamation-circle fa-lg"></i> 
                               Invalid <strong>Username</strong> or <strong>Password</strong>
                            </div>`
                        notifications.html(errors)
                    }else if(data=="success"){
                        location.assign("main.html")
                    }else{
                        errors=`
                            <div class='alert alert-danger'> 
                                <i class="fas fa-exclamation-circle fa-lg"></i> 
                               Sorry  an error occured. ${data}
                            </div>`
                        notifications.html(errors)
                    }
                }
            )
        }
    })

    inputfields.on("input",()=>{
        notifications.html("")
    })

})