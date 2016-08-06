#!/usr/bin/bash

echo "------------------------------------------"
echo -e "\033[32;1m - System-Überprüfung:\033[0m"
/usr/bin/env bats ./system.sh
echo "------------------------------------------"

while test $# -gt 0
do
	case "$1" in
		--jboss)
		echo "------------------------------------------"
		echo -e "\033[32;1m - JBoss-Überprüfung:\033[0m"
		/usr/bin/env bats ./jboss.sh
		echo "------------------------------------------"
			;;
		--liferay)
		echo "------------------------------------------"
		echo -e "\033[32;1m - Liferay-Überprüfung:\033[0m"
		/usr/bin/env bats ./liferay.sh
		echo "------------------------------------------"
			;;
		*)
			;;
	esac
	shift
done
