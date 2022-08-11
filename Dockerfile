ARG GO_BUILD_IMAGE

from ${GO_BUILD_IMAGE} as build
workdir /app
copy main.go /app
copy src /app/src
run CGO_ENABLED=0 GOOS=linux go build -ldflags '-w -s' -a -installsuffix cgo -o helloworld

from scratch as run
expose 8081
workdir /app
copy --from=build /app/helloworld /app/helloworld
cmd ["/app/helloworld"]
