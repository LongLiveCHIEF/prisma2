#!/bin/sh

if [ $CARGO_CRATES_INDEX != "cargo.io" ]; then
	echo "using specified crates mirror"
	mkdir /prisma-engine/.cargo
	cat << EOF > /prisma-engine/.cargo/config
[source]

[source.mirror]
registry = "$CARGO_SOURCE_PROTOCOL://$CARGO_CRATES_INDEX/crates.io-index"

[source.crates-io]
replace-with = "mirror"
EOF

else
 echo "using default crates index"
fi
