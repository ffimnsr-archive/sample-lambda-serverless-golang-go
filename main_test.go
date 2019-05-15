package main

import (
	"context"
	"testing"

	"github.com/aws/aws-lambda-go/events"
	"github.com/stretchr/testify/assert"
)

func TestHandler(t *testing.T) {
	req := events.APIGatewayProxyRequest{
		Path:       "/ping",
		HTTPMethod: "GET",
	}

	resp, err := Handler(context.Background(), req)

	assert.IsType(t, nil, err)
	assert.Equal(t, resp.StatusCode, 200)
}
