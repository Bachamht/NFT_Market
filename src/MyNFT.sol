// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MyNFT is ERC721URIStorage{

    address private administrator;
    uint256 private nounce;
    error NotAdministrator(address administrator);

    modifier onlyAdministrator{
        if (msg.sender !=  administrator) revert NotAdministrator(msg.sender);
        _;
    }

    constructor() ERC721("LuoZiYi", "LZY"){
        administrator = msg.sender;
    }
    
    //铸造nft
    function mint(address to, string memory tokenURI) public onlyAdministrator{
        uint256 tokenID = tokenId();
        _safeMint(to, tokenID);
        _setTokenURI(tokenID, tokenURI);
    }
    
    //tokenID 每次自增1
    function tokenId() internal returns (uint) {
        nounce = nounce + 1;
        return nounce;
    }
    



}
