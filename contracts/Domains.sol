pragma solidity ^0.8.10;

import "hardhat/console.sol";


contract Domains {

    mapping(string => address) public domains;
    
    constructor(){
        console.log("ens domain contract created");
    }

    function addDomain(string calldata domain) public {
        require(domains[domain] == address(0), "domain already registered");
        domains[domain] = msg.sender;

    }

    function getOwner(string calldata domain) public view returns(address) {
        return domains[domain];
    }
}