pragma solidity >=0.7.0 <0.9.0;

contract Cleanup {
    struct Agent {
        uint balance;
        uint garbageCleaned;
    }

    mapping(address => Agent) public agents;
    address[] public agentAddresses;
    uint public totalGarbageCleaned = 0;
    uint public rewardPerGarbage = 1 ether;

    function registerAgent() public {
        Agent memory newAgent;
        newAgent.balance = 0;
        newAgent.garbageCleaned = 0;
        agents[msg.sender] = newAgent;
        agentAddresses.push(msg.sender);
    }

    function cleanGarbage() public {
        require(agents[msg.sender].balance >= rewardPerGarbage, "Insufficient balance to clean garbage");
        agents[msg.sender].garbageCleaned += 1;
        totalGarbageCleaned += 1;
        distributeRewards();
    }

    function distributeRewards() private {
        uint reward = rewardPerGarbage / totalGarbageCleaned;
        for (uint i = 0; i < agentAddresses.length; i++) {
            address agentAddress = agentAddresses[i];
            agents[agentAddress].balance += reward;
        }
    }

    function getBalance() public view returns (uint) {
        return agents[msg.sender].balance;
    }

    function getGarbageCleaned() public view returns (uint) {
        return agents[msg.sender].garbageCleaned;
    }
}
