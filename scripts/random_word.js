const main = async () => {
  const randomNFTWordFactory = await hre.ethers.getContractFactory('randomNFTWord');
  const randomWordContract = await randomNFTWordFactory.deploy();
  await randomWordContract.deployed();
  console.log("RANDOMISATION");

  // Call to view a randomNumber on the randomNFTWord contract and returning the value of a randomWord for each NFT.
  let txn = await randomWordContract.pickRandomWords()
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