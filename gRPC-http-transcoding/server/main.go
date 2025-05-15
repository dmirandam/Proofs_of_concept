package main

import (
	"context"
	"log"
	"net"

	pb "calc-demo/server" // ruta al stub generado

	"google.golang.org/grpc"
)

type calcSrv struct {
	pb.UnimplementedCalculatorServer
}

func (c *calcSrv) Add(ctx context.Context, req *pb.AddRequest) (*pb.AddResponse, error) {
	return &pb.AddResponse{Result: req.GetA() + req.GetB()}, nil
}

func main() {
	lis, err := net.Listen("tcp", ":50051")
	if err != nil {
		log.Fatal(err)
	}
	s := grpc.NewServer()
	pb.RegisterCalculatorServer(s, &calcSrv{})
	log.Println("gRPC listening on :50051")
	log.Fatal(s.Serve(lis))
}