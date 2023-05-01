# Blockchain_Task_Move

To run the Move file, you can follow these steps:

Install the Move CLI: You can follow the instructions provided on the Move CLI documentation to install the CLI on your Ubuntu machine.

Create a new project directory: Create a new directory for your project and navigate to it using the terminal.

Create a new Move module file: Create a new file with the extension ".move" in the project directory and copy the IDO module code into the file.

Compile the Move module: Use the Move CLI to compile the module by running the following command in the project directory:

move check <file_name>.move
This will check for syntax errors and type-check the module. If there are no errors, it will generate a compiled binary file with the extension ".mv".

Deploy the module to the testnet: Use the Move CLI to deploy the compiled binary to the testnet by running the following command:
move publish <file_name>.mv
This will deploy the module to the testnet and return an address for the module.

Interact with the deployed module: Once the module is deployed, you can interact with it using the Move CLI or by creating a client application that communicates with the module through the testnet.
To interact with the IDO module, you can use the following Move CLI commands:

To create a new sale:
move call <module_address> create_sale --arg 1651382400 --arg 1654060800 --arg 1000 --arg "[{value: 0123456789abcdef0123456789abcdef01234567}]" --arg 0x1
This will create a new sale with the specified start and end times, sale limit, whitelist of addresses, and owner.

To check if an address is whitelisted:
move call <sale_address> is_whitelisted --arg "{value: 0123456789abcdef0123456789abcdef01234567}"
This will return a boolean value indicating whether the specified address is whitelisted for the sale.

To buy tokens during the sale:
move call <sale_address> buy_tokens --arg 100
This will attempt to buy 100 tokens during the sale. The function will fail if the sale has ended, the purchase amount is over the sale limit, or the sender is not whitelisted.
