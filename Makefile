
GITHASH=`git log -1 --pretty=format:"%h" || echo "???"`
CURDATE=`date -u +%Y%m%d.%H%M%S`
REPO_URL=github.com
ORG_NAME=gebv
REPO_NAME=ftp2s3

APPVERSION=${GITHASH}:${CURDATE}

docker-build:
	docker run -it --rm --name ${REPO_NAME}-app-make-build \
		-v "${PWD}":/go/src/${REPO_URL}/${ORG_NAME}/${REPO_NAME} \
		-w /go/src/${REPO_URL}/${ORG_NAME}/${REPO_NAME} \
		golang:1.9 make build
.PHONY: docker-build

build:
	go build \
			-o bin/ftp2s3 \
			-v \
			-ldflags "-X main.VERSION=${APPVERSION}" \
			-a ./ftp2s3.go
.PHONY: build

run:
	go run \
			-a ./ftp2s3.go \
			--config=myftp.conf
.PHONY: run