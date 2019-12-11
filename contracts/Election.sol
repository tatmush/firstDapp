pragma solidity >=0.4.24 <0.7.0;

contract Election{
	//Model a candidate
	struct Candidate{
		uint id;
		string name;
		uint voteCount;
	}

	//store candidates
	//fetch candidates
	mapping (uint => Candidate) public candidates;

	//store accounts that have voted
	mapping (address => bool) public voters;

	//store candidates count
	uint public candidatesCount;

	constructor() public {
		addCandidate("Candidate 1");
		addCandidate("Candidate 2");
	}

	event votedEvent(
		uint indexed _candidateId
		);

	function addCandidate (string memory _name) private {
		candidatesCount++;
		candidates[candidatesCount]=Candidate(candidatesCount, _name, 0);
	}

	function vote(uint _candidateId) public{
		//require that they haven't voted before
		require(!voters[msg.sender]);

		//require a valid candidate
		require(_candidateId > 0 && _candidateId <= candidatesCount);

		//record that voter has voted
		voters[msg.sender]=true;

		//update candidate vote count;
		candidates[_candidateId].voteCount++;

		//trigger voted event
		emit votedEvent(_candidateId);
	}
} 