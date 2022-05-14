package main

import (
	"context"
	"log"
	"net"

	"github.com/peam1146/go_bazel_grpc/proto/echo"
	"github.com/peam1146/go_bazel_grpc/proto/echo2"
	"google.golang.org/grpc"
)

type EchoServerImpl struct {
	echo.UnimplementedEchoServer
}
type Echo2ServerImpl struct {
	echo2.UnimplementedEcho2Server
}

func (s *EchoServerImpl) SayHelloUnary(_ context.Context, request *echo.EchoRequest) (*echo.EchoReply, error) {
	log.Println("Hello" + request.Name)
	return &echo.EchoReply{Message: "Hello" + request.Name}, nil
}

func (s *Echo2ServerImpl) SayHelloUnary(_ context.Context, request *echo.EchoRequest) (*echo.EchoReply, error) {
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
	echo2.RegisterEcho2Server(s, &Echo2ServerImpl{})
	log.Printf("Starting server...")
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
