#!/bin/bash

set -e
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common gnupg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo systemctl enable docker
sudo systemctl start docker

sleep 10 

prompt_input() {
    local prompt_message=$1
    local var_name=$2
    read -p "$prompt_message: " input_value
    echo "$var_name=$input_value"
}

# Ask the user for inputs
env_var=$(prompt_input "Valid environments are 'prod' and 'testnet'. Choose your environment" "ENV")
name_var=$(prompt_input "Allowed characters A-Z, a-z, 0-9, _, -, and space. Enter STRATEGY_EXECUTOR_DISPLAY_NAME" "STRATEGY_EXECUTOR_DISPLAY_NAME")
beneficiary_var=$(prompt_input "Enter the Ethereum address to receive ELX rewards for this validator (STRATEGY_EXECUTOR_BENEFICIARY)" "STRATEGY_EXECUTOR_BENEFICIARY")
signer_key_var=$(prompt_input "Enter a private key used only for this validator (without '0x')" "SIGNER_PRIVATE_KEY")

# Save inputs to a file
echo -e "$env_var\n$name_var\n$beneficiary_var\n$signer_key_var" > validator.env

echo "Configuration saved to validator.env"

sleep 10 
docker pull elixirprotocol/validator

file_path=$(find / -iname "validator.env" 2>/dev/null | head -n 1)

if [[ -z "$file_path" ]]; then
    echo "validator.env file not found. Please ensure the file exists."
    exit 1
fi

echo "Found validator.env at: $file_path"

# Run the Docker container using the found file
docker run -it \
  --env-file "$file_path" \
  --name elixir \
  elixirprotocol/validator

echo "Docker container 'elixir' started using the configuration from $file_path"



