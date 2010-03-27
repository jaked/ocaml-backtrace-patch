#!/bin/sh

printf "%s" "Checking for patch directory... "
patchdir=`dirname $0`
if grep -q backtrace $patchdir/README; then
    echo "found"
else
    echo "not found"
    echo "It doesn't look like your patch directory is complete."
    echo "Please follow the instructions in the README."
    exit 1
fi

printf "%s" "Checking for OCaml source... "
if [ -f VERSION ]; then
    echo "found"
    src_version=`head -1 VERSION`
else
    echo "not found"
    echo "This doesn't look like an OCaml source tree."
    echo "Please follow the instructions in the README."
    exit 1
fi

printf "%s" "Checking OCaml version... "
case $src_version in
    3.10.0|3.10.1|3.10.2)
        echo "$src_version ok"
        src_version=3.10.2
        ;;
    3.11.0|3.11.1)
        echo "$src_version ok"
        src_version=3.11.1
        ;;
    3.11.2)
        echo "$src_version ok"
        src_version=3.11.2
        ;;
    *)
        echo "unsupported version $src_version"
        echo "Sorry."
        exit 1
esac

printf "%s" "Patching source and promoting..."

./configure 2>&1 | awk -W interactive '{ if (x++ % 10 == 0) printf "." }'
patch -p1 < $patchdir/patch-$src_version >/dev/null 2>&1
make core promote 2>&1 | awk -W interactive '{ if (x++ % 10 == 0) printf "." }'
patch -p1 < $patchdir/patch2-$src_version >/dev/null 2>&1

echo " done!"
echo "Now build OCaml as usual."
