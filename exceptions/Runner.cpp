#include <iostream>
#include <stdexcept>
#include <string>
#include "Calculator.h"

using namespace std;
//Only add Try/Catches to *factorial* do not modify how the program operates
int main(){
    string numStr; //do not change type
    cin >> numStr;
    cout << factorial(numStr) << endl;
    int start, end;
    double num;
    cin >> start >> end >> num;
    cout << summation(start, end, num) << endl;
    return 0;
}
