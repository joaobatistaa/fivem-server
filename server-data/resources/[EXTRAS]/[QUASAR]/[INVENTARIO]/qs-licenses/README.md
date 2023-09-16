Example to use a custom trigger
```lua  
local data = {
        label = 'License Example', ---@param Label on inventory
        type = 'weapon', ---@param Licence type
        name = 'id_card', ---@param Item name
        price = 10, --- @param Price of licencie
    }
    TriggerEvent('qs-licenses:client:Target', data) 
```   

Item for inventory 
```js
elseif (itemData.name == "id_card") {
    var gender = "Man";
    if (itemData.info.gender == 1) {
        gender = "Woman";
    }
    $(".item-info-title").html("<p>" + itemData.info.label + "</p>");
    $(".item-info-description").html(
        "<p><strong>First Name: </strong><span>" +
        itemData.info.firstname +
        "</span></p><p><strong>Last Name: </strong><span>" +
        itemData.info.lastname +
        "</span></p><p><strong>Birth Date: </strong><span>" +
        itemData.info.birthdate +
        "</span></p><p><strong>Type </strong><span>" +
        itemData.info.type +
        "</span></p><p><strong>Gender: </strong><span>" +
        gender +
        "</span></p>"
    );
}
```