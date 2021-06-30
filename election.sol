pragma solidity ^0.4.21;

contract Election
{
    struct Candidate
    {
        uint id;
        string name;
        uint voteCount;
    }
    
    struct Voter
    {
        bool authorized;
        bool voted;
        uint vote;          //for which candidate, voter voted
    }
    
    address public owner;
    string public electionName;
    
    mapping(address=>bool) public voters;
    mapping(uint=>Candidate) public candidates;
    uint public totalVotes;
    uint private totalCandidate;
    
    modifier ownerOnly()
    {
        require(msg.sender==owner);
        _;
    }
    
    function Election(string _name) public
    {
        owner=msg.sender;
        electionName=_name;
        totalCandidate=0;
    }
    
    function addCandidate(string _name) public
    {
        require(msg.sender==owner);
        candidates[totalCandidate]=Candidate(totalCandidate, _name, 0);
        totalCandidate++;
    }
    
    function getNumCandidate() public view returns(uint)
    {
        return totalCandidate;
    }
    
    function vote(uint _candidateID) public
    {
        require(!voters[msg.sender]);
        require(_candidateID>=0 && _candidateID<=totalCandidate);
        
        voters[msg.sender]=true;
        
        candidates[_candidateID].voteCount+=1;
        totalVotes+=1;
    }
    
    function end() ownerOnly public
    {
        selfdestruct(owner);
    }
    
}


