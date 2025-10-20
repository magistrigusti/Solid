// import { expect } from "chai";
// import { ethers, deployments, network } from 'hardhat';
// import { Lock } from "../typechain-types";

// describe("DomToken", function() {
//   let token: Lock;
//   let deployer: string;
//   let user: string;

//   beforeEach(async function() {
//     ({ deployer, user} = await getNameAccounts());

//     await deployments.fixture('DomToken');
//     token = await ethers.getContract<DomToken>('Lock');
    
//   });

//   it("works", async function() {
//     const tokenId = "";

//     const minTx = await token.safeMint(user, tokenId);
//     await mintTx.wait();

//     expect(await token.tokenURI(0)).to.eq(`ipfs://${tokenId}`);

//     const approveTx = await token.approve(user, deployerTokenId);
//     await approveTx.wait();

//     const transferTx = await tokenAsUser.transferFrom(deployer, user, deployerTokenId);
//     await transferTx.wait();

//     expect(await token.owner(deployerTokenId)).to.eq(user);
//   })
// })