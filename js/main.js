$(document).ready(function(){
    let firstnamefield=$("#firstname")
    const searchbutton=$("#searchbutton")
    const searchfield=$("#searchtext")
    const searchresults=$("#searchresults")

    $.get(
        "controllers/useroperations.php",
        {
            getuserfirstname:true
        },
        (data)=>{
            firstnamefield.html(data)
        }
    )

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
                    results+=`
                    <div class="card">
                        <div class="card-bod">
                            <div class="d-flex justify-content-between mt-2">
                                <div class="logo">
                                    <img src="images/logo-placeholder.png" alt="" class="customer-logo">
                                    <div>
                                        <input type="file" name="changelogo" id="changelogo" accept="image/*" class="btn-secondary ml-2">
                                    </div>
                                </div>

                                <div class="details">
                                    <h5>${customer.customername}</h5>
                                    <div><small>${customer.physicaladdress}</small> </div>
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
                                    <button class="btn btn-sm mt-2 btn-success" id="edit"><i class="fas fa-plus-circle fa-lg"></i></button>
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
    })
})