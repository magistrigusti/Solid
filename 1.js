const pinataSDK = require('@pinata/sdk');
const pinata = pinataSDK('ключ', 'значение');
const fs = require('fs');

const readableStreamForFile = fs.createReadStream('./1.img');

const options = {
  pinataMetadata: {
    name: "test"
  },
  pinataOptions: {
    cidVersion: 1
  }
};

pinata.pinFileToIPFS(readableStreamForFile, options).then((result) => {
  console.log(result);
}).catch((err) => {
  console.log(err);
})