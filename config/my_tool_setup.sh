#!/bin/bash

CONDA=/tool_deps/_conda/bin/conda
${CONDA} create -c bioconda --name __porechop@0.2.3_seqan2.1.1 porechop=0.2.3_seqan2.1.1
${CONDA} clean --all --yes

# porechop
FILE=/shed_tools/testtoolshed.g2.bx.psu.edu/repos/jdv/porechop/0cb1ba651e9e/porechop/porechop.xml
cp ${FILE} ${FILE}.org
cat ${FILE}.org |\
  sed -e "4,7d" | sed -e "7,10d" | sed -e "8,10d" |\
  sed -e "s/0.2.1/0.2.3_seqan2.1.1/g" \
  > ${FILE}

# centrifuge
FILE1=/shed_tools/testtoolshed.g2.bx.psu.edu/repos/jdv/centrifuge/b4f88058af70/centrifuge/centrifuge.xml
FILE2=/shed_tools/testtoolshed.g2.bx.psu.edu/repos/youyuh48/centrifuge_kreport/ccb90fac3605/centrifuge_kreport/centrifuge_kreport.xml
FILES=($FILE1 $FILE2)
for f in ${FILES[@]}; do
  cp ${f} ${f}.org
  cat ${f}.org | sed -e "s/centrifuge_indices/ctat_centrifuge_indexes/g" > ${f}
done
