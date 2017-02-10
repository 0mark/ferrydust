#/bin/bash

replace="sed "
for prefix in ETCPREFIX SBINPREFIX BINPREFIX LIBPREFIX ACPIPREFIX UDEVPREFIX SHAREPREFIX PREFIX SHELL_FULL SHELL_SIMPLE; do
	replace="${replace}s#$prefix#${1}#g;"
	shift
done
replace="$replace"

#sed "s#LIBPREFIX#${LIBPREFIX}#g" < fd-pm-now > ${DESTDIR}${BINPREFIX}/fd-pm-now

source=$1
shift

target=$1
shift

mode=$1
shift

for file in $@; do
	$replace < $source/$file > $target/$file
	chmod $mode $target/$file
done
