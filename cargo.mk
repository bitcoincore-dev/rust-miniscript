ifneq ($(features),)
FEATURES=$(features)
else
FEATURES='base64 compiler serde std'
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

cargo-examples:cargo-example-htlc cargo-example-parse cargo-example-psbt_sign_finalize cargo-example-sign_multisig cargo-example-taproot cargo-example-xpub_descriptors cargo-example-verify_tx
cargo-htlc:### 	cargo-example-htlc
	cargo run --features="base64 compiler serde std" --example htlc
cargo-parse:### 	cargo-example-parse
	cargo run --features="base64 compiler serde std" --example parse
cargo-psbt_sign_finalize:### 	cargo-example-psbt_sign_finalize
	cargo run --features="base64 compiler serde std" --example psbt_sign_finalize
cargo-sign_multisig:### 	cargo-example-sign_multisig
	cargo run --features="base64 compiler serde std" --example sign_multisig
cargo-taproot:### 	cargo-example-taproot
	cargo run --features="base64 compiler serde std" --example taproot
cargo-verify_tx:### 	cargo-example-verify_tx
	cargo run --features="base64 compiler serde std" --example verify_tx
cargo-xpub_descriptors:### 	cargo-example-xpub_descriptors
	cargo run --features=$(FEATURES) --example xpub_descriptors

# vim: set noexpandtab:
# vim: set setfiletype make
