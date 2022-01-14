$(document).ready(()=>{
    const classificationfield=$("#customerclassification")
    const regdocfield=$("#regdoc")
    const industrieslist=$("#industrieslist")
    const addcoordinatesbutton=$("#addcoordinates")
    const coordinatesfield=$("#coordinates")
    const savebutton=$("#savecustomer")
    const customernamefield=$("#customername")
    const physicaladdressfield=$("#physicaladdress")
    const postaladdressfield=$("#postaladdress")
    const townfield=$("#town")
    const postalcodefield=$("#postalcode")
    const telephonefield=$("#telephone")
    const emailfield=$("#email")
    const regdocnofield=$("#regdocno")
    const notifications=$("#notifications")
    const regdatefield=$("#regdate")
    const hasbranchesfield=$("#branches")
    
    // get existing classifications form the database
    $.getJSON(
        "controllers/settingsoperations.php",
        {
            getclassifications:true
        },
        (data)=>{
            let results=`<option value=''>&lt;Choose One&gt;</option>`
            data.forEach((classification)=>{
                results+=`<option value='${classification.classificationid}'>${classification.description}</option>`
            })
            // push the data to the select dropdown
            classificationfield.html(results)
        }
    )

    // get existing registration documents
    $.getJSON(
        "controllers/settingsoperations.php",
        {
            getregdocs:true
        },
        (data)=>{
            let results=`<option value=''>&lt;Choose One&gt;</option>`
            data.forEach((regdoc)=>{
                results+=`<option value='${regdoc.regdocid}'>${regdoc.description}</option>`
            })
            regdocfield.html(results)
        }
    )

    // get erxisting industries
    $.getJSON(
        "controllers/settingsoperations.php",
        {
            getindustries:true
        },
        (data)=>{
            let results=""
            data.forEach((industry)=>{
                results+=`<tr><td><input type='checkbox' id='${industry.industryid}'></td><td>${industry.description}</td></tr>`
            })
            industrieslist.find("tbody").html(results)
        }
    )

    // listen to the click event of the current location 
    addcoordinatesbutton.on("click",()=>{
        
        const errorCallback=(error)=>{
            console.error(error)
        }

        const successCallback=(position)=>{
            coordinatesfield.val(`${position.coords.latitude}, ${position.coords.longitude}`)
        }

        navigator.geolocation.getCurrentPosition(successCallback,errorCallback,{setHighAccuracy:true})
    })

    // listen to click of the save button 
    savebutton.on("click",()=>{
        coords=coordinatesfield.val().split(",")
        let classificationid=classificationfield.val(),
            regdocid=regdocfield.val(),
            lat=coords[0].trim(),
            longitude=coords[1].trim(),
            customername=customernamefield.val(),
            physicaladdress=physicaladdressfield.val(),
            postaladdress=postaladdressfield.val(),
            town=townfield.val(),
            postalcode=postalcodefield.val(),
            telephone=telephonefield.val(),
            email=emailfield.val(),
            regno=regdocnofield.val(),
            regdate=regdatefield.val(),
            hasbranches=hasbranchesfield.prop("checked")?1:0
        // check for blank fields
        // save the data 
        $.post(
            "controllers/customeroperations.php",
            {
                saevcustomer:true,
                customerid:0,
                customerno:'',
                customername,
                classificationid,
                telephone,
                email,
                physicaladdress,
                postaladdress,
                town,
                postalcode,
                lat,
                longitude,
                regdocid,
                regno,
                regdate, 
                hasbranches

            },
            (data)=>{
                let notification=""
                data=$.trim(data)
                if(data=="success"){
                    notification=`
                    <div class='alert alert-success'>
                        <i class='fas fa-check-circle fa-lg'></i> 
                        The customer has been added successfully.
                    </div>`
                    notifications.html(notification)
                }else{
                    notification=`
                    <div class='alert alert-danger'>
                        <i class='fas fa-times-circle fa-lg'></i> 
                        Sorry an error occured. ${data}
                    </div>`
                    notifications.html(notification)
                }
            }
        )
        
    })
})