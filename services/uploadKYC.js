const path = require("path");
const fs = require("fs");
const Web3 = require("web3");
const exec = require("child_process").exec;
const contractMeta = require("../config/contract.js");
const coinbaseAcnt = require("../config/coinbase.js");

if (!fs.existsSync(path.join(__dirname, "../tmp/"))) {
  fs.mkdirSync(path.join(__dirname, "../tmp/"));
}
var instance;
const web3 = new Web3(
  new Web3.providers.HttpProvider(
    "http://" + contractMeta.host + ":" + contractMeta.port
  )
);
if (web3.isConnected()) {
  console.log("JSON RPC connection established web3 object set");
} else {
  console.error("Please start the blockchain node");
}

function start() {
  var self = this;
  web3.eth.getAccounts(function(err, accs) {
    if (err != null) {
      errorMessage = "There was an error fetching your accounts.";
      return;
    }
    if (accs.length == 0) {
      errorMessage =
        "Couldn't get any accounts! Make sure your Ethereum client is configured correctly.";
      return;
    }
    accounts = accs;
    account = web3.eth.coinbase;

    console.log(instance);
  });
}


exports.addDocument = async (req, res) => {
console.log("BODY : ", req.files);
  const instance = web3.eth
    .contract(contractMeta.contractABI)
    .at(contractMeta.contractAddress);
  let KYC = req.files.filename;
  var hash;
  const name = "dummy.png";

  KYC.mv(path.join(__dirname, "../tmp/", name), function(err) {
    if (err) {
      return res.status(500).send(err);
    }
    const filePath = path.join(__dirname, "/../tmp/", name);
    // upload to IPFS
    exec(
      `IPFS_PATH=~/.ipfs1 ipfs add ${filePath}`,
      async (error, stdout, stderr) => {
        var words = stdout.split(" ");
        for (var i = 0; i < words.length; i++) {
          if (words[i][0] == "Q") hash = words[i];
        }
        console.log("HASH : ", hash);
        console.log("deleting : ", filePath);
        const ULock = await web3.personal.unlockAccount(
          coinbaseAcnt.publicKey,
          coinbaseAcnt.privateKey
        );
        const tx = await instance.uploadKYC(
          hash,
          { from: coinbaseAcnt.publicKey, gas: 2000000 }
        );
        await web3.personal.lockAccount(coinbaseAcnt.publicKey);

        fs.unlink(filePath, err => {
          if (err) throw err;
          res.send("ok");
        });
      }
    );
  });
};
