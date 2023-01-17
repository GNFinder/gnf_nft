// SPDX-License-Identifier: UNLICENSED
/** 
    @title pickRandomWords v1.0.0
    @author Jamal Forbes (Senior Solidity Developer) <https://github.com/GNFinder>
    @notice Provides the project's function for providing "randomness" in Solidity
    Something which is very complex as all information is stored publically and is deterministic (easy to predict).
    @audit by Jamal Forbes (Senior Solidity Developer) <https://github.com/GNFinder> - 
    @dev the functions randomMoneyWord, randomTraitWord & randomPlaceWord are using x3 gas 
    Compared to pickRandomWords, a singular funtion that grabs all three words from each array.
***/
import "hardhat/console.sol";
pragma solidity 0.8.17;
contract randomNFTWord {
  // string[12] internal getMoneyWords = ["Money", "Finance", "Mula", "Rich", "Wealthy", "Loaded", "Spender", "Millionaire", "Billionaire", "Trillionaire", "Investor", "Whale"]; // Your financial future according to the metaverse
  // string[13] internal getPlaceWords = ["Jamaica", "Hawaii", "Egypt", "Mexico", "Portugal", "Rome", "Paris", "Holland", "London", "Miami", "Dubai", "Maldives", "London"]; // Places to go when you reach your goals
  // string[12] internal getTraitWords = ["Earner", "Developer", "Learner", "Giving", "Entrepreneur", "Hustler", "Boss", "Helper", "Visionary", "Nomad", "Provider", "Shark"]; // Your secret trait
constructor() payable {}
    function pickRandomWords() public payable returns (string memory, string memory, string memory) {
      // @dev Moving string variable to local memory as it saves appx. 524377 gas on deployment, and 5453 per function call.
        string[12] memory getMoneyWords = ["Money", "Finance", "Mula", "Rich", "Wealthy", "Loaded", "Spender", "Millionaire", "Billionaire", "Trillionaire", "Investor", "Whale"]; // Your financial future according to the metaverse
        string[13] memory getPlaceWords = ["Jamaica", "Hawaii", "Egypt", "Mexico", "Portugal", "Rome", "Paris", "Holland", "London", "Miami", "Dubai", "Maldives", "London"]; // Places to go when you reach your goals
        string[12] memory getTraitWords = ["Earner", "Developer", "Learner", "Giving", "Entrepreneur", "Hustler", "Boss", "Helper", "Visionary", "Nomad", "Provider", "Shark"]; // Your secret trait
          // @dev: Generate a random number from blockhash between 0 and the length of the array for each array
        uint256 randomNo1 = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty))) % getMoneyWords.length;
        uint256 randomNo2 = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty))) % getPlaceWords.length;
        uint256 randomNo3 = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty))) % getTraitWords.length;
        // @dev: Use the random number as an index to pick a word from each array
        string memory moneyWordOnNFT = getMoneyWords[randomNo1];
        string memory placeWordOnNFT = getPlaceWords[randomNo2];
        string memory traitWordOnNFT = getTraitWords[randomNo3];
        console.log(moneyWordOnNFT, placeWordOnNFT, traitWordOnNFT);
        return (moneyWordOnNFT,placeWordOnNFT,traitWordOnNFT);
    } 
}