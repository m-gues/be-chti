Vérification du programme Obj2 :

Pour ouvrir le projet : Obj2.uvprojx

On effectue 4 tests pour vérifier que le programme fonctionne dans une majorité de situations
On ne prend pas en compte la situation où le joueur 1 touche, le joueur 2 touche pendant sa salve, et le joueur 1 arrête de tirer
et re-tire avant que le joueur 2 s'arrête, vu le peu de probabilité qu'elle représente et la complexité que son traitement ajouterait
au code.

Tout a lieu dans le fichier principal.c.

La valeur "test" en hexadécimal est à changer à la ligne 75 (l'endroit exact est indiqué par un commentaire). 
Une fois que cette valeur est changée, recompilez le programme, lancez le débugger, et cliquez sur Run. Aucun point d'arrêt n'est à mettre.
Après [] environ, arrêtez le programme, et observez les valeurs du tableau "score" dans la fenêtre "Call stack and locals".

NB : Si vous voulez observer plus particulièrement les valeurs du compteur d'occurence et la mise à jour des scores, vous pouvez
mettre des points d'arrêts aux lignes 31, 36, 41, 46, 51 et 56. Le programme sera alors stoppé à chaque mise à jour (hors remise à zéro)
d'un des compteurs d'occurences. Le compteur en lui-même (tableau compt_occurences) peut être observé dans la fenêtre Watch 1.

Tests et résultats attendus :

Type de test		Valeur "test"			score[0]	score[1]	score[2]	score[3]	score[4]	score[5]

signal1 seul		0x33				1		2		3		4		5		0

signal1 + signal2	0x51				1		2		3		4		5		15

signal1 + fort bruit	0x3E				1		2		3		4		5		0

signal1 plus faible 	0x3C				0		0		0		0		0		0
que le bruit 