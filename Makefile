all: fmt lint

fmt:
	@shfmt -i 2 -ci -w **/*.sh

lint:
	@shfmt -i 2 -ci -d **/*.sh
