
const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("nft contract tests", () => {
  it("Should return Token Name and Symbol", async () => {
    const contract = await ethers.getContractFactory("LeCryptoFellows");
    const nft = await contract.deploy();
    await nft.deployed();
    expect(await nft.symbol()).to.equal("LCF");
    expect(await nft.name()).to.equal("LeCryptoFellows");
  });

  it("test initializeFellows function", async () => {
    // let's first mint 40 of these.
    const contract = await ethers.getContractFactory("LeCryptoFellows");
    const nft = await contract.deploy();
    await nft.deployed();

    for (i = 1; i < 41; i ++) {
      const tx = await nft.initializeFellow("0xe7f1725e7734ce288f8367e1bb143e90bb3f0512", "heyymaaaaaan!", { value: ethers.utils.parseEther("0.01") });
      await tx.wait();
    }

    expect(await nft.ownerOf(5).to.equal("0xe7f1725e7734ce288f8367e1bb143e90bb3f0512"));
  }); 
});