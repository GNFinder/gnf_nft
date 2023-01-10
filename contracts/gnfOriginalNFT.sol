/**
 *Submitted for verification at Etherscan.io on 10-01-2023
 */
 
 // SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.17; /// @dev Choosing not to set version to be ^0.8.17 because we cannot predict that all future version will work as expected.

/// [UNLICENSED]
/// @title GNFOrignalNFT v3.0.0
/// @author Jamal Forbes <https://github.com/GNFinder>
/// @dev Improvement of v2.0.0, improved natspec, improved NFT metadata storage
/// @notice ERC-20 Non-Fungible Token for uniquely counting and indentifying members of the GNF Famaliy Community.
/// @notice Provides a function for MINTING the GNFOrignalNFT. Provides a function for providing "randomness" in Solidity
//  Something which is very complex as all information is stored publically and is deterministic (easy to predict).

// DEPENDENCIES:

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol"; /// @dev, @notice a UNIQUE TOKEN Count is created for each token from the MINT
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Strings.sol"; /// @dev For a uint value to be converted into a string value in Solidity

import "hardhat/console.sol"; /// @dev For testing the contracts functionality
// @note https://github.com/openzeppelin/ documentation is the best way to keep up to date with the latest import libraries

contract GNFOrignalNFT is ERC721 {
  /// @note Using Counters to keep track of tokenIds.
  /// @notice NFT token is named: "GNFinderNFT"
  /// @notice NFT token symbol is "GNFINDER"
  
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  /// @dev creating a string variable for the NFT svg file - @notice using randomness to generate part of the variable
  string baseSvg = "this is a test"; /// @notice add SVG String HERE

  /// @dev creating three arrays, each with their own theme of random words.
  string[] moneyWords = ["Money", "Finance", "Mula", "Rich", "Wealthy", "Loaded", "Spender", "Millionaire", "Billionaire", "Trillionaire"]; // Your financial future according to the metaverse
  string[] traitWords = ["Earner", "Developer", "Learner", "Persistent", "Entrepreneur", "Hustler", "Boss", "Mover", "Shaker", "Nomad"]; // Your secret trait
  string[] placeWords = ["Jamaica", "Hawaii", "Egypt", "Mexico", "Portugal", "Rome", "Paris", "Holland", "London", "Miami"]; // Places to go when you reach your goals


  constructor() ERC721 ("GNFinderNFT", "GNFINDER") {
    console.log("Only The Strong Survived The Pandemic - Welcome to the New Realm! " "(GNFinder)"); // @note: Message intended for at later stages 
  }

  // FUNCTIONS

    function randomMoneyWord(uint256 tokenId) public view returns (string memory) {
    // I seed the random generator. More on this in the lesson. 
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

  function makeAGNFNFT() public {
     // Get the current tokenId, this starts at 0.
    uint256 newItemId = _tokenIds.current();

     // Actually mint the NFT to the sender using msg.sender.
    _safeMint(msg.sender, newItemId);
    
    // Return the NFT's metadata
    tokenURI(newItemId);

    // Increment the counter for when the next NFT is minted.
    _tokenIds.increment();
  }

  /// @return Combinination of the NFT's "unique" number (TokenId) with 
  /// the specified abi.encodePacked(arg) Metadata.
  function tokenURI(uint256 _tokenId) public view override returns (string memory) {
    require(_exists(_tokenId));
    console.log("An NFT w/ ID %s has been minted to %s", _tokenId, msg.sender); // For debugging purposes only
    return string(abi.encodePacked(
        // TokenURI - metadata for the NFT
        "data:application/json;base64,",
        "ewogICAgIm5hbWUiOiAiR05GaW5kZXIgTkZUIiwKICAgICJkZXNjcmlwdGlvbiI6ICJHTkZpbmRlciBORlQgMTAxIChBbHdheXMgQmUgWW91cnNlbGYsIEFsd2F5cyBMRUFSTklORywgQWx3YXlzIEdyYXRlZnVsKSIsCiAgICAiaW1hZ2UiOiAiZGF0YTppbWFnZS9zdmcreG1sO2Jhc2U2NCxQSE4yWnlCNGJXeHVjejBpYUhSMGNEb3ZMM2QzZHk1M015NXZjbWN2TWpBd01DOXpkbWNpSUhCeVpYTmxjblpsUVhOd1pXTjBVbUYwYVc4OUluaE5hVzVaVFdsdUlHMWxaWFFpSUhacFpYZENiM2c5SWpBZ01DQXpOVEFnTXpVd0lqNEtJQ0FnSUR4emRIbHNaVDR1WW1GelpTQjdJR1pwYkd3NklIZG9hWFJsT3lCbWIyNTBMV1poYldsc2VUb2djMlZ5YVdZN0lHWnZiblF0YzJsNlpUb2dNVFJ3ZURzZ2ZUd3ZjM1I1YkdVK0NpQWdJQ0E4Y21WamRDQjNhV1IwYUQwaU1UQXdKU0lnYUdWcFoyaDBQU0l4TURBbElpQm1hV3hzUFNKaWJHRmpheUlnTHo0S0lDQWdJRHgwWlhoMElIZzlJalV3SlNJZ2VUMGlOVEFsSWlCamJHRnpjejBpWW1GelpTSWdaRzl0YVc1aGJuUXRZbUZ6Wld4cGJtVTlJbTFwWkdSc1pTSWdkR1Y0ZEMxaGJtTm9iM0k5SW0xcFpHUnNaU0krUjA1R2FXNWtaWElnVGtaVVBDOTBaWGgwUGdvOEwzTjJaejQ9Igp9Cg=="
        )
    );
  }
}