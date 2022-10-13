#!/usr/bin/env bash

# function to clean up files and make executables
remake () {
    # echo -e "\ old files and making executables"
    make -s clean
    make -s >/dev/null 2>&1
}


echo -e "To remove colour from tests, set COLOUR to 1 in sh file\n"
COLOUR=0
if [[ COLOUR -eq 0 ]]; then
    ORANGE='\033[0;33m'
    GREEN='\033[0;32m'
    RED='\033[0;31m'
    NC='\033[0m'
else
    ORANGE='\033[0m'
    GREEN='\033[0m'
    RED='\033[0m'
    NC='\033[0m'
fi

SCORE=10

# if you made it here then it compiled lol
echo -e "\nStart testing"
echo -e "\nTesting :: Compilation\n"
echo -e "  ${GREEN}Passed${NC}"

remake
echo -e "\nTesting :: Try/Catch Used\n"
if [ $(grep -c "try" Runner.cpp) -ge 1 ]; then
    echo -e "  ${GREEN}Passed${NC}"
    SCORE=$(($SCORE+10))
else
    echo -e "  ${RED}Failed${NC}"
fi

echo -e "\nTesting :: Exceptions Used\n"
if [ $(grep -c "throw" Calculator.cpp) -ge 2 ]; then
    echo -e "  ${GREEN}Passed${NC}"
    SCORE=$(($SCORE+10))
else
    echo -e "  ${RED}Failed${NC}"
fi

# this includes a 0 length test case
remake
echo -e "\nTesting :: Invalid arguments provided to summation result in exception thrown\n"
echo "1 5 2 10" | ./Runner 2> error.txt >/dev/null
if grep -q "terminate" error.txt 2>/dev/null; then
    echo -e "  ${GREEN}Passed${NC}"
    SCORE=$(($SCORE+20))
else
    echo -e "  ${RED}Failed${NC}"
fi
rm error.txt

remake
echo -e "\nTesting :: Valid arguments provided to summation result in no exception\n"
echo "1 2 5 10" | ./Runner 2> result.txt > result2.txt
if grep -q "terminate" result.txt 2>/dev/null; then
    echo -e "  ${RED}Failed${NC}"
else
    if grep -q "40" result2.txt 2> /dev/null; then
      echo -e "  ${GREEN}Passed${NC}"
      SCORE=$(($SCORE+20))
    else
      echo -e "  ${RED}Failed${NC}"
    fi
fi
rm result.txt result2.txt
# will test for lots of processes, as well as processes that
# get multiple turns in a row
remake 2> warning.txt
echo -e "\nTesting :: Correct Output and no warnings\n"
echo "10 2 5 20" | ./Runner > result.txt
if grep -q warning.txt "warning" 2>/dev/null; then
    echo -e "  ${RED}Failed${NC}"
else
    if diff -q output.txt result.txt 2> /dev/null; then
       echo -e "  ${GREEN}Passed${NC}"
       SCORE=$(($SCORE+30))
    else
        echo -e "  ${RED}Failed${NC}"
    fi
fi
rm warning.txt result.txt

# print score and delete executable
echo -e "\nSCORE: ${SCORE}/100\n"
make -s clean

exit 0