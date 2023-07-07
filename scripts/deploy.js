const main = async () => {
  const postFactory = await hre.ethers.getContractFactory("Post");
  const postContract = await postFactory.deploy();

  await postContract.deployed();

  postContract.posts = [];

  console.log(postContract.posts);
  console.log("Transactions address: ", postContract.address);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
};

runMain();
