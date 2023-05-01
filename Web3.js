// Import Web3.js library
const Web3 = require('web3');

// Set up connection to network
const web3 = new Web3('https://ropsten.infura.io/v3/your-project-id');

// Set up contract object
const contractAddress = '0x1234567890123456789012345678901234567890';
const contractAbi = [/* Contract ABI here */];
const contract = new web3.eth.Contract(contractAbi, contractAddress);

// Call a contract function
const functionName = 'myFunction';
const functionArgs = [arg1, arg2, arg3]; // Arguments for function call
const result = await contract.methods[functionName](...functionArgs).call();
console.log(result);

// Send a transaction to a contract function
const privateKey = '0x0123456789012345678901234567890123456789012345678901234567890123'; // Private key for sender address
const senderAddress = '0x1234567890123456789012345678901234567890'; // Sender address
const nonce = await web3.eth.getTransactionCount(senderAddress); // Get current nonce for sender address
const gasPrice = await web3.eth.getGasPrice(); // Get current gas price
const gasLimit = 1000000; // Set gas limit for transaction
const txObject = {
  nonce: web3.utils.toHex(nonce),
  gasPrice: web3.utils.toHex(gasPrice),
  gasLimit: web3.utils.toHex(gasLimit),
  to: contractAddress,
  data: contract.methods[functionName](...functionArgs).encodeABI()
};
const signedTx = await web3.eth.accounts.signTransaction(txObject, privateKey);
const txHash = await web3.eth.sendSignedTransaction(signedTx.rawTransaction);
console.log(txHash);
