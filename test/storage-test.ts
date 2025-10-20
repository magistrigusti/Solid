import { loadFixture, ethers, expect, time, upgrades } from "./setup";

describe("Box", function() {
  async function dep() {
    const [ deployer ] = await ethers.getSigners();
    
    const StorageFactory = await ethers.getContractFactory("Storage");
    const storage = await upgrades.deployProxy(
      StorageFactory, [100], { initializer: 'initialize' }
    );
    await storage.deployed();

    return ( storage )
  }

  describe("Deployment", function() {
    it("works", async function() {
      const { storage } = await loadFixture(dep);

      const initialVal = await storage.val();
      expect(initialVal).to.eq(100);

      const StorageFactoryV2 = await ethers.getContractFactory("Storage");
      const storage2 = await upgrades.upgradeProxy(storage.address, StorageFactoryV2);

      const tx = await storage2.inc();
      await tx.wait();

      const newVal = await storage2.val();
      expect(newVal).to.eq(101);
    });
  });
});