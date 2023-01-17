const main = async () => {
  const nftContractFactory = await hre.ethers.getContractFactory('DigitalNoMadNFTV3');

  const nftContract = await nftContractFactory.deploy();
  await nftContract.deployed();
  console.log("Success: We've Hacked the Ethereum Blockchain and Deployed the DigitalNoMadNFTV3 contract to: " + "\n", nftContract.address,"\n");

  let txn = await nftContract.makeADigitalNomadNFT()
  await txn.wait()
  // console.log("Here's NFT #A")

  txn = await nftContract.makeADigitalNomadNFT()
  await txn.wait()
  // console.log("Here's NFT #B")
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