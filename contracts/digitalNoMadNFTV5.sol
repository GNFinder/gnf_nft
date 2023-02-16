/** SPDX-License-Identifier: UNLICENSED
  * @title DigitalNoMadNFTV (v4.0.0)
  * @author Jamal Forbes (Senior Solidity Developer) <https://github.com/GNFinder>
  * @notice Provides a function for MINTING the DigitalNoMadNFTV where it uses "randomness" in Solidity to generate a unique three word string 
  * This smart contract (v3.0.0) has been audited by Jamal Forbes auditor on 16/01/2023.
  * Report link: https://github.com/GNFinder
  * Version audited: 1.0.0
  * Note that this audit does not guarantee that the contract is free from bugs or vulnerabilities. Use at your own risk.    
  * Due to be Submitted for verification at Etherscan.io on 03-02-2023
  * @dev Consider using an interface which will save a considerable amount of gas in storage. 
  * Use only the functions called in the contract below, saving the amount
  * Of gas used to store "ALL" the (unused) functions from imported contracts above, at compilation time.
  * What is the limited total supply of the NFT?
*/
pragma solidity 0.8.17;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "hardhat/console.sol";

// We need to import the helper functions from the contract that we copy/pasted.
import { Base64 } from "../libraries/Base64.sol";

contract DigitalNoMadNFTV5 is ERC721URIStorage {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  string constant baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>"; /// @notice add SVG String HERE
  string constant closeOfSvg = "</text></svg>";

  event NewDigitalNomadNFTMinted(address sender, uint256 tokenId);
  constructor() ERC721 ("DigitalNoMadNFT", "DiNoMad") {
    // console.log("A distinct set of professional specialists, forward thinkers, underdogs, and the world's most persistent, strong-willed individuals. " "(GNFinder)");
    console.log("--------------------\n");
  }  
  function makeADigitalNomadNFT() external payable returns (string memory) {
    /* @dev, @note 
    * Considerations:
    * 1) Requiring a reentrancy guard using a mutex for this function.
    * 2) Requiring an algorithm to check that no string combinations can ever be the same
    * e.g. use a smart contract storage to store the list of previously generated hashes, 
    * Checking for duplicates across multiple function calls.
    * 3) Making use of a Bloom Filer, which is a
    * Probabilistic data structure to test whether an element
    * Is a member of a set, it's a more gas-efficient way than
    * Storing all the hashes in the storage.
    **/ 
    uint256 _nomadTotalSupply = 50;
    require(_tokenIds._value <= _nomadTotalSupply, "Maximum number of NFTs reached");

    string[12] memory getMoneyWords = ["Money", "Finance", "Mula", "Rich", "Wealthy", "Loaded", "Spender", "Millionaire", "Billionaire", "Trillionaire", "Investor", "Whale"]; // Your financial future according to the metaverse
    string[13] memory getPlaceWords = ["Jamaica", "Hawaii", "Egypt", "Mexico", "Portugal", "Rome", "Paris", "Holland", "London", "Miami", "Dubai", "Maldives", "London"]; // Places to go when you reach your goals
    string[12] memory getTraitWords = ["Earner", "Developer", "Learner", "Giving", "Entrepreneur", "Hustler", "Boss", "Helper", "Visionary", "Nomad", "Provider", "Shark"]; // Your secret trait

    uint256 randomNo1 = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty))) % getMoneyWords.length;
    uint256 randomNo2 = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty))) % getPlaceWords.length;
    uint256 randomNo3 = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty))) % getTraitWords.length;

    string memory moneyWordOnNFT = getMoneyWords[randomNo1];
    string memory placeWordOnNFT = getPlaceWords[randomNo2];
    string memory traitWordOnNFT = getTraitWords[randomNo3];
    string memory combinedWordsNFT = string(abi.encodePacked(moneyWordOnNFT,placeWordOnNFT,traitWordOnNFT)); 
    string memory finalSvg = string(abi.encodePacked(baseSvg, combinedWordsNFT, closeOfSvg));

    // Get all the JSON metadata in place and base64 encode it.
    string memory json = Base64.encode(
        bytes(
            string(
                abi.encodePacked(
                    '{"name": "',
                    combinedWordsNFT,
                    '", "description": "A distinct set of professional specialists, forward thinkers, underdogs, and the worlds most persistent, strong-willed individuals. (GNFinder)", "image": "data:image/svg+xml;base64,',
                    // Add data:image/svg+xml;base64 and then append our base64 encode our svg.
                    Base64.encode(bytes(finalSvg)),
                    '"}'
                )
            )
        )
    );
    string memory finalTokenUri = string(
        abi.encodePacked("data:application/json;base64,", json)
    );

    uint256 newItemId = _tokenIds.current();
    _tokenIds.increment();
    _safeMint(msg.sender, newItemId); 
    _setTokenURI(newItemId, finalTokenUri); 
    emit NewDigitalNomadNFTMinted(msg.sender, newItemId);

    // START OUTPUT
    console.log("CONGRATULATIONS Holder, your official NFT title is: ");
    console.log("\n--------------------");
    console.log(combinedWordsNFT);
    console.log("--------------------\n");
    console.log("A DigitalNoMadNFT w/ ID %s has been minted to %s", newItemId, msg.sender);
    console.log("\nfinalSvg: ");
    console.log(finalSvg);
    console.log("\n--------------------");
    console.log("finalTokenUri:");
    console.log(finalTokenUri);
    console.log("--------------------\n");
    // END OUTPUT

    return (combinedWordsNFT);
  }
  function getTotalNFTsMintedSoFar() public view returns(uint256) {
    return _tokenIds.current();
  }
}