const express = require("express");
const Web3 = require("web3");
const bodyParser = require("body-parser");
const flash = require("connect-flash");
const fileUpload = require('express-fileupload');
const cors = require('cors');
const path = require('path');
const KYCService = require('./services/uploadKYC')


const app = express();


app.use(fileUpload());
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(flash());

app.get('/', function(req, res) {
    res.sendFile(path.join(__dirname + '/index.html'));
});
app.post('/api/admin/addDocument',KYCService.addDocument);

const PORT = process.env.PORT || 5000;

app.listen(PORT);
