# KYC on IPFS

The file uploaded by the owner of the masternode as its KYC field will be stored off-chain on a private IPFS network.
The reason for this are as follows :  

1. Reduce in the load on blockchain as files will be stored off-chain thus resulting in better response time.  
2. IPFS uses merkle DAGS hence data cannot be tampered with & duplication of data can be avoided too.  
For further reading on IPFS click [here](https://docs.ipfs.io/)

## Design

A owner will upload a document, be it any kind of document (here we have considered a .PNG file  ).  
This doc will be uploaded to private IPFS network, only those with a key can join.
This upload will return a cryptographic hash which will be stored on the smart contract.
This hash will henceforward act as a sole handle to that file.

## For Developers

This repository is created for the purpose of setting up a private IPFS network.  
A simple node app is provided as a compliment to test out the the file upload feature & store the hash from IPFS in a smart contract.

**Note :** This app is only to understand the flow and should not be used as it is for any real application.

### Setting up the network

To setup the network follow the steps below :  

1. Open file setupIPFS.sh uncomment the code wherever it applies to you
2. In the root of the codebase directory, run the command <code> bash setupIPFS.sh n</code>, where n is the number of nodesyou want.
3. If the execution is successful, run the run.sh file.  

### Setting up endpoint
 1. Do ```npm install```  
 2. Create a file named coinbase.js & export its credentials  
 ( this is just for test application, **DO NOT** write your keys as plaintext in a real application )
 3. start the application by ```npm run server```
 4. Open localhost:5000 & upload any .png file.
 5. A hash will logged out in the console for server
 6. Open you image directly from ipfs by visiting ```http://127.0.0.1:808i/ipfs/QmZULkCELmmk5XNfCgTnCyFgAVxBRBXyDHGGMVoLFLiXEN```  ;
 where i = node number  
 Replace the hash with hash for your file.

