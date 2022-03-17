// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyToken is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    address public randomnessHost;
    Counters.Counter private _tokenIdCounter;

    mapping(address => uint) fellows;
    mapping(uint => uint) fellowBalances;


    constructor() ERC721("MyToken", "MTK") {}

    
    function initializeFellow(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        fellows[to] = tokenId;
    }


    function depositGamblingDebts() payable external {
        uint id = fellows[msg.sender];

        fellowBalances[id] = msg.value;
    }


    function brawl(uint randomNumberYay) public onlyAuthorized returns(uint winner, uint loser) {
        uint theChosenOne = randomNumberYay % 40;
        uint theUnfortunateOne;

        if (theChosenOne > 1 && theChosenOne < 40) {
            theUnfortunateOne = theChosenOne - 1;
        } else if (theChosenOne == 1) {
            theUnfortunateOne = 2;
        } else if (theChosenOne == 40) {
            theUnfortunateOne = 39;
        }

        fellowBalances[theChosenOne] += fellowBalances[theUnfortunateOne];
        fellowBalances[theUnfortunateOne] = 0;
        // sorry :(
        return (theChosenOne, theUnfortunateOne);
    }    
    
    modifier onlyAuthorized() {
        require(msg.sender == randomnessHost, "this has to be called by a specific contract, sorry");
        _;
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
