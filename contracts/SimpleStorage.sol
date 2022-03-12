// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SimpleStorage {
    //state variable
    uint256 favNumber; // variable declaration


    // Struct or collection of variables
    struct Person {
        uint256 favouriteNumber; // variable declaration
        string name; // variable declaration
    }
    Person public person1 = Person({favouriteNumber:300,name:"Chidalu"});

    // Array or list storage
    // The datatype of the array will be that of the variable of the structstruct
    Person[] public data1;

    // Creating a mapping
    mapping(string => uint256) public data2;

    // Function to store favourite number
    function store(uint256 _favouriteNumber) public {
        favNumber = _favouriteNumber;
    }

    // Function to retrieve the favourite number
    function retrieve() public view returns(uint256){
        return favNumber;
    }

    // Function to store the users information
    function addPerson(uint favnum, string memory name) public {
        data1.push(Person({favouriteNumber:favnum,name:name}));
        data2[name] = favnum;
    }

}