#include "Calculator.h"
#include <string>
#include <stdexcept>
/*
 * Input: Positive integer in the form of a string, num
 * Output: The factorial of num
 * Throws:
 *  invalid_argument if num is less than zero
 *  buffer_overflow if the result overflows an unsigned long (HINT: USE ULONG_MAX and logic from DIVIO homework)
 */
unsigned long factorial(std::string numStr) {
    int num = std::stoi(numStr);
    if(num == 1 || num == 0){
        return 1;
    }
    unsigned long res = num;
    for(int i = num - 1; i > 1; --i){
        res *= i;
    }
    return res;
}
/*
 * Input: Positive integer, num
 * Output: The factorial of num
 * Throws: invalid_argument if num is less than zero
 */
double summation(int start, int end, double num) {
    double sum = 0;
    for(int i = start; i <= end; ++i){
        sum += num;
    }
    return sum;
}


