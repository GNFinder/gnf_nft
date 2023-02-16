const main = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory('DigitalNoMadNFTV5');
  
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log("Success: We've Hacked the Ethereum Blockchain and Deployed the DigitalNoMadNFTV5 contract to: " + "\n", nftContract.address,"\n");
  
    let txn = await nftContract.makeADigitalNomadNFT()
    await txn.wait()
  
    txn = await nftContract.makeADigitalNomadNFT()
    await txn.wait()

    await nftContract.getTotalNFTsMintedSoFar()
    console.log("getTotalNFTsMintedSoFar: ");


  };
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  runMain();