# Uncomment the following for installing IPFS, GoLang
# 
# sudo apt-get update
# sudo apt-get install golang-go -y
# wget https://dist.ipfs.io/go-ipfs/v0.4.13/go-ipfs_v0.4.13_linux-amd64.tar.gz
# tar xvfz go-ipfs_v0.4.13_linux-amd64.tar.gz
# sudo mv go-ipfs/ipfs /usr/local/bin/ipfs
# 

for i in `seq 1 $1`;
do 
    echo "Setting up node number : "$i
    IPFS_PATH=~/.ipfs$i ipfs init
done

cd swarmkey && go run main.go && cd ../

for i in `seq 1 $1`;
do
    echo "Copying the swarm key to node number : "$i
    cp swarmkey/swarm.key ~/.ipfs$i
done 

for i in `seq 1 $1`;
do
    IPFS_PATH=~/.ipfs$i ipfs bootstrap rm --all
done

# After this step do the following : 
# 1 . Add the hash address of your bootnode to each of the nodes including the bootnode.
#  >> IPFS_PATH=~/.ipfsNodeNumber ipfs bootstrap add /ip4/127.0.0.1/tcp/4001/ipfs/NodePeerIdentity
# 2 . Manually set up the ports of each node (ip4 & ip6) & replace the above port with them.


