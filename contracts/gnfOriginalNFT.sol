// SPDX-License-Identifier: UNLICENSED


pragma solidity ^0.8.17;

// DEPENDENCIES:

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol"; // @note: ensures a unique Count is created for each token from the MINT
import "hardhat/console.sol"; //@dev: dependancy for testing the contracts functionality
// @note: https://github.com/openzeppelin/ documentation is the best way to keep up to date with the latest import libraries

contract GNFOrignalNFT is ERC721 {
  // @note: Using Counters to help us keep track of tokenIds.
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  // @dev: NFT token is named: "GNFinderNFT"
  // @dev: NFT token symbol is "GNFINDER"
  constructor() ERC721 ("GNFinderNFT", "GNFINDER") {
    console.log("Only The Strong Survived The Pandemic - Welcome to the New Realm! " "(GNFinder)"); // @note: Message intended for at later stages 
  }

  // FUNCTIONS
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

  // Set the NFT's metadata
  function tokenURI(uint256 _tokenId) public view override returns (string memory) {
    require(_exists(_tokenId));
    console.log("An NFT w/ ID %s has been minted to %s", _tokenId, msg.sender); // For debugging purposes only
    return string(abi.encodePacked(
        // TokenURI - metadata for the NFT
        "data:application/json;base64,",
        ""
        )
    );
  }
}