ifneq ($(features),)
FEATURES=$(features)
else
FEATURES=base64 compiler serde std
endif
ifneq ($(quiet),)
QUIET=$(quiet)
else
## 	:
## EXAMPLES:
## 	:
## --quiet is default
## this enables json only output for
## examples:
## psbt_sign_finalize
## for further testing scenarios
QUIET=--quiet
endif

## htlc
## parse
## psbt_sign_finalize
## sign_multisig
## taproot
## verify_tx
## xpub_descriptors

##
##make cargo-*
cargo-help:### 	cargo-help
	@awk 'BEGIN {FS = ":.*?###"} /^[a-zA-Z_-]+:.*?###/ {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
cargo-build:### 	cargo build
## 	make cargo-build q=true
	@. $(HOME)/.cargo/env
	@RUST_BACKTRACE=all cargo b $(QUIET)
cargo-install:### 	cargo install --path .
#@. $(HOME)/.cargo/env
	#@cargo install --path $(PWD)
	@cargo install --locked --path $(PWD)
cargo-br:cargo-build-release### 	cargo-br
## 	make cargo-br q=true
cargo-build-release:### 	cargo-build-release
## 	make cargo-build-release q=true
	@. $(HOME)/.cargo/env
	@cargo b $(QUIET) --profile=$(PROFILE)
cargo-profile-release-with-debug:### 	cargo-profile-release-with-debug
##:cargo-profile-release-with-debug
## cargo b --release profile=release-with-debug
	@. $(HOME)/.cargo/env
	$(MAKE) cargo-b profile=release-with-debug
cargo-check:### 	cargo-check
## cargo c
	@. $(HOME)/.cargo/env
	@cargo c
cargo-bench:### 	cargo-bench
## cargo b
##	cargo build --release
	@. $(HOME)/.cargo/env
	@cargo bench
cargo-test:### 	cargo-test
## cargo t
	@. $(HOME)/.cargo/env
	@cargo test
cargo-report:### 	cargo-report
	@. $(HOME)/.cargo/env
	cargo report future-incompatibilities --id 1
cargo-doc:### 	cargo-doc
	@cargo doc --no-deps --open

## htlc
## parse
## psbt_sign_finalize
## sign_multisig
## taproot
## xpub_descriptors
## verify_tx ## build last due to invoked error
## $ cargo run --quiet
##             --features="base64 compiler serde std"
##             --example psbt_sign_finalize

cargo-examples:cargo-htlc cargo-parse cargo-psbt_sign_finalize cargo-sign_multisig cargo-taproot cargo-xpub_descriptors cargo-verify_tx

cargo-htlc:### 	cargo-htlc
## @echo $(FEATURES)
	@cargo run $(QUIET) --features="$(FEATURES)" --example htlc

cargo-parse:### 	cargo-parse
## @echo $(FEATURES)
	@cargo run $(QUIET) --features="$(FEATURES)" --example parse

cargo-psbt_sign_finalize:### 	cargo-psbt_sign_finalize
## @echo $(FEATURES)
	@cargo run $(QUIET) --features="$(FEATURES)" --example psbt_sign_finalize

cargo-sign_multisig:### 	cargo-sign_multisig
## @echo $(FEATURES)
	@cargo run $(QUIET) --features="$(FEATURES)" --example sign_multisig

cargo-taproot:### 	cargo-taproot
## @echo $(FEATURES)
	@cargo run $(QUIET) --features="$(FEATURES)" --example taproot

cargo-verify_tx:### 	cargo-verify_tx
## @echo $(FEATURES)
	@cargo run $(QUIET) --features="$(FEATURES)" --example verify_tx

cargo-xpub_descriptors:### 	cargo-xpub_descriptors
## @echo $(FEATURES)
	@cargo run $(QUIET) --features=$(FEATURES) --example xpub_descriptors

# vim: set noexpandtab:
# vim: set setfiletype make
