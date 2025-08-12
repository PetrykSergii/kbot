VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)

TARGETOS=linux

format:
	gofmt -s -w ./

lint:
	gofmt -l ./ #показати файли з проблемами форматування
	go vet ./... #пошук потенційних помилок у коді

test:
	go test ./... -v

build:
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${shell dpkg --print-architecture} go build -v -o kbot -ldflags "-X="github.com/PetrykSergii/kbot/cmd.appVersion=${VERSION}

clean:
	rm -f kbot
	