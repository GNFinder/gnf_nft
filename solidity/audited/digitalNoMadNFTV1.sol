/**
 *Due to be Submitted for verification at Etherscan.io on 13-01-2023
 */
 
 // SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.17;

/** [UNLICENSED]
    @title DigitalNoMadNFTV (v1.0.0)
    @author Jamal Forbes (Senior Solidity Developer) <https://github.com/GNFinder>
    @notice Provides a function for MINTING the DigitalNoMadNFTV1. Provides a function for providing "randomness" in Solidity
    Something which is very complex as all information is stored publically and is deterministic (easy to predict).
    Currently under @audit from Jamal Forbes (Senior Solidity Developer) <https://github.com/GNFinder>
***/

// DEPENDENCIES:


/// @note https://github.com/openzeppelin/ Documentation is the best way to keep up to date with the latest import libraries
import "@openzeppelin/contracts/utils/Counters.sol"; /// @audit - must add node_modules/@openzeppelin/ as absolute file path for HardHat to read withour errors - @note Remove after before production and after @audit
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol"; /// @audit - (node_modules) appended to front of relevant path as absolute path for HardHat to read withour errors.
import "@openzeppelin/contracts/utils/Strings.sol"; /// @audit - (node_modules) appended to front of relevant file path.
import "hardhat/console.sol";
/**
@audit - Consider using an interface which will save a considerable amount of gas in storage. 
Use only the functions called in the contract below, saving the amount
Of gas used to store "ALL" the (unused) functions from imported contracts above, at compilation time.
 */

contract DigitalNoMadNFTV1 is ERC721URIStorage {
  /** @note DigitalNoMadNFTV1 is ERC721URIStorage not ERC721 as ERC721 _setTokenURI() was removed in pragma 0.8.0.
      @notice NFT token is named: "DigitalNoMadNFT"
      @notice NFT token symbol is "DiNoMad"
  ***/ 
  
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  /**
   @dev Creating a string variable for the NFT svg file - @notice using randomness to generate part of the variable
   */
   /// @audit DigitalNoMadNFTV1.baseSvg() should be constant - State variables that are not updated following deployment should be declared constant to save gas.
  string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>"; /// @notice add SVG String HERE
   /// @note Add the constant attribute to the baseSVG variable that never changes.

  /**
  @dev Creating three arrays, each with their own theme of random words.
  Further explained in the documentation found HERE:<https://github.com/GNFinder>.
  ***/
  string[] moneyWords = ["Money", "Finance", "Mula", "Rich", "Wealthy", "Loaded", "Spender", "Millionaire", "Billionaire", "Trillionaire", "Investor", "Whale"]; // Your financial future according to the metaverse
  string[] traitWords = ["Earner", "Developer", "Learner", "Giving", "Entrepreneur", "Hustler", "Boss", "Helper", "Visionary", "Nomad", "Provider", "Shark"]; // Your secret trait
  string[] placeWords = ["Jamaica", "Hawaii", "Egypt", "Mexico", "Portugal", "Rome", "Paris", "Holland", "London", "Miami", "Dubai", "Maldives", "London"]; // Places to go when you reach your goals


  constructor() ERC721 ("DigitalNoMadNFT", "DiNoMad") {
    console.log("A distinct set of professional specialists, forward thinkers, underdogs, and the world's most persistent, strong-willed individuals. " "(GNFinder)");
  }

  // FUNCTIONS:
    /**
    @audit the functions randomMoneyWord, randomTraitWord & randomPlaceWord are using x3 gas 
    Compared to a singular funtion that grabs all three words from each array.
    @note below for example:
    function randomWord() {}
    if randomMoneyWord == true {
      return randomTraitWord,
      else { return randomMoneyWord
      }
      if randomTraitWord == true {
        retturn randomPlaceWord,
        else { return randomTraitWord
        }
    */
    /** 
    @audit randomMoneyWord() is never called by the contract so should be declared external.
    @note Use the external attribute.
    */
  function randomMoneyWord(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
    // Squash the # between 0 and the length of the array to avoid going out of bounds.
    rand = rand % moneyWords.length;
    return moneyWords[rand];
  }

  function randomTraitWord(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId))));
    rand = rand % traitWords.length;
    return traitWords[rand];
  }

  function randomPlaceWord(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId))));
    rand = rand % placeWords.length;
    return placeWords[rand];
  }

  function random(string memory input) internal pure returns (uint256) {
      return uint256(keccak256(abi.encodePacked(input)));
  }

    /** 
    @audit makeADigitalNomadNFT() Public functions that are never called by the contract should be declared external.
    @note Use the external attribute.
    */
  function makeADigitalNomadNFT() public { /// @audit - Reentrancy in DigitalNoMadNFTV1.makeADigitalNomadNFT()
    /** @audit Better to follow the Checks-Effects-Interactions pattern. 
    Checks are not performed in a public function that makes an external call.
    @audit Anyone can call this function, essentially minting <= totalSupply of DigitalNoMadNFTV1.
    ***///

    uint256 newItemId = _tokenIds.current();

    /** 
    @dev Generating "random" words from each of the three array Strings, Stored inside of this contracts state memory (above) = Three+Combined+Words
    ***/
    string memory first = randomMoneyWord(newItemId);
    string memory second = randomMoneyWord(newItemId);
    string memory third = randomMoneyWord(newItemId);

    /**
    @dev, @notice Concatenating strings and then closing with the <text> and <svg> tags.
    ***/
    string memory finalSvg = string(abi.encodePacked(baseSvg, first, second, third, "</text></svg>"));
    console.log("\n--------------------");
    console.log(finalSvg);
    console.log("--------------------\n");

    _safeMint(msg.sender, newItemId); /// @audit Reentrancy Vulnerabilty - state variables are changed after msg.sender (a potential bad actor/smart contract) is called.
     
    /** 
    @dev Set the tokenURI later!
    ***/ 
    _setTokenURI(newItemId, "this is a test"); /// @audit State variable writen after the call to msg.sender
    _tokenIds.increment();
    console.log("A DigitalNoMadNFT w/ ID %s has been minted to %s", newItemId, msg.sender);
  }
}