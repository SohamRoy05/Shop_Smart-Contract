const { assert } = require("console");

const Shop = artifacts.require('Shop.sol');

contract('ShopTest', () => {
    // before(async () => {
    //     let shop = await Shop.deployed();
    // });

    // it("Check Working of shop", async() => {
    //     await shop.addItem(122,"Burger", 2);
    // });

    it("Check Working of shop", async() => {
        let shop = await Shop.new();
        await shop.addItem(122,"Burger", 2);
        let cost = await shop.checkItem(122);
        assert(cost.toString()==='2');
        //await shop.owner.call();
        //let owner= await shop.owner.call();
        //let cost = await shop.item_cost.call(122);
        //assert(owner==="0x12065e11c3578513E5F76781cab24A08e53Db03A");

    });
});