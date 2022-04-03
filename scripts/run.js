const hre = require("hardhat");

async function main() {
  
  const [signer, otherSigner] = await hre.ethers.getSigners()
  const domainContractFactory = await hre.ethers.getContractFactory("Domains");
  const domainContract = await domainContractFactory.deploy();
  await domainContract.deployed();

  const txn = await domainContract.addDomain("corgi");
  await txn.wait();
  const domainOwner = await domainContract.getOwner("corgi");

  console.log("owner domain", domainOwner);

}

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
    
}

runMain();


