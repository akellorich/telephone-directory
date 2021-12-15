// let x=-1
// let y=-7
// let z=x+y
// console.log(x==4 || y==7)
// alert("The answer is: "+z)
// confirm("Are you sure you want to delete")Richard
// let name=prompt("Please enter your name")
// if(name!==""){
//     alert("Your name is: "+name)
// }else{
//     alert("Sorry you did not provide a name")
// }

// if(x>=0){
//     alert("The value of x is: "+x)
// }else if(y>=0){
//     alert("The value of y is: "+y)
// }else{
//     alert("No value value was provided")
// }

// if(x>=0 || y>=0){
//     alert("The value of x, y are "+x+","+y)
// }else{
//     alert("No value value was provided")
// }


// condition ? when true: when false

// alert(x>=0 || y>=0?"The value of x,y are "+x+","+y:"No value value was provided")
// let stream="F"
// let subjects=[]
// switch (stream) {
//     case "A":
//         subjects=['Math','Eng','Kis']
//         break;
//     case "B":
//         subjects=['Bio','Phy','Chem']
//         break;
//     case "C":
//         subjects=['Hist','Geo','CRE']
//         break;
//     default:
//         subjects=['Art','Business','Computer']
//         break;
// }

// console.log (subjects)

// let x=1

// // do {
// //    console.log("Printing copy"+ x) 
// //    x++
// //    var printanothercopy=confirm("Do you want to print another copy")
// // } while (
// //     // Do you want to print another copy
// //     printanothercopy==true
// // );
// // let printanothercopy=true

// // while (printanothercopy==true) {
// //     console.log("Printing copy"+ x) 
// //     x++
// //     printanothercopy=confirm("Do you want to print another copy")
// // }
// var furniture=['Tables','Chairs','Desks','Stools']

// // furniture.length
// // for(let i=0;i<furniture.length;i++){
// //     console.log(furniture[i])
// // }
// // for(let i=1;i<=100;i++){
// //     document.write(i+"<br>")
// // }
// // let table=`<table><thead><th>Studentno</th><th>Fullname</th></thead>`
// // table+=`<tbody>`
// // for(let i=0;i<students.length;i++){
// //     table+=`<tr><td>${students[i].studentno}</td>`
// //     table+=`<td>${students[i].fullname}</td></tr>`
// // }
// // table+=`</tbody>`
// // table+=`</table>`
// // console.log(table)
// // document.write(table)
// // let studentdropdown=document.querySelector("#student"), 
// let studentlist=''

// // for(let i=0;i<students.length;i++){
// //     studentlist+=`<option value=${students[i].studentno}>${students[i].fullname}</option>`
// // }
// // studentdropdown.innerHTML=studentlist
// let students=
//     [
//         {"studentno":"001","fullname":"richard akello"},
//         {"studentno":"002","fullname":"makena mercy"},
//         {"studentno":"003","fullname":"habil john"},
//         {"studentno":"004","fullname":"elizabeth mary"},
//     ]
// let studentstable=document.querySelector("#students")
// students.forEach(astudent=>{
//     studentlist+=`<tr><td>${astudent.studentno}</td><td>${astudent.fullname}</td></tr>`
// })
// // or 
// for(let i=0;i<students.length;i++){
//     studentlist+=`<tr><td>${students[i].studentno}</td><td>${students[i].fullname}</td></tr>`
// }
// studentstable.innerHTML=studentlist

// students.forEach(student => {
//     studentlist+=`<input type='checkbox' value=${student.studentno} />${student.studentno} - ${student.fullname} <br/>`
// });

let grossfield=document.getElementById("grosssalary"),
    computepayebutton=document.getElementById("computetaxes"),
    computedpayefield=document.getElementById("computedtax")
    clearbutton=document.getElementById("clear")

computepayebutton.addEventListener("click",()=>{
    let gross=grossfield.value
    // const paye=computetax(gross)
    if(Number(gross)>0){
        computedpayefield.innerHTML=computetax(gross)
    }else{
        alert("Please enter a valid number")
        grossfield.value=""
        grossfield.focus()
    }
})

clearbutton.addEventListener("click",()=>{
    grossfield.value=""
    computedpayefield.innerHTML="0.00"
})

grossfield.addEventListener("keydown",(e)=>{
    // check if a number key was pressed
    //Dont update the text field
    e.preventDefault()
    // if a number key was pressed
    let max=1500000
    if(e.which>=48 && e.which<=57){
        gross=Number(grossfield.value+String.fromCharCode(e.which))
        // if the value exceeds the set limit
        if(gross<=max){
            grossfield.value+=String.fromCharCode(e.which)
        }
    }
})

grossfield.addEventListener("keyup",(e)=>{
    e.preventDefault()
    console.log(e.which)
    if(e.which==8 || e.which==46){
        grossfield.value=""
    }
})



function computetax(gross, taxrate=0.3){
    let tax=taxrate*gross
    return tax
}

