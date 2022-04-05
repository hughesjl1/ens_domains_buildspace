require("@nomiclabs/hardhat-waffle");
require('dotenv').config();

module.exports = {
  solidity: "0.8.10",
  networks: {
    hardhat: {
      chainId: 1337
    },
    mumbain : {
      url: process.env.MUMBAI_TEST_URL,
      accounts : [process.env.ACCOUNT],
      gas : 15e6
    }
  } 
};
