// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    mapping(address => bool) public voters;
    mapping(string => uint256) public votesReceived;
    string[] public candidateList;

    event Vote(address indexed _voter, string _candidate);

    constructor(string[] memory _candidates) {
        candidateList = _candidates;
    }

    function vote(string memory _candidate) public {
        require(!voters[msg.sender], "You have already voted.");
        require(validCandidate(_candidate), "Invalid candidate.");

        voters[msg.sender] = true;
        votesReceived[_candidate]++;
        emit Vote(msg.sender, _candidate);
    }

    function totalVotesFor(string memory _candidate) public view returns (uint256) {
        require(validCandidate(_candidate), "Invalid candidate.");
        return votesReceived[_candidate];
    }

    function validCandidate(string memory _candidate) internal view returns (bool) {
        for (uint256 i = 0; i < candidateList.length; i++) {
            if (keccak256(bytes(candidateList[i])) == keccak256(bytes(_candidate))) {
                return true;
            }
        }
        return false;
    }
}
