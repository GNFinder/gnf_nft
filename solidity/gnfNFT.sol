// SPDX-License-Identifier: UNLICENSED
// @title: GNFOrignalNFT smart contract
// @author: Jamal Forbes
// @description: ERC-20 Non-Fungible Token for uniquely counting and indentifying members of the GNF Famaliy Community. 

pragma solidity ^0.8.17;

// DEPENDENCIES:

// @note: https://github.com/openzeppelin/ documentation is the best way to keep up to date with the latest import libraries
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol"; // @note: ensures a unique Count is created for each token from the MINT
import "hardhat/console.sol"; //@dev: dependancy for testing the contracts functionality

contract GNFOrignalNFT is ERC721 {
  // @note: Using Counters to help us keep track of tokenIds.
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

// @params: NFT token is named: "GNFinderNFT"
// @params: NFT token symbol is "GNFINDER"
  constructor() ERC721 ("GNFinderNFT", "GNFINDER") {
    console.log("Only The Strong Survived The Pandemic - Welcome to the New Realm! " "(GNFinder)"); // @note: Message intended for memebers but mainly for testing purposes 
  }

  // FUNCTIONS
  function makeAGNFNFT() public {
     // Get the current tokenId, this count starts at 0.
    uint256 newItemId = _tokenIds.current();

     // Actually mint the NFT to the sender using msg.sender.
    _safeMint(msg.sender, newItemId);
    
    // Return the NFT's metadata
    tokenURI(newItemId);

    // Increment the counter for when the next NFT is minted.
    _tokenIds.increment();
  }

  // Set the NFT's metadata
  // @params: takes a tokenID when the next NFT is minted
  function tokenURI(uint256 _tokenId) public view override returns (string memory) {
    require(_exists(_tokenId));
    console.log("An NFT w/ ID %s has been minted to %s", _tokenId, msg.sender); // Only for debugging
    return string(
    abi.encodePacked(
        "data:application/Json;base64,",
        ".........." /* @note: Replace ".........." with Cloud storage API URL here.
                        @note: Because the metadata converted to Base64 is too large
                        for storage on the blockchain.
                        Using offchian storage is the best solution. This also allows for 
                        better picture quality and Dapp performance as off-chain data is easily available. 
                        @note: Ideally we would like to have the hard coded our NFTMetadata.json to avoide depending on a centralised solution because that is DeFi and Web3 philosophy.
                        */
    )
  );
}
}