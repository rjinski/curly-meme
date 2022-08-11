package server

import (
	"fmt"
	"log"
	"net/http"
)

type Server struct {
	Port    int
	Message string
}

func (s *Server) handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, s.Message)
}

func (s *Server) Start() {
	http.HandleFunc("/", s.handler)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%v", s.Port), nil))
}
