// SPDX-License-Identifier: MIT 
pragma solidity >0.8.0;
pragma experimental ABIEncoderV2;

contract Voter{

    struct OptionPos{
        uint pos;
        bool exists;
    }
    uint[] public votes;
    string[] public options;
    mapping (address => bool) hasVoted;
    mapping (string => OptionPos) posOfOption;

    constructor(string[] memory _options) {
        options = _options;
        votes = new uint[](options.length);

        for(uint i = 0; i < options.length; i++){
            OptionPos memory option = OptionPos(i, true);
            posOfOption[options[i]] = option;
        }
    }

    function voteCode(uint option) public{
        require(0 <= option && option < options.length, "Invalid Options");
        require(!hasVoted[msg.sender], "Desculpe, esta conta ja votou.");
        
        votes[option] = votes[option] + 1;
        hasVoted[msg.sender] = true;
    }

    function voteName(string memory option) public{
        require(!hasVoted[msg.sender], "Desculpe, esta conta ja votou.");
        OptionPos memory OptionPosition = posOfOption[option];
        require(OptionPosition.exists, "A opcao nao existe");

        hasVoted[msg.sender] = true;
        votes[OptionPosition.pos] = votes[OptionPosition.pos]+1;

    }

    function getOptions() public view returns (string[] memory){
        return options;
    }

    function getVotes() public view returns (uint[] memory){
        return votes;
    }

}
