const main = async () => {
  const nftContractFactory = await hre.ethers.getContractFactory('DigitalNoMadNFTV2');
  const nftContract = await nftContractFactory.deploy();
  await nftContract.deployed();
  console.log("Success: We've Hacked the Ethereum Blockchain and Deployed the DigitalNoMadNFTV2 @: " + "\n", nftContract.address);

  // Calling the mint function on the GNFOrignalNFT contract.
  let txn = await nftContract.makeADigitalNomadNFT()
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