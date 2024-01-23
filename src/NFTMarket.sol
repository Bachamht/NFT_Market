// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";


interface IERC721 {
        function transferFrom(address from, address to, uint256 tokenId) external;
        function ownerOf(uint256 tokenId) external returns(address);
        function approve(address to, uint256 tokenId) external;

}

contract NFTMarket {

    using SafeERC20 for IERC20;

    event BuySuccess(address buyer, uint tokenID);
    event ListSuccess(uint256 tokenID, uint256 amount);

    error MoneyNotEnough(uint amount);
    error NotOwner(address msgSender, uint tokenID);
    error NotSelling(uint256 tokenID);

    mapping(uint256 => uint256) price;
    mapping(uint256 => bool) isListed;

    address private nftAddr;
    address private tokenPool; 

    constructor(address NftAddr, address TokenPool) {
        nftAddr = NftAddr;
        tokenPool = TokenPool;
    }

    modifier NotEnough(uint256 amount, uint256 tokenID) {
        if (amount < price[tokenID]) revert MoneyNotEnough(amount);
        _;
    }

    modifier OnlyOwner(uint256 tokenID){
        address nftOwner = IERC721(nftAddr).ownerOf(tokenID);
        if (msg.sender != nftOwner) revert NotOwner(msg.sender, tokenID);
        _;
    }

    //判断该nft是否在售
    modifier isOnSelling(bytes memory data){
        uint256 tokenID = bytesToUint(data);
        if (isListed[tokenID] == false) revert NotSelling(tokenID);
        _;
    }

    modifier isOnSelling2(uint tokenID){
        if (isListed[tokenID] == false) revert NotSelling(tokenID);
        _;
    }

    //用户上架出售nft
    function sellNFTs(uint256 tokenID, uint256 amount) public OnlyOwner(tokenID) {
        IERC721(nftAddr).approve(address(this), tokenID);
        price[tokenID] = amount;
        isListed[tokenID] = true;
        emit ListSuccess(tokenID, amount);

    }
    
    //用户下架nft
    function removeNFT(uint tokenID) public OnlyOwner(tokenID) {
        isListed[tokenID] = false;
    }

    //用户买nft
    function buyNFT(uint256 tokenID, uint256 amount) public isOnSelling2(tokenID) NotEnough(amount, tokenID) {
       
        address seller = IERC721(nftAddr).ownerOf(tokenID);
        IERC20(tokenPool).safeTransferFrom(msg.sender, seller, amount);
        IERC721(nftAddr).transferFrom(seller, msg.sender, tokenID) ;
        emit BuySuccess(msg.sender, tokenID);

    }

    //买家查看nft价格
    function viewPrice(uint256 tokenID) public view returns(uint256){
        return price[tokenID];
    }


    //用户查询nft的主人
    function viewOwner(uint256 tokenID) public returns(address) {
        return IERC721(nftAddr).ownerOf(tokenID);
    }

    //对用户直接转进地址的代币进行处理
    function tokensRecieved(address from, address to, uint amount, bytes memory data) external isOnSelling(data) {
            
            uint256 tokenID = bytesToUint(data);
            address seller = IERC721(nftAddr).ownerOf(tokenID);
            IERC721(nftAddr).transferFrom(seller, from, tokenID);
            IERC20(tokenPool).transfer(seller, amount);
            emit BuySuccess(msg.sender, tokenID);
        }
    
    //bytes to uint256
    function bytesToUint(bytes memory b) internal returns (uint256){
        uint256 number;
        for(uint i= 0; i<b.length; i++){
            number = number + uint8(b[i])*(2**(8*(b.length-(i+1))));
        }
        return  number;
    }
}
