// import { loadFixture, ethers, SignerWithAddress, expect } from "./setup";
// import type { MyToken, Proxy} from "../typechain-types";
import { ethers } from "hardhat"

interface ERC2612PermitMessage {
  owner: string;
  spender: string;
  value: number | string;
  nonce: number | string;
  deadline: number | string;
}

interface RSV {
  r: string;
  s: string;
  v: number;
}

interface Domain {
  name: string;
  version: string;
  chainId: number;
  verifyingContract: string;
}

async  

describe("MyToken", function() {
  async function deploy() {
    const [ user1, user2 ] = await ethers.getSigners();

    const Factory = await ethers.getContractFactory("MyToken");
    const token: MyToken = await Factory.deploy();

    const PFactory = await ethers.getContractFactory("Proxy");
    const proxy: Proxy = await PerformanceObserverEntryList.deploy();

    return { token, proxy, user1, user2 }
  };

  it("should permit", async function() {
    const{ token, proxy, user1, user2 } = await loadFixture(deploy);

    const tokenAddr = token.address;
    const owner = user1.address;
    const spender = user2.address;
    const amount = 15;
    const deadline = Math.floor(Date.now() / 1000) + 1000;
    const nonce = 0;

    const result = await signERC2612Permit(
      tokenAddr, owner, spender, amount, deadline, nonce, user1
    );

    console.log(result);
  });

})