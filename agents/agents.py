from agentgpt import AgentGPT

# Initialize the agents
agent1 = AgentGPT(model_name="gpt3", use_cuda=False)
agent2 = AgentGPT(model_name="gpt3", use_cuda=False)

# Initialize the environment
garbage = 10
reward = 0

# Each agent interacts with the environment multiple times
for i in range(10):
    # Generate a response to a prompt
    prompt1 = f"You are an agent in a virtual environment. There are {garbage} pieces of garbage. You can either clean up garbage or do nothing. If you clean up garbage, you receive a reward from the other agents. What do you do?"
    response1 = agent1.generate(prompt1)
    print("Agent 1: ", response1)

    # Update the environment based on the agent's action
    if response1 == "clean up garbage":
        garbage -= 1
        reward += 1

    # Generate a response to a prompt
    prompt2 = f"You are an agent in a virtual environment. Another agent has just cleaned up some garbage and received a reward. There are {garbage} pieces of garbage left. You can either clean up garbage or do nothing. What do you do?"
    response2 = agent2.generate(prompt2)
    print("Agent 2: ", response2)

    # Update the environment based on the agent's action
    if response2 == "clean up garbage":
        garbage -= 1
        reward += 1
