$(document).ready(()=>{
    let usernamefield=$("#username"),
        passwordfield=$("#password") ,
        signinbutton=$("#login"),
        notifications=$("#notifications"),
        inputfields=$("input"),
        resetpasswordlink=$("#resetpasswordlink"),
        resetpasswordmodal=$("#resetpasswordmodal"),
        resetpasswordbutton=$("#resetpasswordbutton"),
        resetpasswordemailfield=$("#email"),
        resetemailpasswordnotifications=$("#resetemailpasswordnotifications")
    
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

    // show reset password modal
    resetpasswordlink.on("click",(e)=>{
        e.preventDefault()
        resetpasswordmodal.modal("show")
    })

    // reset the password
    resetpasswordbutton.on("click",()=>{
        const email=resetpasswordemailfield.val()
        let errors="",notification=''
            
        // check for blank fields
        if(email===""){
            errors=`<div class='alert alert-info'>
            <i class='fas fa-info-circle fa-lg fa-fw'></i>
            Please provide an Email address.
            </div>`
            resetpasswordemailfield.focus()
            resetemailpasswordnotifications.html(errors)
        }else{
            errors=`<div class='alert alert-info'>
            <i class='fas fa-paper-plane fa-lg fa-fw'></i>
            Resetting your password. Please wait ...
            </div>`
            resetemailpasswordnotifications.html(errors)
            $.post(
                "controllers/useroperations.php",
                {
                    resetpassword:true,
                    email
                },
                (data)=>{
                    data=$.trim(data)
                    if(data==="success"){
                       notification =`<div class='alert alert-success'>
                            <i class='fas fa-check-circle fa-lg fa-fw'></i>
                            Your password was reset successfully. Check your email for your new password.
                            </div>`
                            resetemailpasswordnotifications.html(notification)
                        // reset the email field
                        resetpasswordemailfield.val("")

                    }else if(data=="not exists"){
                        notification =`<div class='alert alert-info'>
                            <i class='fas fa-info-circle fa-lg fa-fw'></i>
                            Sorry, the email address was not found in our system.
                            </div>`
                            resetemailpasswordnotifications.html(notification)
                    }else{
                        notification =`<div class='alert alert-danger'>
                            <i class='fas fa-exclamation-circle fa-lg fa-fw'></i>
                            Sorry an error occured: ${data}.
                            </div>`
                            resetemailpasswordnotifications.html(notification)
                    }
                }
            )
        }
    })
})