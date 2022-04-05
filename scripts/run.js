const hre = require("hardhat");

async function main() {
  
  const [signer, otherSigner] = await hre.ethers.getSigners()
  const domainContractFactory = await hre.ethers.getContractFactory("Domain");
  const domainContract = await domainContractFactory.deploy();
  await domainContract.deployed();

  const txn = await domainContract.addDomain("corgi", {value : hre.ethers.utils.parseEther("0.1")});
  await txn.wait();
  const domainOwner = await domainContract.getOwner("corgi");
  console.log("Owner of the domina corgi", domainOwner);

  console.log("Balance of the domain owner", await hre.ethers.provider.getBalance(domainContract.address));

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


