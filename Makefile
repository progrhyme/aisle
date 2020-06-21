.PHONY: test clean shove

SHELLS := sh bash zsh dash ksh
SHOVE  := vendor/shove/bin/shove

test: shove
	@for sh in $(SHELLS); do \
		if [ -x "$$(which $$sh)" ]; then \
			$(SHOVE) -r t -v -s $$sh; \
		else \
			echo "Skip $$sh"; \
			continue; \
		fi \
	done

clean:
	rm -rf vendor

shove: vendor
	@echo checkout or update vendor/shove
	@if [ -d vendor/shove ]; then \
		cd vendor/shove && git pull origin master; \
	else \
		git clone --depth=1 https://github.com/progrhyme/shove.git vendor/shove; \
	fi

vendor:
	mkdir vendor
