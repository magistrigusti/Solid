import { loadFixture, ethers, SignerWithAddress, expect } from "./setup";
import type { DOMToken, Proxy} from "../typechain-types";

describe("DOMToken", function() {
  async function dep() {
    const [ deployer ] = await ethers.getSigners();

    const TokenFactory = await ethers.getContractFactory("DOMToken");
    const token = await upgrades.deployProxy(TokenFactory, [], {initializer: 'initialize'});

    await token.deployed();

    return { token, deployer };
  }

  it('works', async function() {
    const { token, deployer } = await loadFixture(dep);

    const mintTx = await token.mint(deployer.address, 1000);
    await mintTx.wait();

    expect(await token.totalSupply()).to.eq(1000);

    const TokenFactoryV2 = await ethers.getContractFactory("MyTokenV2");
    const token2 = await upgrades.upgradeProxy(token.address, TokenFactory2);

    expect(await token2.totalSupply()).to.eq(1000);

    const mintTx2 = await token2.mint(deployer.address, 1000);
    await mintTx2.wait();

    expect(await token2.totalSupply()).to.eq(3000);
  })
})

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