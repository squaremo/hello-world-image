PKG=github.com/weaveworks/helloworld

.PHONY: image
image: .done

.done: Dockerfile ./build/bin/server logo.png index.template
	cp ./build/bin/server ./
	docker build -t weaveworks/hello-world .
	touch .done

./build/bin/server: server.go
	rm -rf ./build
	mkdir -p ./build/src/$(PKG)
	cp $^ ./build/src/$(PKG)/
	CGO_ENABLED=0 GOPATH=$(PWD)/build go build -o $@ $(PKG)

.PHONY: clean
clean:
	rm -rf ./build
