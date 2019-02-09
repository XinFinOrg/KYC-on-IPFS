# Installing IPFS, GoLang

sudo apt-get update
sudo apt-get install golang-go -y
wget https://dist.ipfs.io/go-ipfs/v0.4.13/go-ipfs_v0.4.13_linux-amd64.tar.gz
tar xvfz go-ipfs_v0.4.13_linux-amd64.tar.gz
sudo mv go-ipfs/ipfs /usr/local/bin/ipfs


# Remove tar file
rm -R go-ipfs_v0.4.13_linux-amd64.tar.gz
sudo mv ./go-ipfs $home