// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// A fund me contract. This contract allows users to send funds and only the owner 
// can withdraw the funds and use it to buy stuffs

contract FundMe {

    // Constructor to run on deploy of contract
    address owner;
    constructor(){
        // The owner variable will take the address of the contract that deployed the contract
        owner = msg.sender; // The owner 
    }

    // Mapping to store the address of user funding and the value sum
    mapping(address => uint256) public addressToAmountfunded;

    // Array to store all addresses making the fund
    address[] public funders;

    // Fund function.
    function fund() public payable {
        // Make sure the funding amount is greater than 50dollars
        uint256 exAmount = 50 * 10**18; // convert to wei
        require(getConversionRate(msg.value)>=exAmount, "You need more Eth or wei > 50USD"); // what is expected else run an error
        addressToAmountfunded[msg.sender] += msg.value; 
        funders.push(msg.sender); // append the address of the funders
    }

    // Get Version of interface
    function getVersion() public view returns (uint256){
        AggregatorV3Interface pricefeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return uint256(pricefeed.version());
    }

    // Function to getLatestPrice of eth -> USD
    function getPrice() public view returns(uint256){
        // Contract that performs the gives the latest price of eth to USD from chainlink
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        // Deconstruct the latest price from return
        (,int256 price,,,) = priceFeed.latestRoundData();
        // convert the price to uint256 and make it 18 decimal place since gwei is 18 decimal
        return uint256(price * 10**8);
    }

    // Function to perform conversion rate
    function getConversionRate(uint256 amount) public view returns(uint256){
        uint256 ethPrice = getPrice();
        uint256 value = (amount * ethPrice) / 10**10*10**8;
        return (value);
    }

    // Modifier to make sure we are the owner to call the function
    modifier theOwner{
        // We run the require to make sure the owner is us
        require(msg.sender == owner, "You are not the owner of contract");
        _;
    }

    // Withdraw function to collect all funded money
    function withdraw() public payable theOwner {
        // Send the balance of the contract to the msg.sender or the address calling the function
        payable(msg.sender).transfer(address(this).balance);
        for(uint i=0; i<funders.length;i++){
            //selecting the address from our list
            address funder = funders[i]; 
            // resetting the value from the mapping to 0
            addressToAmountfunded[funder] = 0;
        }
        // Clear all funders address from the array by making a new address array
        funders = new address[](0);
    }

}