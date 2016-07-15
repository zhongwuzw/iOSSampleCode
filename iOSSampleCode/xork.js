var map = [];
var currentRoom = 0;
var allowableActions = ["go"];

/* Inventory */

var inventory = {};

inventory.items = [];

inventory.addItem = function(item) {
    inventory.items.push(item);
}

inventory.contains = function(itemName) {
    for (var i = 0; i < inventory.items.length; i++) {
        var item = inventory.items[i];
        if (item.name == itemName) {
            return true;
        }
    }
    
    return false;
}

inventory.print = function() {
    
    if (inventory.items.length == 0)  {
        print("You have no items in your inventory.");
        return;
    }
    
    var string = "These are the items in your inventory: \n";
    
    for (var i = 0; i < inventory.items.length; i++) {
        var item = inventory.items[i];
        string = string + item["name"] + "\n";
    }
    
    print(string);
}

/* Item object */

function Item(name, description) {
    this.name = name;
    this.description = description;
}

/*  Room object */

function Room(name, description, adjacentRooms, items) {
    
    this.name = name;
    this.description = description;
    this.adjacentRooms = adjacentRooms;
    this.items = items;
    
    this.hasItem = function(name) {
        
        for (var i = 0; i < this.items.length; i++) {
            var roomItem = this.items[i];
            if (roomItem.name == name) {
                return true;
            }
        }
        
        return false;
    }
    
    this.addItem = function(item) {
        this.items.push(item);
    }
    
    this.removeItem = function(item) {
        index = this.items.indexOf(item);
        if (index == - 1) {
            return;
        }
        this.items.splice(index, 1);
    }
    
    this.itemForName = function(itemName) {
        for (var i = 0; i < this.items.length; i++) {
            var roomItem = this.items[i];
            if (roomItem.name == itemName) {
                return roomItem;
            }
        }
    }
}

function roomForName(name) {
    var index = 0;
    for (var i = 0; i < map.length; i++) {
        if (map[i].name == name) {
            index = i;
            break;
        }
    }
    
    return map[index];
}

function roomIndexForName(name) {
    var index = 0;
    for (var i = 0; i < map.length; i++) {
        if (map[i].name == name) {
            index = i;
            break;
        }
    }
    
    return index;
}

function startGame(data) {
    
    /* Parse game data from JSON file */
    
    var rooms = data;
    
    for (var i = 0; i < rooms.length; i++) {
        dict = rooms[i];
        room = new Room();
        room.name = dict["name"];
        room.description = dict["description"];
        room.adjacentRooms = dict["adjacentRooms"];
        
        room.items = [];
        
        roomItems = dict["items"];
        for (var j = 0; j < roomItems.length; j++) {
            itemDict = roomItems[j];
            item = new Item();
            item.name = itemDict["name"];
            item.description = itemDict["description"];
            room.items.push(item);
        }
        
        room.trigger = dict["trigger"];
        
        map.push(room);
    }
    
    room = getCurrentRoom();
    print(room.description);
}

function processUserInput(input) {
    
    print("> " + input);
    
    input = removeNewLines(input);
    tokens = input.split(" ");
    
    if (tokens.length == 1) {
        processAction(tokens[0]);
    }
    else if (tokens.length == 2) {
        processCommand(tokens[0], tokens[1]);
    }
    else {
        print("Enter your command as  [action] [object]");
    }
    
}


function processAction(action) {
    
    if (action == "inventory") {
        inventory.print();
    }
    else if (action == "help") {
        print("This is a simple maze exploration game.");
    }
    else if (action == "hint") {
        print(getCurrentRoom().description);
    }
    else if (action == "version") {
        print(getVersion());
    }
    else {
        print("You can't do that.");
    }
}

function processCommand(action, object) {
    
    trigger = getCurrentRoom().trigger;
    
    /* Check if the room has a trigger */
    
    if (trigger != undefined) {
        
        var shouldProceed = processTrigger(trigger, action, object);
        
        if (!shouldProceed) {
            return;
        }
    }
    
    if (action == "go") {
        go(object);
    }
    else if (action == "take") {
        take(object);
    }
    else {
        print("You can't do that.");
    }
    
}

function processTrigger(trigger, action, object) {
    
    var command = trigger["command"];
    
    /* Check condition if command matches */
    if (command["action"] != action ||
        command["object"] != object) {
        return true;
    }
    
    /* Condition: check if inventory contains item  */
    var condition = trigger["condition"];
    var itemName = condition["inventoryContains"];
    
    if (!inventory.contains(itemName)) {
        print(trigger["print"]);
        return false;
    }
    else {
        return true;
    }
}

/* Action functions */

function go(direction) {
    
    room = getCurrentRoom();
    adjacentRooms = room.adjacentRooms;
    
    if (direction in adjacentRooms) {
        /* Go to new room */
        roomName = adjacentRooms[direction];
        currentRoom = roomIndexForName(roomName);
        print(getCurrentRoom().description);
    }
    else {
        print("Can't go there!");
    }
    
}

function take(itemName) {
    //1
    var room = getCurrentRoom();
    
    //2
    if (room.hasItem(itemName)) {
        item = room.itemForName(itemName);
        inventory.addItem(item);
        room.removeItem(itemName);
        print("You picked it up. Woot!");
    }
    //3
    else {
        print("You can't pick that up.");
    }
}

/* Helper functions */

function getCurrentRoom() {
    return map[currentRoom];
}

function removeNewLines(s) {
    return s.replace("\n", "");
}

function saveGame() {
    presentNativeAlert("Hello","Do you want to save the game?",
                       saveGameConfirm,
                       saveGameCancel);
}

function saveGameConfirm() {
    print('Yes');
}

function saveGameCancel() {
    print('No');
}


