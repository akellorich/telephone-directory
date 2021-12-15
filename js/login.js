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
        }
    })

    inputfields.on("input",()=>{
        notifications.html("")
    })

})