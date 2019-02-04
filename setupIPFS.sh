# Uncomment the following for installing IPFS, GoLang
# 
# sudo apt-get update
# sudo apt-get install golang-go -y
# wget https://dist.ipfs.io/go-ipfs/v0.4.13/go-ipfs_v0.4.13_linux-amd64.tar.gz
# tar xvfz go-ipfs_v0.4.13_linux-amd64.tar.gz
# sudo mv go-ipfs/ipfs /usr/local/bin/ipfs
# 
# Uncomment below to remove tar file
# 
# rm -R go-ipfs_v0.4.13_linux-amd64.tar.gz
# sudo mv ./go-ipfs $home

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


if [ ! -d "./nodes" ]; then
    echo "Creating file "
    mkdir nodes 
fi

cd nodes

for i in `seq 1 $1`;
do
    touch node$i.sh
    echo " export LIBP2P_FORCE_PNET=1 && IPFS_PATH=~/.ipfs$i ipfs daemon" > node$i.sh
done

for i in `seq 1 $1`;
do
    sed -i -e "s/4001/400$i/;s/5001/500$i/;s/8080/808$i/g" ~/.ipfs$i/config
done

printf "Done :)\nNow run the run.sh file.\n"

