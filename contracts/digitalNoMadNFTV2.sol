/**
 * Due to be Submitted for verification at Etherscan.io on 20-01-2023
 */ 
 // SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;
/** [UNLICENSED]
    @title DigitalNoMadNFTV (v2.0.0)
    @author Jamal Forbes (Senior Solidity Developer) <https://github.com/GNFinder>
    @notice Provides a function for MINTING the DigitalNoMadNFTV1. Provides a function for providing "randomness" in Solidity
    Something which is very complex as all information is stored publically and is deterministic (easy to predict).
    @audit by Jamal Forbes (Senior Solidity Developer) <https://github.com/GNFinder>
***/
// DEPENDENCIES:
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "hardhat/console.sol";
/* @dev Consider using an interface which will save a considerable amount of gas in storage. 
Use only the functions called in the contract below, saving the amount
Of gas used to store "ALL" the (unused) functions from imported contracts above, at compilation time.
 */
contract DigitalNoMadNFTV2 is ERC721URIStorage {
  /** @note DigitalNoMadNFTV1 is ERC721URIStorage not ERC721 as ERC721 _setTokenURI() was removed in pragma 0.8.0.
      @notice NFT token is named: "DigitalNoMadNFT"
      @notice NFT token symbol is "DiNoMad"
  ***/ 
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;
  /**
   @dev Creating x2 constant string variables for the NFT svg file using randomness to generate x3 sparate parts of the finalSVG.
   */
  string constant baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>"; /// @notice add SVG String HERE
  string constant closeOfSvg = "</text></svg>";
  /**
  @dev Creating three arrays, each with their own theme of random words.
  Further explained in the documentation found HERE:<https://github.com/GNFinder>.
  ***/
  string[] moneyWords = ["Money", "Finance", "Mula", "Rich", "Wealthy", "Loaded", "Spender", "Millionaire", "Billionaire", "Trillionaire", "Investor", "Whale"]; // Your financial future according to the metaverse
  string[] traitWords = ["Earner", "Developer", "Learner", "Giving", "Entrepreneur", "Hustler", "Boss", "Helper", "Visionary", "Nomad", "Provider", "Shark"]; // Your secret trait
  string[] placeWords = ["Jamaica", "Hawaii", "Egypt", "Mexico", "Portugal", "Rome", "Paris", "Holland", "London", "Miami", "Dubai", "Maldives", "London"]; // Places to go when you reach your goals
  
  constructor() ERC721 ("DigitalNoMadNFT", "DiNoMad") {
    console.log("A distinct set of professional specialists, forward thinkers, underdogs, and the world's most persistent, strong-willed individuals. " "(GNFinder)");
    console.log("\n--------------------");
  }
    // INTERNAL FUNCTIONS: marked as view and internal, which means that it can only be called by other functions within the contract and it doesn't modify the contract's state.
  function randomMoneyWord(uint256 tokenId) internal view returns (string memory) { 
    uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
    // Squash the # between 0 and the length of the array to avoid going out of bounds.
    rand = rand % moneyWords.length;
    return moneyWords[rand];
  }
  function randomTraitWord(uint256 tokenId) internal view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId))));
    rand = rand % traitWords.length;
    return traitWords[rand];
  }
  function randomPlaceWord(uint256 tokenId) internal view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId))));
    rand = rand % placeWords.length;
    return placeWords[rand];
  }
  function random(string memory input) internal pure returns (uint256) {
      return uint256(keccak256(abi.encodePacked(input)));
  }
  //EXTERNAL FUNCTION: saves on the gas fees generated by making it a public function
  function makeADigitalNomadNFT() external {
    uint256 newItemId = _tokenIds.current();
    string memory first = randomMoneyWord(newItemId);
    string memory second = randomTraitWord(newItemId);
    string memory third = randomPlaceWord(newItemId);
    string memory finalSvg = string(abi.encodePacked(baseSvg, first, second, third, closeOfSvg));
    console.log("\n--------------------");
    console.log("baseSvg: " );
    console.log(baseSvg);
    console.log("--------------------\n");
    console.log("closeOfSvg: ");
    console.log(closeOfSvg);
    console.log("--------------------\n");
    console.log("finalSvg: ");
    console.log(finalSvg);
    console.log("--------------------\n");
    console.log("NFTCombinedWord: ");
    console.log(first,second,third);
    console.log("--------------------\n");
    _tokenIds.increment();
    _safeMint(msg.sender, newItemId); 
    _setTokenURI(newItemId, "this is a test"); 
    
    console.log("A DigitalNoMadNFT w/ ID %s has been minted to %s", newItemId, msg.sender);
  }
}