const { ethers } = require("ethers");

const domain = {
    name: "EIP712Storage",
    version: "1",
    chainId: "1",
    verifyingContract: "0xf8e81D47203A594245E36C48e151709F0C19fBe8",
};

const types = {
    BuyNFT: [
        { name: "tokenID", type: "uint256" },
        { name: "buyer", type: "address"}
    ],
};

const message = {
    tokenID: "1",
    buyer: "0x8FD116DaF3A17Fc2e8D10579EDB19c788Bb93A64",
};


const provider = new ethers.BrowserProvider(window.ethereum)
const signer = provider.getSigner()
const signature = await signer.signTypedData(domain, types, message);
console.log(signature)