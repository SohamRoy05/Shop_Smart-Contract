// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Shop{

    address payable public owner;
    constructor() {
        owner=payable(msg.sender);
    }

    event notify(address itemadder, uint itemid, string itemname);

    struct Item{
        uint item_id;
        string item_name;
        uint item_cost;
    }

    Item[] public item;
    
    mapping(uint=>uint) public item_cost;
    mapping(uint=>uint) public item_count;

    function addItem(uint _itemid, string memory _itemname, uint _itemcount ,uint _itemcost) public{  //Adds items to the item list
        
        require(msg.sender==owner, "You are not the owner.");
        
        item.push(Item(_itemid, _itemname, _itemcost));
        item_cost[_itemid]=_itemcost;
        item_count[_itemid]=_itemcount;
        
        emit notify(msg.sender, _itemid, _itemname);
    
    }

    function checkItem(uint _itemid) public view returns(uint,uint){            //This function is for testing purpose
        
        return (item_cost[_itemid] , item_count[_itemid]);
    }
    
    modifier amount_cost(uint _itemid, uint _buycount) {
        require(_buycount > 0,"Amount of item must be greater than 0");
        require(_buycount < item_count[_itemid],"This amount of item is not available");

        uint itemcost=item_cost[_itemid];
        require(msg.value==(_buycount*itemcost) , "Please check the amount you are transferring");
        
        _;
     
   }

    function buyItem(uint _itemid, uint _buycount) payable external amount_cost(_itemid,  _buycount){  //Buy items by supplying ID and count 
        
        owner.transfer(msg.value);
        item_count[_itemid]-=_buycount;

    }

    
}