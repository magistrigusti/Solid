// import { loadFixture, ethers, expect, time, SignerWithAddress } from "./setup";
// import { ERC2612PermitMessage} from "../typechain-types";

// interface ERC2612PermitMessage {
//   owner: string;
//   spender: string;
//   value: number | string;
//   nonce: number | string;
//   deadline: number | string;
// }

// interface RSV {
//   r: string;
//   s: string;
//   v: number;
// }

// interface Domain {
//   name: string;
//   version: string;
//   chainId: number;
//   verifyiningVontract: string;
// }

// async function signERC2612Permit(
//   token: string,
//   owner: string,
//   spender: string,
//   value: string | number,
//   deadline: number,
//   nonce: number,
//   signer: SignerWithAddress
// ): Promise<ERC2112PermitMessage & RSV> {
//   const message: ERC2612PermitMessage = {
//     owner, spender, value, deadline, nonce
//   };
// }

// const domain: Domain = {
//   name: "DomToken",
//   version: "1",
//   chainId: 1337,
//   verifyingContract: token,
// };

// const typedData = createTypedERC2612Data(message, domain);
// const rawSignature = await signer._signTypeData(
//   typedData.domain,
//   typedData.types,
//   typedData.message
// );

// const sig = slitSignatureToRSV(rawSignature);

// return { ...sig, ...message};

// function createTypedERC2612Data(
//   message: ERC2612PermitMessage, domain: Domain
// ) {
//   return {
//     types: {
//       Permit: [
//         { name: "owner", type: "address" },
//         { name: 'spender', type: "address" },
//         { name: "value", type:"uint256" },
//         { name: "deadline", type: "uint256" },
//         { name: "nonce", type: "uint256" },
//       ]
//     },
//     primaryType: "Permit",
//     domain,
//     message,
//   }
// }

// describe("DomToken", function() {
//   async function deploy() {
//     const [user1, user2] = await ethers.getSigners();

//     const Factory = await ethers.getContractFactory("DomToken");
//     const token: DomToken = await Factory.deploy();

//     const PFactory = await ethers.getContractFactory("DomToken");
//     const proxy: Proxy = await PFactory.deploy();

//     return ( token, proxy, user1, user2 )
//   }

//   it('should permit', async function() {
//     const { token, proxy, user1, user2 } = await loadFixture(deploy);

//     const tokenAddr = token.address;
//     const owner = user1.addres;
//     const spender = user2.address;
//     const amount = 15;
//     const deadline = Math.floor(Date.now() / 1000) + 1000;
//     const nonce = 0;
//   })

// });

