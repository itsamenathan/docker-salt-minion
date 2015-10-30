NAME = itsamenathan/salt-minion
VERSION = 2015.8.1

.PHONY: all build test tag_latest release ssh

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm --no-cache=true --pull=true .

test:
	docker run --link salt-master-test:salt --rm $(NAME):$(VERSION) salt-minion -ldebug

tag_latest:
	docker tag -f $(NAME):$(VERSION) $(NAME):latest

release: tag_latest
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! head -n 1 Changelog.md | grep -q $(VERSION); then echo 'Please note the release date in Changelog.md.' && false; fi
	docker push $(NAME)
	@echo "*** Don't forget to create a tag. git tag v$(VERSION) && git push origin v$(VERSION)"

