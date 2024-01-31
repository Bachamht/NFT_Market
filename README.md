## Deploy a transparent proxy with foundry

1. Firstly, run the script (script/upgradeMarket.s.sol)  to deploy:

```solidity
function run() public {
        
        Options memory opts;
        opts.unsafeSkipAllChecks = true;

        proxyAddress = Upgrades.deployTransparentProxy(
        "NFTMarket.sol",
        admin,
        abi.encodeCall(NFTMarket.initialize, 		(0x47f1d75fd1A6f9530efa50e2Ed0C61a2B236e9a2,0xfCEe1e76831076b395A4F22Fd884f63929523E0d)),
        opts
        );

        address adminAddress = Upgrades.getAdminAddress(proxyAddress);
        address implementationAddress = Upgrades.getImplementationAddress(proxyAddress);

        console.log("Market Proxy contract deployed on %s", address(proxyAddress));
        console.log("Market contract deployed on %s", address(implementationAddress));
        console.log("admin contract deployed on %s", address(adminAddress));       
    }
    
```



2. Execute in a terminal：

```shell
forge script --rpc-url https://eth-sepolia.api.onfinality.io/public	 ./script/upgradeMarket.s.sol --ffi --broadcast 
```



3. Then you get three addresses：

The address of the **proxy contract** is： **0xD659236296Dd08EDABB07c47295a68CC5871fce6**

The address of the **admin contract** is： **0xd1d32754Ef255647DCad2A97855D1AC2A0aBF773**

The address of the **implementation contract** is : **0x95871d75b415d06dbCEcE6959c21BDd15db17702**



4. Now perform an upgrade operation， run the script (script/upgradeMarket.s.sol)：

```solidity
  function upgradeContract() public { 
        Options memory opts;
        opts.unsafeSkipAllChecks = true;
        opts.referenceContract = "NFTMarket.sol";

        Upgrades.upgradeProxy(
            proxyAddress,
            "NFTMarketV1.sol",
            "",
            opts
        );

        address adminAddress = Upgrades.getAdminAddress(proxyAddress);
        address implementationAddress = Upgrades.getImplementationAddress(proxyAddress);

        console.log("Market Proxy contract deployed on %s", address(proxyAddress));
        console.log("Market contract deployed on %s", address(implementationAddress));
        console.log("admin contract deployed on %s", address(adminAddress));      
    }
```



5. Execute in a terminal：

```shell
forge script --rpc-url https://eth-sepolia.api.onfinality.io/public	  ./script/upgradeMarket.s.sol -s "upgradeContract()" --ffi --broadcast
```



6. Then you'll notice that your management address hasn't changed but the instance address has changed

The address of the **admin contract** is： **0xd1d32754Ef255647DCad2A97855D1AC2A0aBF773**

The address of the **implementation contract** is : **0x2A70Cea5B15da39451fcefe9bd6f1e64046fE202**
