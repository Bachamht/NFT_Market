// • 组合使用 Multicall (delegateCall) 、 默克尔树、erc20 permit 授权, 实现一个默克尔树优
// 惠价格(100 Token)购买名单, 使用 Multicall. 调用 2 个方法:

// • 合约: AirdopMerkleNFTMarket:

// • permitPrePay : 完成预授权

// • claimNFT( ) : 验证白名单,如果通过,直接使用 permitPrePay 的授权,转入 100
// token, 并转出 NFT


// SPDX-License-Identifier: GPL-3.0


pragma solidity ^0.8.0;
import {NFTMarket} from "../src/NFTMarket.sol";

interface IERC20permit {
        function permit( address owner, address spender, uint256 value, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external;
}

contract AirdopMerkleNFTMarket is NFTMarket{
    
    bytes32 public rootHash;
    mapping (address => bool) whitelist;

    error NotInWhitelist(address msgSender);

    /**
     * set Merkle tree root hash
     */
    function setRootHash(bytes32 _rootHash) OnlyMarketOwner {
        rootHash = _rootHash;
    }

    /**
     * approve tokens to the market by signature
     */
    function permitPrepay(address owner, address spender, uint256 deadline, bytes memory signature) public {
        require(_signature.length == 65, "invalid signature length");
        (bytes32 r, bytes32 s, uint8 v) = decondeSignature(signature);
        uint value = 100;
        IERC20permit(tokenPool).permit(owner, spender, value, deadline, v, r, s);
    }

    /**
     * Verify whitelisting and purchase NFT
     */
    function claimNFT(bytes32[] memory proof, uint256 tokenID) public {
        if (claimWhitelist(proof, msg.sender) == false) revert NotInWhitelist(msg.sender);
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