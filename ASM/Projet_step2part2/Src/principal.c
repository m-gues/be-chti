int tab[64];
int dft(int, short);	
extern short TabSig;

int main(void)
{
	for (int k=0;k<64-1;k++){
		tab[k]=dft(k, TabSig);
	}
	
while (1) {
	
}
}
