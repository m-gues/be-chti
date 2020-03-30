int tab[64];
int sommecarre(int);	
int max=0;
int min=100;

int main(void)
{
	for (int i=0;i<64;i++){
		tab[i]=sommecarre(i);
		if (tab[i]>max) max=tab[i];
		if (tab[i]<min) min=tab[i];
	}
	
while (1) {
	
}
}
