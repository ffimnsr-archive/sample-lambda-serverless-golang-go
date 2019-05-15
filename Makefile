default: build

.PHONY: build clean test push.upload push.s3

build:
	@echo "creating binaries..."
	@mkdir -p dist
	@GOOS=linux go build -o dist/main main.go

clean:
	@echo "cleaning binaries..."
	@rm -rf dist

test:
	@echo "running tests..."
	@go test

push.upload:
	@echo "creating deploy package..."
	@cd dist && zip deploy.zip main
	@echo "pushing package to lambda..."
	@aws lambda update-function-code --function-name setuser --zip-file fileb://dist/deploy.zip --profile hypercapital

push.s3:
	@echo "creating deploy package..."
	@cd dist && zip deploy.zip main
	@echo "uploading package to S3..."
	@aws s3 cp dist/deploy.zip s3://store-deploy-se/ --profile hypercapital
	@echo "pushing package to lambda..."
	@aws lambda update-function-code --function-name setuser --s3-bucket store-deploy-se --s3-key deploy.zip --profile hypercapital
