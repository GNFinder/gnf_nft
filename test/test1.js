pragma solidity 0.8.17;
import "hardhat/memory.sol";
import "hardhat/assert.sol";
import "./DigitalNoMadNFTV5.sol";

contract TestDigitalNoMadNFTV5 {
    DigitalNoMadNFTV5 digitalNoMadNFTV5;
  
    beforeEach() {
        digitalNoMadNFTV5 = new DigitalNoMadNFTV5();
    }

    function testMakeADigitalNomadNFT() public {
        // Test that the first NFT can be minted
        string memory response = digitalNoMadNFTV5.makeADigitalNomadNFT();
        Assert.notEqual(response, "", "Response should not be empty");

        // Test that the maximum number of NFTs has been reached
        uint256 _nomadTotalSupply = 50;
        uint256 i;
        for (i = 1; i <= _nomadTotalSupply; i++) {
            response = digitalNoMadNFTV5.makeADigitalNomadNFT();
            Assert.notEqual(response, "", "Response should not be empty");
        }
        response = digitalNoMadNFTV5.makeADigitalNomadNFT();
        Assert.equal(response, "", "Response should be empty");
    }
}
