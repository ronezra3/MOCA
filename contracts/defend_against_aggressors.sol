pragma solidity >=0.7.0 <0.9.0;

contract DefendAgainstAggressors {
    struct Agent {
        uint256 resources;
        bool isAggressor;
    }

    mapping(address => Agent) public agents;

    function addAgent(address agentAddress, bool isAggressor) public {
        agents[agentAddress] = Agent(100, isAggressor);
    }

    function attack(address attacker, address defender) public {
        require(agents[attacker].isAggressor, "Only aggressors can attack");
        require(agents[defender].resources > 0, "Defender has no resources");

        // Transfer resources from defender to attacker
        uint256 stolenResources = agents[defender].resources / 2;
        agents[defender].resources -= stolenResources;
        agents[attacker].resources += stolenResources;
    }

    function flee(address agentAddress) public {
        require(!agents[agentAddress].isAggressor, "Aggressors cannot flee");

        // Reset resources when fleeing
        agents[agentAddress].resources = 0;
    }
}
