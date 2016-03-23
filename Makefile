PKG=github.com/weaveworks/helloworld

.PHONY: images
images: .latest.done .alpine.done

.latest.done: Dockerfile ./build/bin/server logo.png index.template
	cp ./build/bin/server ./
	docker build -t weaveworks/hello-world .
	touch $@

.alpine.done: Dockerfile.alpine ./build/bin/server logo.png index.template
	cp ./build/bin/server ./
	docker build -t weaveworks/hello-world:alpine -f Dockerfile.alpine .
	touch $@

./build/bin/server: server.go
	rm -rf ./build
	mkdir -p ./build/src/$(PKG)
	cp $^ ./build/src/$(PKG)/
	GOOS=linux CGO_ENABLED=0 GOPATH=$(PWD)/build go build -o $@ $(PKG)

.PHONY: clean
clean:
	rm -rf ./build ./.done ./server
