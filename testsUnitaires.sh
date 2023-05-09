#!/bin/bash
#Import des fonctions
source Fonctions.sh

##Commentaires multiples avec : << Commentaires ... Commentaires, décommenter pour effectuer les tests d'une fonction en particulier.

: << Commentaires
###Tests de la fonction AffiScore
echo "Test de la fonction AffiScore 5 1"
resultatAttendu="3 4 5"
if [ "$resultatAttendu" = "$(AffiScore 5 1)" ]; then
    echo "Test réussi"
else
    echo "Test échoué"
fi
echo "Test de la fonction AffiScore 2 2"
resultatAttendu="1 0 2"
if [ "$resultatAttendu" = "$(AffiScore 2 2)" ]; then
    echo "Test réussi"
else
    echo "Test échoué"
fi
echo "Test de la fonction AffiScore 1 2"
resultatAttendu="0 -1 1"
if [ "$resultatAttendu" = "$(AffiScore 1 2)" ]; then
    echo "Test réussi"
else
    echo "Test échoué"
fi
Commentaires    

: << Commentaires
###Tests de la fonction ResultatMatch
echo "Test de la fonction ResultatMatch 65 France"
resultatAttendu="Le fichier match65.txt n'existe pas"
if [ "$resultatAttendu" = "$(ResultatMatch 65 France)" ]; then
    echo "Test réussi"
else
    echo "Test échoué"
fi
echo "Test de la fonction ResultatMatch 2 Marseille"
resultatAttendu="L'équipe Marseille n'a pas joué le match 2"
if [ "$resultatAttendu" = "$(ResultatMatch 2 Marseille)" ]; then
    echo "Test réussi"
else
    echo "Test échoué"
fi
echo "Test de la fonction ResultatMatch 2 Angleterre"
resultatAttendu="3 4 6"
if [ "$resultatAttendu" = "$(ResultatMatch 2 Angleterre)" ]; then
    echo "Test réussi"
else
    echo "Test échoué"
fi
echo "Test de la fonction ResultatMatch 2 Iran"
resultatAttendu="0 -4 2"
if [ "$resultatAttendu" = "$(ResultatMatch 2 Iran)" ]; then
    echo "Test réussi"
else
    echo "Test échoué"
fi
Commentaires

: << Commentaires
###Tests de la fonction ResultatsEquipe
resultatAttendu="3 3 4
3 1 2
0 -1 0"
if [ "$resultatAttendu" = "$(ResultatsEquipe France)" ]; then
    echo "Test réussi"
else
    echo "Test échoué"
fi
Commentaires

: << Commentaires
###Tests de la fonction AssemblerResultats
resultatAttendu="506503506 \"France\" 6 3 6"
if [ "$resultatAttendu" = "$(AssemblerResultats France)" ]; then
    echo "Test réussi"
else
    echo "Test échoué"
fi
Commentaires

: << Commentaires
###Tests de la fonction ClasserGroupe
resultatAttendu="Classement du groupe groupeA:
507504505 \"Pays-Bas\" 7 4 5
506501505 \"Sénégal\" 6 1 5
504501504 \"Équateur\" 4 1 4
500494501 \"Quatar\" 0 -6 1"
if [ "$resultatAttendu" = "$(ClasserGroupe groupeA.txt)" ]; then
    echo "Test réussi"
else
    echo "Test échoué"
fi
Commentaires