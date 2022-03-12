// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Import the simple storage contract
import "./SimpleStorage.sol";

// Contract that deploys and interact with the simpleStorage contract
contract SimpleStorageFactory{

    SimpleStorage[] public sTFArray;
    
    // Function that creates a simple storage contract
    function createSimpleStorageContract() public {
        // create a simple storage contract
        SimpleStorage simpleStorage = new SimpleStorage(); // create an instance of the class
        sTFArray.push(simpleStorage); // the instance returns the address of each contract
    }

    // function to store my favorite number
    function sTFStore(uint256 contractIndex, uint256 favNumber) public {
        SimpleStorage simplestorage = SimpleStorage(address(sTFArray[contractIndex]));
        simplestorage.store(favNumber);
    }

    // Function to retrive the stored integer
    function sTFRetrieve(uint256 contractIndex) public view returns(uint256){
        return SimpleStorage(address(sTFArray[contractIndex])).retrieve();
    }


}