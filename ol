#!/bin/sh
hflg=0
dflg=0
xflg=0
oflg=0
gflg=0

while getopts hdxog: opt ;do
	case $opt in
		h)hflg=1;;
		d)dflg=1;;
		x)xflg=1;;
		o)oflg=1;;
		g)gflg=1;garg=$OPTARG;; 
	esac
done
shift $(($OPTIND - 1))

allrm 'ols.first ols1.out ols1.out.1 ols1.out.2 ols1.out.3 ols1.out.4 ols1.out.f ols2.out ols2.out.1 ols2.out.2 ols2.out.3 ols2.out.4 ols2.out.f ols3.out ols3.out.1 ols3.out.2 ols3.out.3 ols3.out.4 ols3.out.f ols.result'

if test $hflg -eq 1 ;then
	echo 'Usage: ol'
	exit 0
fi

if test $dflg -eq 1 ;then
	ls -CF1 | grep -E '\/$' | sed -E 's/^(.*)./\1/g' > ols.first
	cat ols.first | while read var ;do echo '\033[01;34m'${var}'\033[0;39m' >> ols1.out ;done
fi

if test $xflg -eq 1 ;then
	ls -CF1 | grep -E '\*$' | sed -E 's/^(.*)./\1/g' > ols.first
	cat ols.first | while read var ;do echo '\033[01;32m'$var'\033[0;39m' | grep -E -e '.*' >> ols2.out ;done
fi

if test $oflg -eq 1 ;then
	ls -CF1 | grep -E -v '\*$' | grep -E -v '\/$' > ols.first
	cat ols.first | while read var ;do echo $var | grep -E -e '.*' ;done >> ols3.out
	cat ols3.out | sed -E '/.*ols*/d' > ols3.out.bk
	mv ols3.out.bk ols3.out
fi

if test $# -eq 0 ;then
	ls -CF1 | grep -E '\/$' | sed -E 's/^(.*)./\1/g' > ols.first
	cat ols.first | while read var ;do echo '\033[01;34m'${var}'\033[0;39m' >> ols1.out ;done

	ls -CF1 | grep -E '\*$' | sed -E 's/^(.*)./\1/g' > ols.first
	cat ols.first | while read var ;do echo '\033[01;32m'$var'\033[0;39m' | grep -E -e '.*' >> ols2.out ;done

	ls -CF1 | grep -E -v '\*$' | grep -E -v '\/$' > ols.first
	cat ols.first | while read var ;do echo $var | grep -E -e '.*' ;done >> ols3.out
	cat ols3.out | sed -E '/.*ols*/d' > ols3.out.bk
	mv ols3.out.bk ols3.out

	if test -f ols1.out ;then
		mv ols1.out ols.result	
	elif test -f ols2.out ;then
		mv ols2.out ols.result
	elif test -f ols3.out ;then
		mv ols3.out ols.result
	fi

	if test -f ols2.out ;then
		cat ols2.out >> ols.result
	fi

	if test -f ols3.out ;then
		cat ols3.out >> ols.result
	fi

	if test $gflg -eq 1 ;then
		cat ols.result | grep -E $garg > ols.result.tmp
		mv ols.result.tmp ols.result
		allrm ols.result.tmp
	fi
	cat ols.result | less -iMSR

	allrm 'ols.first ols1.out ols1.out.1 ols1.out.2 ols1.out.3 ols1.out.4 ols1.out.f ols2.out ols2.out.1 ols2.out.2 ols2.out.3 ols2.out.4 ols2.out.f ols3.out ols3.out.1 ols3.out.2 ols3.out.3 ols3.out.4 ols3.out.f ols.result'
	exit 0
fi

if test -f ols1.out ;then
	mv ols1.out ols.result	
elif test -f ols2.out ;then
	mv ols2.out ols.result
elif test -f ols3.out ;then
	mv ols3.out ols.result
fi

if test -f ols2.out ;then
	cat ols2.out >> ols.result
fi

if test -f ols3.out ;then
	cat ols3.out >> ols.result
fi

if test -f ols.result ;then
	if test $gflg -eq 1 ;then
		cat ols.result | grep -E $garg > ols.result.tmp
		mv ols.result.tmp ols.result
		allrm ols.result.tmp
	fi
	cat ols.result | less -iMSR
else
	echo 'nobodys here'
fi

allrm 'ols.first ols1.out ols1.out.1 ols1.out.2 ols1.out.3 ols1.out.4 ols1.out.f ols2.out ols2.out.1 ols2.out.2 ols2.out.3 ols2.out.4 ols2.out.f ols3.out ols3.out.1 ols3.out.2 ols3.out.3 ols3.out.4 ols3.out.f ols.result'
