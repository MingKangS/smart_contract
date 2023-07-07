require("@nomiclabs/hardhat-waffle");

module.exports = {
  solidity: "0.8.9",
  networks: {
    sepolia: {
      url: "https://eth-sepolia.g.alchemy.com/v2/YderQGnbJQ4TxKqMhmNCvVPJgKJMBCXK",
      accounts: [
        "13feecd2846f7f35c95cd1ff13715797b3ada28094acdec4ba4b96cc7317575a",
      ],
    },
  },
};
