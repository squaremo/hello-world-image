PKG=github.com/weaveworks/helloworld

.PHONY: image
image: ./build/bin/server logo.png
	cp ./build/bin/server ./
	docker build -t weaveworks/hello-world .

./build/bin/server: server.go
	rm -rf ./build
	mkdir -p ./build/src/$(PKG)
	cp $^ ./build/src/$(PKG)/
	GOPATH=$(PWD)/build go build -o $@ $(PKG)
