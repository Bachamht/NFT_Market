// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


import "lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";
import {ECDSA} from "lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol";
import "lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol";
import "lib/openzeppelin-contracts-upgradeable/contracts/utils/cryptography/EIP712Upgradeable.sol";
import "./uniswapV2_core/interfaces/IUniswapV2Factory.sol";
import {UniswapV2Router02} from "./uniswapV2_periphery/UniswapV2Router02.sol";


interface IERC721 {
        function transferFrom(address from, address to, uint256 tokenId) external;
        function ownerOf(uint256 tokenId) external returns(address);
        function approve(address to, uint256 tokenId) external;
}

contract NFTMarket is OwnableUpgradeable {

    using SafeERC20 for IERC20;
    using ECDSA for bytes32;

    address public marketOwner;
    address public signer;
    address public nftAddr;
    address public tokenPool;
    address public weth;
    address public uniswapV2Factory;
    address public uniswapV2Router;

    bytes32 public constant BuyNFT_TYPEHASH = keccak256("BuyNFT(address buyer,uint256 tokenID)");
    bytes32 public constant BuyNFTWithSign_TYPEHASH = keccak256("BuyNFTDirectly(uint256 tokenID, uint price)");
    bytes32 public constant EIP712DOMAIN_TYPEHASH = keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)");
    bytes32 public DOMAIN_SEPARATOR;

    event BuySuccess(address buyer, uint tokenID);
    event ListSuccess(uint256 tokenID, uint256 amount);

    error MoneyNotEnough(uint amount);
    error NotOwner(address msgSender, uint tokenID);
    error NotSelling(uint256 tokenID);
    error NotMarketOwner(address sender);
    error NotTradingPairExist();
    error PaymentLimitExceeded();

    mapping(uint256 => uint256) price;
    mapping(uint256 => bool) isListed;

    modifier NotEnough(uint256 amount, uint256 tokenID) {
        if (amount < price[tokenID]) revert MoneyNotEnough(amount);
        _;
    }

    modifier OnlyOwner(uint256 tokenID){
        address nftOwner = IERC721(nftAddr).ownerOf(tokenID);
        if (msg.sender != nftOwner) revert NotOwner(msg.sender, tokenID);
        _;
    }

    modifier OnlyMarketOwner(){
        if (msg.sender != marketOwner) revert NotMarketOwner(msg.sender);
        _;
    }

    modifier isOnSelling(bytes memory data){
        uint256 tokenID = bytesToUint(data);
        if (isListed[tokenID] == false) revert NotSelling(tokenID);
        _;
    }

    modifier isOnSelling2(uint tokenID){
        if (isListed[tokenID] == false) revert NotSelling(tokenID);
        _;
    }
    
    
    // constructor(address NftAddr, address TokenPool, address WETH, address factory, address router) {
    //     nftAddr = NftAddr;
    //     tokenPool = TokenPool;
    //     signer = msg.sender;
    //     marketOwner = msg.sender;
    //     weth = WETH;
    //     uniswapV2Factory = factory;
    //     uniswapV2Router = router;
    //     DOMAIN_SEPARATOR = keccak256(abi.encode(
    //         EIP712DOMAIN_TYPEHASH, // type hash
    //         keccak256(bytes("EIP712Storage")), // name
    //         keccak256(bytes("1")), // version
    //         block.chainid, // chain id
    //         address(this) // contract address
    //     ));
    // }
    

    /**
     * initialize， Replacing Constructors.
     * Used when deploying upgradable contracts
     */

    
    function initialize(address NftAddr, address TokenPool, address WETH, address factory, address router) public initializer{
        nftAddr = NftAddr;
        tokenPool = TokenPool;
        signer = msg.sender;
        marketOwner = msg.sender;
        weth = WETH;
        uniswapV2Factory = factory;
        uniswapV2Router = router;
        DOMAIN_SEPARATOR = keccak256(abi.encode(
            EIP712DOMAIN_TYPEHASH, // type hash
            keccak256(bytes("EIP712Storage")), // name
            keccak256(bytes("1")), // version
            block.chainid, // chain id
            address(this) // contract address
        ));
    }
    

    /**
     * User lists nft for sale
     */
    function sellNFTs(uint256 tokenID, uint256 amount) public OnlyOwner(tokenID) {
        //IERC721(nftAddr).approve(address(this), tokenID);
        price[tokenID] = amount;
        isListed[tokenID] = true;
        emit ListSuccess(tokenID, amount);

    }
    
    /**
     * User removes nft
     */
    function removeNFT(uint tokenID) public OnlyOwner(tokenID) {
        isListed[tokenID] = false;
    }

    /**
     * User buy nft
     * The seller needs to approve the nft to the market 
     * The buyer needs to approve the tokens to the market
     */
    function buyNFT(uint256 tokenID, uint256 amount) public isOnSelling2(tokenID) NotEnough(amount, tokenID) {
       
        address seller = IERC721(nftAddr).ownerOf(tokenID);
        IERC20(tokenPool).safeTransferFrom(msg.sender, seller, amount);
        IERC721(nftAddr).transferFrom(seller, msg.sender, tokenID) ;
        emit BuySuccess(msg.sender, tokenID);

    }

    /**
     * View NFT's price
     */
    function viewPrice(uint256 tokenID) public view returns(uint256){
        return price[tokenID];
    }

    /**
     * View NFT's owner
     */
    function viewOwner(uint256 tokenID) public returns(address) {
        return IERC721(nftAddr).ownerOf(tokenID);
    }

    /**
     * A callback function corresponding to the tokenTransferWithCallback() function in the token contract
     * This is used for users to directly transfer tokens to purchase NFT, eliminating the need for users to approve tokens
     */
    function tokensRecieved(address from, address to, uint amount, bytes memory data) external isOnSelling(data) {
        uint256 tokenID = bytesToUint(data);
        address seller = IERC721(nftAddr).ownerOf(tokenID);
        IERC721(nftAddr).transferFrom(seller, from, tokenID);
        IERC20(tokenPool).transfer(seller, amount);
        emit BuySuccess(msg.sender, tokenID);
    }
    
    /**
     * whitelist mode
     * Only users with signatures issued by the project party can purchase the corresponding NFT
     */
    function WhitelistBuy(uint256 tokenID, uint amount, bytes memory _signature) public {
        require(permitWhitelist(tokenID, _signature), "No Permission");
         address seller = IERC721(nftAddr).ownerOf(tokenID);
         IERC20(tokenPool).safeTransferFrom(msg.sender, seller, amount);
         IERC721(nftAddr).transferFrom(seller, msg.sender, tokenID) ;
         emit BuySuccess(msg.sender, tokenID);
    }

    /**
     * Verify whitelist signature
     */
    function permitWhitelist(uint256 tokenID, bytes memory _signature) internal returns(bool) {
        require(_signature.length == 65, "invalid signature length");
        (bytes32 r, bytes32 s, uint8 v) = decondeSignature(_signature);
        bytes32 _msgHash = keccak256(abi.encodePacked(
            "\x19\x01",
            DOMAIN_SEPARATOR,
            keccak256(abi.encode(BuyNFT_TYPEHASH, msg.sender, tokenID))
        )); 
        
        return (signer == _msgHash.recover(v, r, s));

    }

   /**
     * Sellers do not need to list NFT
     * Buyers can directly purchase NFTs with the signature of the seller
     */
   function buyWithSignature(uint256 tokenID, uint amount, bytes memory _signature) public {
        require(permitSignature(tokenID, amount,  _signature), "No Permission");
        address seller = IERC721(nftAddr).ownerOf(tokenID);
        IERC20(tokenPool).safeTransferFrom(msg.sender, seller, amount);
        IERC721(nftAddr).transferFrom(seller, msg.sender, tokenID) ;
        emit BuySuccess(msg.sender, tokenID);
   }

   /**
     * If there is a trading pair between CG and the token paid by the user, the transaction will be conducted directly.
     *  Otherwise, the user's payment token will be converted into weth before the transaction.
     */
    function buyByERC20Token(address token, uint256 tokenId, uint256 amountsInMax, bool needWeth) public {
        uint256 nftPrice = price[tokenId];
        address seller = IERC721(nftAddr).ownerOf(tokenId);
        address [] memory path1;
        address [] memory path2;
        uint256 time = block.timestamp;
        if (needWeth == false) {
            path1[0] = token;
            path1[1] = tokenPool;
            UniswapV2Router02(payable(uniswapV2Router)).swapExactTokensForTokens(nftPrice, amountsInMax, path1, seller, time + 600); 

        } else {
            path2[0] = token;
            path2[0] = weth;
            path2[0] = tokenPool;
            UniswapV2Router02(payable(uniswapV2Router)).swapExactTokensForTokens(nftPrice, amountsInMax, path2, seller, time + 600); 
        }
        IERC721(nftAddr).transferFrom(seller, msg.sender, tokenId) ;
        emit BuySuccess(msg.sender, tokenId);
    }

  

   /**
     * Verify signature issued by seller
     */
    function permitSignature(uint256 tokenID, uint amount, bytes memory _signature) internal returns(bool) {
        require(_signature.length == 65, "invalid signature length");
        (bytes32 r, bytes32 s, uint8 v) = decondeSignature(_signature);
        bytes32 _msgHash = keccak256(abi.encodePacked(
            "\x19\x01",
            DOMAIN_SEPARATOR,
            keccak256(abi.encode(BuyNFTWithSign_TYPEHASH, msg.sender, tokenID))
        )); 
        
        address owner = viewOwner(tokenID);
        return ( owner == _msgHash.recover(v, r, s));

    }


   /**
     * Modify the owner by modifying the slot
     */
   function modifyOwner(address ownerChange) public OnlyMarketOwner{
        assembly{
            sstore(0, ownerChange)
        }
   }
    
    /**
     * decode signature
     */
    function decondeSignature(bytes memory _signature) internal returns(bytes32, bytes32, uint8) {

        bytes32 r;
        bytes32 s;
        uint8 v;
        assembly {
            r := mload(add(_signature, 0x20))
            s := mload(add(_signature, 0x40))
            v := byte(0, mload(add(_signature, 0x60)))
        }
        return (r, s, v);

    }

    /**
     * bytes to uint256
     */
    function bytesToUint(bytes memory b) internal returns (uint256){
        uint256 number;
        for(uint i= 0; i<b.length; i++){
            number = number + uint8(b[i])*(2**(8*(b.length-(i+1))));
        }
        return  number;
    }

    /**
     * Check if the trading pair exists
     */
     function checkPairExist(address tokenA, address tokenB) internal returns(bool) {

     }

}
