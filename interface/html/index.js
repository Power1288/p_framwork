$(function (){
    window.addEventListener("message",(event) => {
        let data = event.data
        if(data.type === "setMoney") {
            let valMoney = document.querySelector(".info-bank")
            valMoney.innerHTML = data.value + "$"
        }else if(data.type === "setBank"){
            let valBank = document.querySelector(".info-liq")
            valBank.innerHTML = data.value + "$"
        }
    })
})