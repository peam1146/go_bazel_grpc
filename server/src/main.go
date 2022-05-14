package main

import (
	"context"
	"log"
	"net"

	"github.com/peam1146/go_bazel_grpc/echo"
	"google.golang.org/grpc"
)

type EchoServerImpl struct {
	echo.UnimplementedEchoServer
}

func (s *EchoServerImpl) SayHelloUnary(_ context.Context, request *echo.EchoRequest) (*echo.EchoReply, error) {
	log.Println("Hello" + request.Name)
	return &echo.EchoReply{Message: "Hello" + request.Name}, nil
}

func main() {
	lis, err := net.Listen("tcp", ":3000")
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	s := grpc.NewServer()
	echo.RegisterEchoServer(s, &EchoServerImpl{})

	log.Printf("Starting server...")
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
