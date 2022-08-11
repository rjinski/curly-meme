package main

import (
	"example.com/hello-world/src/server"
)

func main() {
	s := server.Server{Port: 8081, Message: "Hello World!"}
	s.Start()
}
