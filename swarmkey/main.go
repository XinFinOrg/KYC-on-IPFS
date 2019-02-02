package main

import (
	"crypto/rand"
	"encoding/hex"
	"io/ioutil"
	"log"
)

func main() {
	key := make([]byte, 32)
	_, err := rand.Read(key)
	if err != nil {
		log.Fatalln("Error while reading from random source:", err)
	}
	data := []byte("/key/swarm/psk/1.0.0/\n/base16/\n" + hex.EncodeToString(key))
	newErr := ioutil.WriteFile("./swarm.key", data, 0644)
	if newErr != nil {
		panic(newErr)
	}
}
