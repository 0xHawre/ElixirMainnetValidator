#!/bin/bash 

docker kill elixir
docker rm elixir
docker pull elixirprotocol/validator

sleep 10 

# Find the validator.env file
file_path=$(find / -iname "$config_file" 2>/dev/null | head -n 1)
if [[ -z "$file_path" ]]; then
    echo "File $config_file not found. Please ensure the file exists."
    exit 1
fi

echo "Found $config_file at: $file_path"

# Run the Docker container
echo "Starting the Docker container..."
docker run -it \
  --env-file "$file_path" \
  --name elixir \
  elixirprotocol/validator

echo "Docker container 'elixir' started successfully using the configuration from $file_path"

