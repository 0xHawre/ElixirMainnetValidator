# Elixir Main-net  Validator Setup

## Overview

This guide will walk you through the steps to set up a validator for the Elixir main-net. The provided Bash script will automate the process of checking for Docker, installing it if necessary, and configuring the environment variables needed to run your validator.

## Hardware Requirements

To run a validator node on the Elixir Testnet v3, it's recommended that you have the following:

- **Memory**: 8GB of RAM
- **Internet Connection**: Reliable 100Mbit
- **Storage**: 100GB of available disk space
- **Availability**: 24/7 uptime

## Prerequisites

Before running the validator, ensure that Docker is installed on your system. If Docker is not installed, the script will automatically install it for you.

## Validator Private Key Generation

To run your validator, you will need a private key. It's recommended to use a dedicated wallet for this purpose.

### Steps to Generate a Private Key in MetaMask:

1. Open MetaMask.
2. Click on the "My Accounts" icon in the top right.
3. Select "+ Create Account."
4. To export the private key, go to "Account Details" from the ellipsis menu and click "Export private key."

**Note:** This wallet should be exclusively used for running the validator.

## Running the Validator Setup Script

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/0xHawre/ElixirMainnetValidator.git && cd ElixirMainnetValidator && chmod +x script.sh  
   ```

2. **Run the Setup Script:**

   Execute the script to check for Docker, install it if necessary, and configure the validator:

   ```bash
   ./script.sh
   ```

   The script will prompt you for the following information:
   - **STRATEGY_EXECUTOR_DISPLAY_NAME**: The public-facing name for you or your organization.
   - **STRATEGY_EXECUTOR_BENEFICIARY**: The wallet address to receive your Elixir Network validator rewards.
   - **SIGNER_PRIVATE_KEY**: The private key generated for the validator.

   These details will be saved in a file named `validator.env`.

### Upgrading your validator
As the Elixir team continues to improve the validator during the lead up to Mainnet launch, you may need to pull the latest version of the validator.  To do so, open a command line in the directory with your Dockerfile and execute the following commands:

### update by scipt 
```bash 
chmod +x update.sh && ./update.sh
```

