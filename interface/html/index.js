$(function (){
    window.addEventListener("message",(event) => {
        let data = event.data
        if(data.type === "setMoney") {
            let valMoney = document.querySelector(".money")
            valMoney.innerHTML = data.value + "$"
        }else if(data.type === "setBank"){
            let valBank = document.querySelector(".moneliq")
            valBank.innerHTML = data.value + "$"
        }else if(data.type === "setJob"){
            let valJob = document.querySelector(".job-leg")
            valJob.innerHTML = data.value + "-" + data.grd
        }else if (data.type === "setGang") {
            let valGang = document.querySelector(".job-ill")
            valGang.innerHTML = data.value + "-" + data.grd
        }
    })
})