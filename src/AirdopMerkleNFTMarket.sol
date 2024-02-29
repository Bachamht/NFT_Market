// SPDX-License-Identifier: GPL-3.0


pragma solidity ^0.8.0;
import {NFTMarket} from "../src/NFTMarket.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";
import {MerkleProof} from "lib/openzeppelin-contracts/contracts/utils/cryptography/MerkleProof.sol";

interface IERC20permit {
        function permit( address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external;
}

interface IERC721 {
        function transferFrom(address from, address to, uint256 tokenId) external;
        function ownerOf(uint256 tokenId) external returns(address);
        function approve(address to, uint256 tokenId) external;
}

contract AirdopMerkleNFTMarket is NFTMarket{

    using SafeERC20 for IERC20;
    bytes32 public rootHash;
    mapping (address => bool) whitelist;

    constructor () {
        
    }

    error NotInWhitelist(address msgSender);

    /**
     * set Merkle tree root hash
     */
    function setRootHash(bytes32 _rootHash) public OnlyMarketOwner {
        rootHash = _rootHash;
    }

    /**
     * approve tokens to the market by signature
     */
    function permitPrepay(address owner, address spender, uint256 deadline, bytes memory signature) public {
        require(signature.length == 65, "invalid signature length");
        (bytes32 r, bytes32 s, uint8 v) = decondeSignature(signature);
        uint value = 100;
        IERC20permit(tokenPool).permit(owner, spender, value, deadline, v, r, s);
    }

    /**
     * Verify whitelisting and purchase NFT
     */
    function claimNFT(bytes32[] memory proof, uint256 tokenID, uint256 amount) public {
        if (claimWhitelist(proof, bytes32(uint256(uint160(msg.sender)))) == false) revert NotInWhitelist(msg.sender);
        address seller = IERC721(nftAddr).ownerOf(tokenID);
        IERC20(tokenPool).safeTransferFrom(msg.sender, seller, amount);
        IERC721(nftAddr).transferFrom(seller, msg.sender, tokenID) ;
    }

    /**
     * claim the address
     */
    function claimWhitelist(bytes32[] memory proof, bytes32 leaf) internal returns(bool){
        return MerkleProof.verify(proof, rootHash, leaf);
    }


}