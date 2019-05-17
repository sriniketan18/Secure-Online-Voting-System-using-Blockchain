pragma solidity ^0.5.0;
contract Contest {
	struct Contestant {
		uint id;
		string name;
		uint votecount;
	}
	mapping(uint => Contestant) public contestants;
	mapping(address => bool) public voters;
	uint public contestantscount;

	event votedEvent (
        uint indexed _contestantId
    );
	
	constructor() public {
		addcontestant("Tom");
		addcontestant("Jerry");
	}
	
	function addcontestant (string memory _name) private {
		contestantscount++;
		contestants[contestantscount]= Contestant(contestantscount,_name,0);
	}
	function vote (uint _contestantId) public {
		//restricting the person who already casted the vote
		require(!voters[msg.sender]);
		//require that the vote is casted to a valid contestant
		require(_contestantId > 0 && _contestantId <= contestantscount);
		contestants[_contestantId].votecount ++;
		voters[msg.sender]= true;

		//trigger the vote event
		emit votedEvent(_contestantId);
	}

}
