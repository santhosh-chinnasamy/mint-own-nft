const main = async () => {
  const nftContractFactory = await hre.ethers.getContractFactory(
    "MyEpicNFT"
  );
  const nftContract = await nftContractFactory.deploy();
  await nftContract.deployed();
  console.log("Contract Deployed to:", nftContract.address);
};

const runMain = async () => {
  try {
    await main();
    process.exit(1);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
};

runMain();
