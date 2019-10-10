.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: test
test: test-sh test-docker ## run all tests

.PHONY: test-sh
test-sh:
ifeq (, $(shell which shellcheck))
    $(error "please install shellcheck")
endif
	@echo "~~ testing shell/bash ~~"
	@find . -name "*.sh" -exec shellcheck {} \;

.PHONY: test-docker
test-docker:
ifeq (, $(shell which hadolint))
    $(error "please install hadolint")
endif
	@echo "~~ testing dockerfiles ~~"
	@find . -name "Dockerfile" -exec hadolint {} \;
