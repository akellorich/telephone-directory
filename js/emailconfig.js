$(document).ready(()=>{
    const emailaddressfield=$("#emailaddress"),
        passwordfield=$("#password"),
        smtpserverfield=$("#smtpserver"),
        portfield=$("#port"),
        usesslfield=$("#usessl"),
        saveconfigbutton=$("#saveemailconfig"),
        saveconfignotifications=$("#saveconfignotifications"),
        sendemailnotifications=$("#sendemailnotifications"),
        sendtestemailbutton=$("#sendtestemail"),
        subjectfield=$("#subject"),
        messagefield=$("#message"),
        recipientfield=$("#recipient")
    
    // save email configuration
    saveconfigbutton.on("click",()=>{
        let emailaddress=emailaddressfield.val(),
            password=passwordfield.val(),
            smtpserver=smtpserverfield.val(),
            port=portfield.val(),
            usessl=usesslfield.prop("checked")?1:0;
        $.post(
            "controllers/mailoperations.php",
            {
                saveemailconfig:true,
                emailaddress,
                password,
                smtpserver,
                port,
                usessl
            },
            (data)=>{
                data=data.trim()
                let notification=''
                if(data==="success"){
                    notification=`<div class='alert alert-success'>
                    <i class='fas fa-check-circle fa-lg fa-fw'></i>
                    The email configuration saved successfully
                    </div>`
                    saveconfignotifications.html(notification)
                }else{
                    notification=`<div class='alert alert-danger'>
                    <i class='fas fa-times-circle fa-lg fa-fw'></i>
                    Sorry an error occured ${data}
                    </div>`
                    saveconfignotifications.html(notification)
                }
            }
        )
    })

    // send test email
    sendtestemailbutton.on("click",()=>{
        let subject=subjectfield.val(),
            recipient=recipientfield.val(),
            message=messagefield.val()
            // show progress for sending email
            notification=`<div class='alert alert-info'>
                <i class='fas fa-paper-plane fa-lg fa-fw'></i>
                Sending test email. Please wait ...
                </div>`
            sendemailnotifications.html(notification)
        $.post(
            "controllers/mailoperations.php",
            {
                sendemail:true,
                recipient,
                subject,
                message
            },
            (data)=>{
                data=data.trim()
                let notification=''
                if(data==="success"){
                    notification=`<div class='alert alert-success'>
                    <i class='fas fa-check-circle fa-lg fa-fw'></i>
                    The test email was sent successfully
                    </div>`
                    sendemailnotifications.html(notification)
                }else{
                    notification=`<div class='alert alert-danger'>
                    <i class='fas fa-times-circle fa-lg fa-fw'></i>
                    Sorry test email not sent ${data}
                    </div>`
                    sendemailnotifications.html(notification)
                }
            }
        )

    })

})