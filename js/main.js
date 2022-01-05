$(document).ready(function(){
    let firstnamefield=$("#firstname")

    $.get(
        "controllers/useroperations.php",
        {
            getuserfirstname:true
        },
        (data)=>{
            firstnamefield.html(data)
        }
    )
})