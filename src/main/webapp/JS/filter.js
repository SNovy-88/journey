function filter() {
    const fitness = document.getElementById("fitness")
    const stamina = document.getElementById("stamina")
    const experience = document.getElementById("experience")
    const scenery = document.getElementById("scenery")
    const months = document.querySelectorAll(".month")
    let monthBits = 0;


    months.forEach((month)=>{
        if(month.checked) {
            monthBits += parseInt(month.value);

        }
    })

    const currentUrl = window.location.href;
    window.location.href = currentUrl.split("&")[0] + `&fitness=${fitness.value}&stamina=${stamina.value}&experience=${experience.value}&scenery=${scenery.value}&months=${monthBits}`
    //console.log(monthBits);
}
