import { MerkleTree } from "merkletreejs";
import keccak256 from "keccak256";
import { newContract,ChainId, multicallClient } from "@chainstarter/multicall-client.js";

const WhiteList = [
  "",
  "",
  "",
  "",
  ""
]

const leaves = WhiteList.map((x) => keccak256(x));
const merkleTree = new MerkleTree(leaves, keccak256);
const rootHash = merkleTree.getRoot().toString("hex");

const leaf = keccak256(inputAccount);
const proof = merkleTree.getProof(leaf);
//前端校验
const isWhiteList = merkleTree.verify(proof, leaf, rootHash)

// 合约校验
// 在此之前，需要调用setRootHash，将rootHash存入合约
const leaf32 = `0x${leaf.toString("hex")}`;
const proof32 = proof.map((x) => "0x" + x.data.toString("hex"));
const contract = newContract(
  MerkleTreeAbi,
  MerkleTreeAddress,
  ChainId.RINKEBY
);
multicallClient([
  contract.claimable(proof32, leaf32),
  contract.rootHash(),
]).then((res) => {
  console.log("是否存在白名单", res[0].returnData);
  console.log("合约rootHash", res[1].returnData);
  setIsWhiteList(!!res[0].returnData);
});

