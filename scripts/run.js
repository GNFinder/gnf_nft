const main = async () => {
  const nftContractFactory = await hre.ethers.getContractFactory('GNFOrignalNFT');
  const nftContract = await nftContractFactory.deploy();
  await nftContract.deployed();
  console.log("Success: We've Hacked the Ethereum Blockchain and Deployed to: " + "\n", nftContract.address);

  // Calling the mint function on the GNFOrignalNFT contract.
  let txn = await nftContract.makeAGNFNFT()
  // Wait for it to be mined.
  await txn.wait()

  // Mint another NFT to double check.
  txn = await nftContract.makeAGNFNFT()
  // Wait for it to be mined.
  await txn.wait()

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