$(document).ready(function(){
    let firstnamefield=$("#firstname")
    const searchbutton=$("#searchbutton")
    const searchfield=$("#searchtext")
    const searchresults=$("#searchresults")
    const notifications=$("#notifications")
    const branchcustomername=$("#branchcustomername")
    const branchmodal=$("#customerbranch")
    const branchcustomeridfield=$("#branchcustomerid")
    const branchidfield=$("#branchid")
    const addbranchlocationbutton=$("#addbranchcoordinates")
    const branchcoordinatesfield=$("#branchcoordinates")
    const savebranchbutton=$("#savecustomerbranch")
    const branchnamefield=$("#branchname")
    const physicaladdressfield=$("#physicaladdress")
    const telephonefield=$("#branchtelephone")
    const emailfield=$("#branchemail")
    const branchnotifications=$("#branchnotifications")
    const mapmodal=$("#maplocation")
    const customerbranchesmodal=$("#customerbranchesmodal")

    $.get(
        "controllers/useroperations.php",
        {
            getuserfirstname:true
        },
        (data)=>{
            firstnamefield.html(data)
        }
    )
    // listen to add branch coordinates
    addbranchlocationbutton.on("click",()=>{
        
        const errorCallback=(error)=>{
            console.error(error)
        }

        const successCallback=(position)=>{
            branchcoordinatesfield.val(`${position.coords.latitude}, ${position.coords.longitude}`)
        }

        navigator.geolocation.getCurrentPosition(successCallback,errorCallback,{setHighAccuracy:true})
    })

    // listen to search button click
    searchbutton.on("click",(e)=>{
        e.preventDefault()
        let customername=searchfield.val()
        $.getJSON(
            "controllers/customeroperations.php",
            {
                filtercustomers:true,
                customername
            },
            (data)=>{
                let results=""
                data.forEach((customer)=>{
                    let image=customer.image===null?"images/logo-placeholder.png":customer.image.substring(3)
                    results+=`
                    <div class="card">
                        <div class="card-bod">
                            <div class="d-flex justify-content-between mt-2">
                                <div class="logo">
                                    <img src=${image} alt="customer image" class="customer-logo">
                                    <div>
                                        <input type="file" name="changelogo" id="changelogo${customer.customerid}" accept="image/*" class="changelogo btn-secondary ml-2" data-id=${customer.customerid}>
                                    </div>
                                </div>

                                <div class="details">
                                    <h5>${customer.customername}</h5>
                                    <div><i class="fas fa-map-marker-alt fa-lg physicaladdress" data-longitude=${customer.long} data-latitude=${customer.lat} data-customername='${customer.customername}'></i> <small>${customer.physicaladdress}</small> </div>
                                    <div><small>P.O Box ${customer.postaladdress} ${customer.postalcode} ${customer.town}</small></div>
                                    <div><small>Tel: ${customer.telephone}</small></div>
                                    <div><small>Email: ${customer.email}</small></div>
                                    <div><small>Tags: ${customer.tags}</small></div>
                                    <button class="btn btn-sm btn-success mt-2 mb-2 edit"  data-id='${customer.customerid}'><i class="fas fa-pen fa-lg"></i> Edit</button>
                                </div>

                                <div class="branches mr-2">
                                    <div>
                                        Branches: ${customer.branches}
                                    </div>
                                    <button class="btn btn-sm mt-2 btn-success addbranch" data-id="${customer.customerid}" data-customername='${customer.customername}'><i class="fas fa-plus-circle fa-lg"></i></button>
                                    <button class='btn btn-sm mt-2 btn-secondary showallbranches' data-customerid=${customer.customerid} data-customername="${customer.customername}" data-longitude=${customer.long} data-latitude=${customer.lat}><i class="fas fa-map-marker-alt fa-lg"></i> Show All Branches</button>
                                </div>
                            </div>
                        </div>
                    </div>`
                })
                searchresults.html(results)
            }
        )

        // listen to edit customer button
        searchresults.on("click",".edit",function(){
            // console.log($(this).attr("data-id"))
            const url=`customerregistration.html#${$(this).attr("data-id")}`
            location.assign(url)
        })

        searchresults.on("change",".changelogo",function(){
           
            const id=$(this).attr("data-id")
            console.log(id)
            let fd= new FormData(),
                files=$(`#changelogo${id}`)[0].files[0]
             // check if a file was provided
             if(typeof files === 'undefined'){
                // output an error message
             }else{ 
                fd.append('changecustomerlogo',true)
                fd.append('customerid',id)
                fd.append('file',files)
                $.ajax({
                    url:"controllers/customeroperations.php",
                    data:fd,
                    type:"post",
                    contentType:false,
                    processData:false,
                    success: (data)=>{
                        data=$.trim(data)
                        let notification=''
                        if(data=="success"){
                            notification=`<div class='alert alert-success'>
                                    <i class='fas fa-check-circle fa-lg'> </i> 
                                    The logo has been changed successfully
                                </div>`
                                notifications.html(notification)
                                searchbutton.trigger("click")
                        }else if(data=="failed"){
                            notification=`<div class='alert alert-info'>
                                    <i class='fas fa-info-circle fa-lg'> </i> 
                                    The logo has not been updated. Kindly try again
                                </div>`
                            notifications.html(notification)
                        }else{
                            notification=`<div class='alert alert-danger'>
                                    <i class='fas fa-exclamation-triangle fa-lg'> </i> 
                                    An error occured. ${data}
                                </div>`
                            notifications.html(notification)
                        }
                    }
                })
             }


        })
    })

    // delegate event for adding a new customer branch
    searchresults.on("click",".addbranch",function(){
        addcustomerbranchbutton=$(this)
        customerid=addcustomerbranchbutton.attr("data-id")
        customername=addcustomerbranchbutton.attr("data-customername")
         // show the modal
         branchmodal.modal("show")
         // add the customername
         branchcustomername.html(customername)
        // add the customerid
        branchcustomeridfield.val(customerid)
    })

    // listen to save branch button
    savebranchbutton.on("click",()=>{
        let branchname= branchnamefield.val(),
            physicaladdress=physicaladdressfield.val(),
            telephone=telephonefield.val(),
            email=emailfield.val(),
            coordinates=branchcoordinatesfield.val().split(","),
            lat=coordinates[0],
            lon=coordinates[1],
            branchid=branchidfield.val(),
            customerid=branchcustomeridfield.val()

        $.post(
            "controllers/customeroperations.php",
            {
                savecustomerbranch:true,
                branchid,
                customerid,
                branchname,
                physicaladdress,
                lat,
                lon,
                telephone,
                email
            },
            (data)=>{
                data=$.trim(data)
                let notification=""
                if(data=="success"){
                    notification=`<div class='alert alert-success'>
                            <i class='fas fa-check-circle fa-lg'></i> 
                            The Branch was added successfully
                        </div>`
                        branchnotifications.html(notification)
                }else{
                    notification=`<div class='alert alert-danger'>
                        <i class='fas fa-exclamation-circle fa-lg'></i> 
                        Sorry an error occured ${data}
                    </div>`
                    branchnotifications.html(notification)
                }
            }
        )
    })


    // listen to click of Location icon
    searchresults.on("click",".physicaladdress",function(){
        const customerlocation=[],
            $this=$(this)
            customerlocation.push($this.attr("data-latitude"),$this.attr("data-longitude"))
            customername=$this.attr('data-customername')
            userslocation=[]
        mapmodal.modal("show")  

        mapmodal.on('shown.bs.modal', function(){
            // delay all these by half a second
            setTimeout(function(){
                // get the users location
                if(location.geolocation){
                    location.geolocation.getCurrentPosition(showPosition,showError)
                }
                // delete the map
                $("#map").remove() 
                // add the map
                mapmodal.find(".modal-body").html(`<div id="map" style="height:380px; width:100%"></div>`)
                            
                // show the map
                let mymap=L.map('map').setView(customerlocation, 13)
                
                // the tile 
                googleStreets = L.tileLayer('http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',{
                    maxZoom: 20,
                    subdomains:['mt0','mt1','mt2','mt3']
                }).addTo(mymap)
                // add a marker
                let marker = L.marker(customerlocation).addTo(mymap)
                // bing a popup to the marker to show me the location 
                marker.bindPopup(`${customername}`).openPopup() 

            },500)
        })
      
        function showPosition(position){
            userslocation.push(position.coords.latitude,position.coords.longitude)   
            // add users location popup
            let usermarker=L.marker(userslocation).addTo(mymap)
            usermarker.bindPopup(`Your Location`).openPopup()                     
        }
    
        function showError(error){
            console.log(`Could not retrieve location: ${error}`)
        }
    })

    searchresults.on("click",".showallbranches",function(){
        const $this=$(this),
            customerid=$this.attr("data-customerid"),
            customername=$this.attr("data-customername")
            // This is the head office
            customerlocation=[$this.attr("data-longitude"),$this.attr("data-latitude")]
            customerbranchesmodal.modal("show")
            
            customerbranchesmodal.on('shown.bs.modal', function(){
            setTimeout(function(){
                // show customer name on the modal heading
                customerbranchesmodal.find(".modal-title").html(`${customername} Branches`)
                // remove the map
                $("#branchesmap").remove()
                // add the map div
                customerbranchesmodal.find(".modal-body").html(`<div id="branchesmap" style="height:360px; width:100%"></div>`)
                // add map itself
                let mymap=L.map('branchesmap').setView(customerlocation, 13)   
                // add the tile 
                googleStreets = L.tileLayer('http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',{
                    maxZoom: 20,
                    subdomains:['mt0','mt1','mt2','mt3']
                }).addTo(mymap)

                
                $.getJSON(
                    "controllers/customeroperations.php",
                    {
                        getcustomerbranches:true,
                        customerid
                    },
                    (data)=>{
                        data.forEach((branch)=>{
                            // show all the branches on the map
                            // add markers
                            let marker = L.marker([branch.lat,branch.long]).addTo(mymap) 
                            // bind pop up for the markers
                            // bing a popup to the marker to show me the location 
                            marker.bindPopup(`${branch.branch}`).openPopup() 
                        })
                    }
                )
            },500)
        })
    })

    
})