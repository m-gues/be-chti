#include <stdio.h>


int tab[64];
int dft(int, short*);	
extern short TabSig;

int main(void)
{
	int k;
	for (k=0;k<64;k++){
		printf("%d\n", k);
		tab[k]=dft(k, &TabSig);
	}
	
while (1) {
	
}
}
