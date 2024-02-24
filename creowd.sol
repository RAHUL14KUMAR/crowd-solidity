// SPDX-License-Identifier: UNLICENSED
pragma Solidity >=0.5.0 <0.9.0

contract crowdfunding{

    mapping(address=>uint) public contributors;
    address public manager;
    uint public minimumContributuion;
    uint public deadLine;
    uint public target;
    uint public raisedAmount;
    uint public noOfContribution;

    struct request{
        string description;
        address payable receipient;
        uint value;
        uint completed;
        uint noOfVoters;
        mapping(address=>bool) voters;
    }

    mapping(uint=>request) public requests;
    uint public newRequests;

    constructor(uint _target,uint _deadline){
        target=_target;
        deadline=block.timestamp+_deadline;
        minimumContributuion=100 wei;
        manager=msg.sender;
    }

    modifier onlyManager{
        require(msg.sender==manager,"only manager can do");
        _;
    }


    function sendEth() public payable{
        require(block.timestamp<deadline,"deadline has been ended");
        require(msg.value>=minimumContributuion,"minimum amount doesnt meet");

        if(contributors[msg.sender]==0){
            noOfContribution++;
        }

        contributors[msg.sender]+=msg.value;
        raisedAmoun+=msg.value;
    }

    function getContractBalance() public onlyManager view returns(uint){
        return address(this).balance;
    }

    function refund() public{
         require(block.timestamp>deadline && raisedAmount<target);
         require(contributors[msg.sender]>0);
         address payable user=patyable(msg.sender);
         user.transfer(contributors[msg.sender]);
         contributors[msg.sender]=0;
    }

    function createRequest(address memory _description, address payable _receipent,uint _value) public onlyManager{

    }
}