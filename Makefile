APP=$(shell basename $(shell git remote get-url origin))
REGESTRY=sergiiops

VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)

TARGETOS=linux
TARGETARCH=amd64

format:
	gofmt -s -w ./

get:
	go get 

lint:
	gofmt -l ./ #показати файли з проблемами форматування
	go vet ./... #пошук потенційних помилок у коді

test:
	go test ./... -v

build:
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/PetrykSergii/kbot/cmd.appVersion=${VERSION}

images:
	docker build . -t ${REGESTRY}/${APP}:${VERSION}-${TARGETARCH}

push:
	docker push ${REGESTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	rm -f kbot
