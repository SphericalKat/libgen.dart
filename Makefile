help: ## Show this help message
	@egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'

install: ## Installs dependencies
	pub get

analyze: ## Perform static analysis over lib/ test/
	dartanalyzer lib test

test: ## Run tests
	pub run test

test.offline: ## Run tests without "http" tagged ones
	pub run test -x http

test.http: ## Run tests with "http" tag
	pub run test -P http

coverage: ## Run tests with coverage
	pub run test --coverage=coverage
	pub global activate coverage
	pub global run coverage:format_coverage \
	  --lcov \
	  --in=coverage \
	  --out=coverage/lcov.info \
	  --packages=.packages \
	  --report-on=lib

coverage.html: ## Generate HTML view for coverage
	genhtml -o coverage coverage/lcov.info

.PHONY: help
.PHONY: test
