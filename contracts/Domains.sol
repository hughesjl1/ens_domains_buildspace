pragma solidity ^0.8.10;

import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Domain is ERC721URIStorage {

    mapping(string => address) public domains;

    mapping(string => uint) private domainCount;

    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;
    
    constructor() ERC721("DOMAIN_ENS", "ENS"){
        console.log("ens domain contract created");
    }

    function price(string memory _domain) public pure returns(uint){
        uint  _domain_length = bytes(_domain).length;
    
        if (_domain_length < 3) {
            return 0.5*10*18;
        } else if (_domain_length <6) {
            return 0.2*10*18;
        } else {
            return 0.1*10*18;
        }
    }



    function addDomain(string memory domain) payable public {
        require(domains[domain] == address(0), "domain already registered");

        uint domain_price = price(domain);

        require(msg.value > domain_price, "domain price is higher than the amount of ETH sent");

        string memory pre_svg = "<svg>";
        string memory post_svg = "</svg";

        string memory combinedSvg = string(abi.encodePacked(pre_svg, domain, post_svg));

        string memory jsonStringify = string(abi.encodePacked('{"name": "',
            combinedSvg, 
            '"',
             '}'
        ));

        /**
        @dev Create a NFT for the token
        */

        _tokenIds.increment();
        uint tokenId = _tokenIds.current();
        domainCount[domain] = tokenId; 

        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, jsonStringify);


        domains[domain] = msg.sender;

    }

    function getOwner(string calldata domain) public view returns(address) {
        return domains[domain];
    }
}