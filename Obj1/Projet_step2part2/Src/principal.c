#include <stdio.h>


int tab[64];
int dft(int, short*);	
int partRe (int, short*, short*);
extern short TabSig3;
extern short TabCos;

int main(void)
{
	int k;
	for (k=0;k<63;k++){
		tab[k]=partRe(k, &TabSig3, &TabCos);
	}
	
while (1) {
	
}
}
