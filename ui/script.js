window.addEventListener("message", (event) => {
    if (event.data.action === "showmenu") {
        let visable = event.data.show
        let Table = event.data.table
        if (Table) {
            $(".text-1big").text(`Players : ${Table.PlayerCount} / 48`)
            $("#Coords-Vector").text(Table.PlayerCoords)
        }
        if (visable) {
            $(".base").fadeIn();
        } else {
            $(".base").fadeOut();
        }
    }
    if (event.data.action === "copytext") {
        let coords = event.data.coords
        if (coords) {
            copyToClipboard(coords);
        }
    }
})
document.onkeyup = function(data){
 if (data.which == 27){
   $.post(`https://${GetParentResourceName()}/NUIFocusOff`, JSON.stringify({}));
 }
}
$(".close").click(function() {
 $.post(`https://${GetParentResourceName()}/NUIFocusOff`, JSON.stringify({}));
})

$("#EnShCo").click(function() {
    $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({what: "EnShCo"}));
})

$("#CoToCl").click(function() {
    $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({what: "CoToCl"}));
})

$("#SeToDi").click(function() {
    $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({what: "SeToDi"}));
})

$("#Teleport").click(function() {
    $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({what: "Teleport"}));
})

$("#SpawnVehicle").click(function() {
    $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({what: "SpawnVehicle"}));
})

$("#onoffduty").click(function() {
    $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({what: "onoffduty"}));
})

$("#Invisible").click(function() {
    $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({what: "Invisible"}));
})

$("#DvCar").click(function() {
    $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({what: "DvCar"}));
})


const copyToClipboard = str => {
    const el = document.createElement('textarea');
    el.value = str;
    document.body.appendChild(el);
    el.select();
    document.execCommand('copy');
    document.body.removeChild(el);
 };