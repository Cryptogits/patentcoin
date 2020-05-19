NEWCOIN_LC="patentcoin"
NEWCOIN_MC="Patentcoin"
NEWCOIN_UC="PATENTCOIN"
NEWCOIN_SHORT="PC"

find . -type d -not -path "./.git*" | while read FILE ; do
	newfile=$(echo ${FILE} | sed -e "s/bitcoin/${NEWCOIN_LC}/") ;
	if [ "${FILE}" != "${newfile}" ]; then
		mv "${FILE}" "${newfile}" ;
	fi
done

find . -type f -not -path "./.git*" -not -path "./newcoin.sh" | while read FILE ; do
	echo "${FILE}"
	sed -i "s/BITCOIN/${NEWCOIN_UC}/g" ${FILE}
	sed -i "s/Bitcoin/${NEWCOIN_MC}/g" ${FILE}
	sed -i "s/bitcoin/${NEWCOIN_LC}/g" ${FILE}
	sed -i "s/BTC/${NEWCOIN_SHORT}/g" ${FILE}
	sed -i "s/${NEWCOIN_MC} Core dev/Bitcoin Core dev/g" ${FILE}

	newfile=$(echo ${FILE} |sed -e "s/bitcoin/${NEWCOIN_LC}/") ;
	if [ "${FILE}" != "${newfile}" ]; then
   		mv "${FILE}" "${newfile}" ;
	fi
done

# fixups
sed -i 's/Patentcoin/Bitcoin/g' ../src/util/message.cpp
sed -i 's/Patentcoin/Bitcoin/g' ../src/test/crypto_tests.cpp
