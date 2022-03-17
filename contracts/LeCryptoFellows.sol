// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract LeCryptoFellows is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    address public brawlHost;
    Counters.Counter private _tokenIdCounter;

    mapping(address => uint) fellows;
    mapping(uint => uint) fellowBalances;


    constructor() ERC721("LeCryptoFellows", "LCF") {
        // start id:s at 1, helps with other math.
    }

    
    function initializeFellow(address to, string memory uri) public {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        fellows[to] = tokenId;
    }


    function depositGamblingDebts() payable public {
        uint id = fellows[msg.sender];

        fellowBalances[id] = msg.value;
    }

    function withdrawFunds() public {
        uint id = fellows[msg.sender];

        uint amount = fellowBalances[id];

        payable(msg.sender).transfer(amount);
    }


    function brawl(uint randomNumberOne, uint randomNumberTwo) public onlyAuthorized returns (uint winner, uint loser) {
        uint theChosenOne = randomNumberOne % 40;
        uint theUnfortunateOne = randomNumberTwo % 40;

        // had lots of if elses here, this will throw error in certain edge cases
        // , for example, same winner & loser. but that's to fix for another time.

        fellowBalances[theChosenOne] += fellowBalances[theUnfortunateOne];
        fellowBalances[theUnfortunateOne] = 0;
        // sorry :(
        return (theChosenOne, theUnfortunateOne);
    }    
    
    modifier onlyAuthorized() {
        require(msg.sender == brawlHost, "this has to be called by a specific contract, sorry");
        _;
    }

    function setBrawlHost(address bh) public onlyOwner {
        brawlHost = bh;
    }
    
    
    // The following functions are overrides required by Solidity.
    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}
