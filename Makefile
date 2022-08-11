DOCKER:=docker
HELM:=helm

APP_NAME:=hello-world
APP_IMAGE:=hello-world
APP_VERSION:=local

GO_BUILD_IMAGE:=golang:1.8

REMOTE_TARGET_REGISTRY:='hello-world'

# helpers
GIT_COMMIT_SHA=$(shell git log -1 --pretty=format:"%H")

.PHONY: build
build:
	$(DOCKER) build . \
		--file Dockerfile \
		--build-arg=GO_BUILD_IMAGE=$(GO_BUILD_IMAGE) \
		--tag $(APP_IMAGE):$(APP_VERSION)

.PHONY: run
run: build
	$(HELM) upgrade --install $(APP_NAME) \
		deploy \
		--values 'deploy/values.local.yaml' \
		--dependency-update

.PHONY: kill
kill:
	$(HELM) uninstall $(APP_NAME)

# publish - push the development build
# .PHONY: publish
# publish: build
# 	$(DOCKER) tag $(APP_IMAGE):$(APP_VERSION) $(REMOTE_TARGET_REGISTRY):$(GIT_COMMIT_SHA)
# 	# $(DOCKER) push $(REMOTE_TARGET_REGISTRY):$(GIT_COMMIT_SHA)

# release - makr the build as a named release/version
# .PHONY: release
# release: build
