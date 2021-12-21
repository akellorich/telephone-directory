$(document).ready(()=>{
    let firstnamefield=$("#firstname"),
        lastnamefield=$("#lastname"),
        usernamefield=$("#username"),
        passwordfield=$("#password"),
        confirmpasswordfield=$("#confirmpassword"),
        mobilefield=$("#mobile"),
        emailfield=$("#email"),
        savebutton=$("#saveuser"),
        notificationdiv=$("#notifications"),
        inputfields=$("input"),
        genderfield=$("#gender")
    
    // listen to save user button click
    savebutton.on("click",()=>{ 
        let firstname=firstnamefield.val(),
            lastname=lastnamefield.val(),
            username=usernamefield.val(),
            password=passwordfield.val(),
            confirmpassword=confirmpasswordfield.val(),
            mobile=mobilefield.val(),
            email=emailfield.val(),
            gender=genderfield.val(),
            userid=0,
            errors=""
        // checking for blank fields
        if(firstname==""){
            errors="Please provide first name"
            firstnamefield.focus()
        }else if(lastname==""){
            errors="Please provide lastname"
            lastnamefield.focus()
        }else if(username==""){
            errors="Please provide username"
            usernamefield.focus()
        }else if(gender==""){
            errors="Please select gender"
            genderfield.focus()
        }else if(password==""){
            errors="Please provide password"
            passwordfield.focus()
        }else if(mobile==""){
            errors="Please provide mobile number"
            mobilefield.focus()
        }else if(email==""){
            errors="Please provide email address"
            emailfield.focus()
        }else if(password!=confirmpassword){
            errors="Password entries do no match"
        }
        
        if(errors==""){
            // save the user
            let notification=`
                <div class='alert alert-info'> 
                    <i class="fas fa-hourglass-half fa-lg"></i> 
                    Processing please wait ...
                </div>`
            notificationdiv.html(notification)

            $.post(
                // first paramater URL
                "controllers/useroperations.php",
                // Second parameter data being sent to the server 
                {
                    saveuser:true,
                    userid,
                    username,
                    firstname, // firstname:firstname
                    lastname,
                    gender,
                    password,
                    mobile,
                    email,
                },
                // callback function
                (data)=>{
                    data=$.trim(data)
                    if(data=="success"){
                        notification=`
                        <div class='alert alert-success'> 
                            <i class="fas fa-check-circle fa-lg"></i> 
                            Account created successfully.
                        </div>`
                        notificationdiv.html(notification)
                        // clear screen
                        clearscreen()
                    }else if(data=="username exists"){
                        notification=`
                        <div class='alert alert-success'> 
                            <i class="fas fa-info-circle fa-lg"></i> 
                            Username already in use in the system.
                        </div>`
                        notificationdiv.html(notification)
                    }else if(data=="mobile exists"){
                        notification=`
                        <div class='alert alert-success'> 
                            <i class="fas fa-info-circle fa-lg"></i> 
                            Mobile number already in use in the system.
                        </div>`
                        notificationdiv.html(notification)
                    }else if(data=="email exists"){
                        notification=`
                        <div class='alert alert-success'> 
                            <i class="fas fa-info-circle fa-lg"></i> 
                            Email address already in use in the system.
                        </div>`
                        notificationdiv.html(notification)
                    }else{
                        notification=`
                        <div class='alert alert-danger'> 
                            <i class="fas fa-exclamation-circle fa-lg"></i> 
                            Sorry an error occured ${data}.
                        </div>`
                        notificationdiv.html(notification)
                    }
                }
            )
        }else{
            // display the error message
            errors=`<div class='alert alert-info alert-dismissible'>
                <i class='fas fa-exclamation-circle fa-lg'></i> ${errors}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>`
            notificationdiv.html(errors)
        }
    })

    // dismiss alerts when changes are happening on any input field
    inputfields.on("input",()=>{
        notificationdiv.html("")
    })

    let clearscreen=()=>{
        usernamefield.val("")
        firstnamefield.val("")
        lastnamefield.val("")
        passwordfield.val("")
        confirmpasswordfield.val("")
        mobilefield.val("")
        emailfield.val("")
        genderfield.val("")
    }

    
})