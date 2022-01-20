$(document).ready(()=>{
    const customeridfield=$("#customerid")
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
    const hasbrachesfield=$("#hasbranches")
    // check if we are on edit mode
    const customerid=location.hash.substring(1)
    // get registration documents
    getcustomerclassifications().done(()=>{
         getregistrationdocuments().done(()=>{
            getcustomerindustries().done(()=>{
                if(customerid!==undefined ){
                    // switch to edit mode
                    // get customers details and populate on the screen
                    $.getJSON(
                        "controllers/customeroperations.php",
                        {
                            getcustomerdetails:true,
                            customerid
                        },
                        (data)=>{
                            // customeridfield.val(data[0].customerid)
                            customeridfield.val(customerid)
                            customernamefield.val(data[0].customername)
                            physicaladdressfield.val(data[0].physicaladdress)
                            postaladdressfield.val(data[0].postaladdress)
                            townfield.val(data[0].town)
                            postalcodefield.val(data[0].postalcode)
                            telephonefield.val(data[0].telephone)
                            emailfield.val(data[0].email)
                            coordinatesfield.val(`${data[0].lat},${data[0].long}`)
                            regdocnofield.val(data[0].regno)
                            regdatefield.val(data[0].registrationdate)
                            // regdatefield.val(data[0].physicaladdress)
                            hasbrachesfield.prop("checked",data[0].hasbranches)
                            classificationfield.val(data[0].classificationid)
                            regdocfield.val(data[0].regdocid)
                        }
                    )
                    // get the customer industries
                    $.getJSON(
                        "controllers/customeroperations.php",
                        {
                            getcustomerindustries:true,
                            customerid
                        },
                        (data)=>{
                            // unchhek all checkboxes
                            industrieslist.find(".industry").prop("checked",false)
                            data.forEach((industry)=>{
                                industrieslist.find(".industry").each(function(){
                                    let $this=$(this)
                                    if($this.attr("id")==industry.industryid){
                                        $this.prop("checked",true)
                                    }
                                })
                            })
                        }
                    )
                }else{
                    customeridfield.val("0")
                }
            })
         })
        
    })
   
   
   

    
    // assign datepicker to the regdatefield
    regdatefield.datepicker({maxDate: new Date(),dateFormat: 'dd-M-yy'})
    // get existing classifications form the database
    function getcustomerclassifications(){
        dfd= new $.Deferred()
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
                dfd.resolve()
            }
        )
        return dfd.promise()
    }
    
    // get existing registration documents
    function getregistrationdocuments(){
        dfd = new $.Deferred()
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
                dfd.resolve()
            }
        )
        return dfd.promise()
    }
    

    // get existing industries
    function getcustomerindustries(){
        dfd= new $.Deferred()
        $.getJSON(
            "controllers/settingsoperations.php",
            {
                getindustries:true
            },
            (data)=>{
                let results=""
                data.forEach((industry)=>{
                    results+=`<tr><td><input type='checkbox' id='${industry.industryid}' class='industry'></td><td>${industry.description}</td></tr>`
                })
                industrieslist.find("tbody").html(results)
                dfd.resolve()
            }
        )
        return dfd.promise()
    }
    

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
        let coords=coordinatesfield.val().split(","),
            customerid=customeridfield.val(),
            classificationid=classificationfield.val(),
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
            hasbranches=hasbrachesfield.prop("checked")?1:0,
            industries=[];
        
        // generate the customers industry
        $(".industry").each(function(){
            $this=$(this)
           if($this.prop("checked")){
               industries.push($this.attr("id"))
           }
        })
        // convert the industries variable into a JSON object
        industries=JSON.stringify(industries)
        // check for blank fields
        // save the data 
        notification=`
        <div class='alert alert-info'>
            <i class='fas fa-paper-plane fa-lg'></i> 
            Processing. Please wait ...
        </div>`
        notifications.html(notification)
        $.post(
            "controllers/customeroperations.php",
            {
                savecustomer:true,
                customerid,
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
                hasbranches,
                industries
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