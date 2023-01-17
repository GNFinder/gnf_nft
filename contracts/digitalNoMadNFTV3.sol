/**
 * Due to be Submitted for verification at Etherscan.io on 20-01-2023
 */ 
 // SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;
/** [UNLICENSED]
    @title DigitalNoMadNFTV (v3.0.0)
    @author Jamal Forbes (Senior Solidity Developer) <https://github.com/GNFinder>
    @notice Provides a function for MINTING the DigitalNoMadNFTV where it uses "randomness" in Solidity to generate a unique three word string 
    @audit-ok by Jamal Forbes (Senior Solidity Developer) <https://github.com/GNFinder>
***/
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "hardhat/console.sol";
/* @dev Consider using an interface which will save a considerable amount of gas in storage. 
Use only the functions called in the contract below, saving the amount
Of gas used to store "ALL" the (unused) functions from imported contracts above, at compilation time.
Further explained in the documentation found HERE:<https://github.com/GNFinder>.
 */
contract DigitalNoMadNFTV3 is ERC721URIStorage {
  /**
    @notice NFT token is named: "DigitalNoMadNFT"
    @notice NFT token symbol is "DiNoMad"
  ***/ 
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;
  string constant baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>"; /// @notice add SVG String HERE
  string constant closeOfSvg = "</text></svg>";
  constructor() ERC721 ("DigitalNoMadNFT", "DiNoMad") {
    console.log("A distinct set of professional specialists, forward thinkers, underdogs, and the world's most persistent, strong-willed individuals. " "(GNFinder)");
    console.log("--------------------\n");
  }  
  function makeADigitalNomadNFT() external payable returns (string memory, string memory, string memory){

    string[12] memory getMoneyWords = ["Money", "Finance", "Mula", "Rich", "Wealthy", "Loaded", "Spender", "Millionaire", "Billionaire", "Trillionaire", "Investor", "Whale"]; // Your financial future according to the metaverse
    string[13] memory getPlaceWords = ["Jamaica", "Hawaii", "Egypt", "Mexico", "Portugal", "Rome", "Paris", "Holland", "London", "Miami", "Dubai", "Maldives", "London"]; // Places to go when you reach your goals
    string[12] memory getTraitWords = ["Earner", "Developer", "Learner", "Giving", "Entrepreneur", "Hustler", "Boss", "Helper", "Visionary", "Nomad", "Provider", "Shark"]; // Your secret trait

    uint256 randomNo1 = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty))) % getMoneyWords.length;
    uint256 randomNo2 = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty))) % getPlaceWords.length;
    uint256 randomNo3 = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty))) % getTraitWords.length;

    string memory moneyWordOnNFT = getMoneyWords[randomNo1];
    string memory placeWordOnNFT = getPlaceWords[randomNo2];
    string memory traitWordOnNFT = getTraitWords[randomNo3];
    console.log("CONGRATULATIONS user, you're official NFT title is: ");
    console.log(moneyWordOnNFT, placeWordOnNFT, traitWordOnNFT);
    
    uint256 newItemId = _tokenIds.current();
    string memory finalSvg = string(abi.encodePacked(baseSvg, moneyWordOnNFT, placeWordOnNFT, traitWordOnNFT, closeOfSvg));
    console.log("A DigitalNoMadNFT w/ ID %s has been minted to %s", newItemId, msg.sender);
    console.log("\nfinalSvg: ");
    console.log(finalSvg);
    console.log("--------------------\n");
    
    _tokenIds.increment();
    _safeMint(msg.sender, newItemId); 
    _setTokenURI(newItemId, "this is a test"); 
    
    return (moneyWordOnNFT,placeWordOnNFT,traitWordOnNFT);
  }
}