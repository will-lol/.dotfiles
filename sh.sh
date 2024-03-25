#!/bin/sh

# This script installs the Nix package manager on your system by
# downloading a binary distribution and running its installer script
# (which in turn creates and populates /nix).

{ # Prevent execution if this script was only partially downloaded
oops() {
    echo "$0:" "$@" >&2
    exit 1
}

umask 0022

tmpDir="$(mktemp -d -t nix-binary-tarball-unpack.XXXXXXXXXX || \
          oops "Can't create temporary directory for downloading the Nix binary tarball")"
cleanup() {
    rm -rf "$tmpDir"
}
trap cleanup EXIT INT QUIT TERM

require_util() {
    command -v "$1" > /dev/null 2>&1 ||
        oops "you do not have '$1' installed, which I need to $2"
}

case "$(uname -s).$(uname -m)" in
    Linux.x86_64)
        hash=d4d747147cb981987b3d405f31b2ad5a68c8ba64c6d2776e7233fe891ff629a1
        path=srhzv1pjg2z49szxbx99qs6ani2chgw3/nix-2.21.0-x86_64-linux.tar.xz
        system=x86_64-linux
        ;;
    Linux.i?86)
        hash=a03890063b0d172b91c6ad995d7288b91ef05ad86e6b273c911233844808d557
        path=0zmf7980qxc96bcph5a4z76mg8bl5dj8/nix-2.21.0-i686-linux.tar.xz
        system=i686-linux
        ;;
    Linux.aarch64)
        hash=6be72d4ee2e72eaaaafc708e8c8b0dc2a83d8db094c6a1cc0c4d604f2f36b79e
        path=3phkskl590vmk8k9m4k67psl79hrrqig/nix-2.21.0-aarch64-linux.tar.xz
        system=aarch64-linux
        ;;
    Linux.armv6l)
        hash=1c6f42bb69840829fc2cdb8f97f371859420b0c60c70228a1c5b15e77d27d726
        path=6awf4slyvzy6adr2sx4lmf9gy7lfyx27/nix-2.21.0-armv6l-linux.tar.xz
        system=armv6l-linux
        ;;
    Linux.armv7l)
        hash=4aa2bc85face65856080db75c22684aeac1aa427364305ac024c5cd2466f9a23
        path=lmz4nm1dbnhbpgzibhbv0qr7lsap2jbz/nix-2.21.0-armv7l-linux.tar.xz
        system=armv7l-linux
        ;;
    Darwin.x86_64)
        hash=5cac5a03931c8f734e306cc05ff7e563c4ba820afd7c8878da8debed018065b1
        path=1s81jl0ca0d9iilg3v7im0zq7njdr1v4/nix-2.21.0-x86_64-darwin.tar.xz
        system=x86_64-darwin
        ;;
    Darwin.arm64|Darwin.aarch64)
        hash=5e5c77a6384cb8b25e71b5a60461db23b32098b1e8d9618e97a0d09269a30fcd
        path=lb0fm415siwky0a9ayrm3l50m4qb15s1/nix-2.21.0-aarch64-darwin.tar.xz
        system=aarch64-darwin
        ;;
    *) oops "sorry, there is no binary distribution of Nix for your platform";;
esac

# Use this command-line option to fetch the tarballs using nar-serve or Cachix
if [ "${1:-}" = "--tarball-url-prefix" ]; then
    if [ -z "${2:-}" ]; then
        oops "missing argument for --tarball-url-prefix"
    fi
    url=${2}/${path}
    shift 2
else
    url=https://releases.nixos.org/nix/nix-2.21.0/nix-2.21.0-$system.tar.xz
fi

tarball=$tmpDir/nix-2.21.0-$system.tar.xz

require_util tar "unpack the binary tarball"
if [ "$(uname -s)" != "Darwin" ]; then
    require_util xz "unpack the binary tarball"
fi

if command -v curl > /dev/null 2>&1; then
    fetch() { curl --fail -L "$1" -o "$2"; }
elif command -v wget > /dev/null 2>&1; then
    fetch() { wget "$1" -O "$2"; }
else
    oops "you don't have wget or curl installed, which I need to download the binary tarball"
fi

echo "downloading Nix 2.21.0 binary tarball for $system from '$url' to '$tmpDir'..."
fetch "$url" "$tarball" || oops "failed to download '$url'"

if command -v sha256sum > /dev/null 2>&1; then
    hash2="$(sha256sum -b "$tarball" | cut -c1-64)"
elif command -v shasum > /dev/null 2>&1; then
    hash2="$(shasum -a 256 -b "$tarball" | cut -c1-64)"
elif command -v openssl > /dev/null 2>&1; then
    hash2="$(openssl dgst -r -sha256 "$tarball" | cut -c1-64)"
else
    oops "cannot verify the SHA-256 hash of '$url'; you need one of 'shasum', 'sha256sum', or 'openssl'"
fi

if [ "$hash" != "$hash2" ]; then
    oops "SHA-256 hash mismatch in '$url'; expected $hash, got $hash2"
fi

unpack=$tmpDir/unpack
mkdir -p "$unpack"
tar -xJf "$tarball" -C "$unpack" || oops "failed to unpack '$url'"

script=$(echo "$unpack"/*/install)

[ -e "$script" ] || oops "installation script is missing from the binary tarball!"
export INVOKED_FROM_INSTALL_IN=1
"$script" "$@"

} # End of wrapping
