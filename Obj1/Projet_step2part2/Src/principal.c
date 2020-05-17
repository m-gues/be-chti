#include <stdio.h>


int tab[64];
int dft(int, short*);	
extern short TabSig5;

int main(void)
{
	int k;
	for (k=0;k<64;k++){
		tab[k]=dft(k, &TabSig5);
	}
	
while (1) {
	
}
}
