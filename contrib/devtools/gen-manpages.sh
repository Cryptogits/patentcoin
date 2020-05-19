#!/usr/bin/env bash
# Copyright (c) 2016-2019 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

PATENTCOIND=${PATENTCOIND:-$BINDIR/patentcoind}
PATENTCOINCLI=${PATENTCOINCLI:-$BINDIR/patentcoin-cli}
PATENTCOINTX=${PATENTCOINTX:-$BINDIR/patentcoin-tx}
WALLET_TOOL=${WALLET_TOOL:-$BINDIR/patentcoin-wallet}
PATENTCOINQT=${PATENTCOINQT:-$BINDIR/qt/patentcoin-qt}

[ ! -x $PATENTCOIND ] && echo "$PATENTCOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
read -r -a PCVER <<< "$($PATENTCOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }')"

# Create a footer file with copyright content.
# This gets autodetected fine for patentcoind if --version-string is not set,
# but has different outcomes for patentcoin-qt and patentcoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$PATENTCOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $PATENTCOIND $PATENTCOINCLI $PATENTCOINTX $WALLET_TOOL $PATENTCOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${PCVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${PCVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
