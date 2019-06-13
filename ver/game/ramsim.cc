#include <iostream>
#include <fstream>

using namespace std;

int main() {
    ofstream of("ramsim.bin",ios_base::binary);
    for( int k=0; k<2*1024; k++ ) {
        char x=k&0xff;
        of.write( &x, 1 );
    }
    return 0;
}