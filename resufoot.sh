#!/bin/bash
source Fonctions.sh

#Script final resufoot.sh, le script permet de spécifier 3 arguments différents : -e pour obtenir les résultats de l'équipe entrée par 
#l'utilisateur, -g pour obtenir le classement du groupe entré par l'utilisateur et -h pour obtenir le classement du groupe sans le nombre magique.

#On vérifie qu'il y a au moins 2 arguments, sinon on affiche un message à l'utilisateur pour lui expliquer comment utiliser le script
if [ $# -lt 2 ]; then
echo "Usage: $0 [-e|-g|-h] <nom d'équipe ou nom de groupe>"
exit 1
fi

#On récupère l'option et l'argument saisis par l'utilisateur
option=$1
argument=$2

#Pour chaque option, on appelle la fonction correspondante, l'utilisation de la fonction case était donc ce qui nous a paru le plus évident ici
case $option in 
    -e)
        #On utilise la fonction ResultatsEquipe
        ResultatsEquipe $argument
        ;;
    -g)
        #On affiche le classement avec le nombre magique avec ClasserGroupe
        if [ -f "GroupesMatchs/$argument" ]; then
        ClasserGroupe $argument | sort -nr
        else
        #Si le groupe n'existe pas, on affiche un message à l'utilisateur
        echo "Le groupe $argument n'est pas dans le fichier des groupes."
        exit 1
        fi
        ;;
    -h)
        #On affiche le classement sans le nombre magique
        if [ -f "GroupesMatchs/$argument" ]; then
        #On supprime les séquences de 9 chiffres consécutifs (le nombre magique)
        ClasserGroupe $argument | sed 's/[0-9]\{9\}//g'
        else
        #Si le groupe n'existe pas, on affiche un message à l'utilisateur
        echo "Le groupe $argument n'est pas dans le fichier des groupes."
        exit 1
        fi
        ;;
    *)
#On affiche un message à l'utilisateur pour lui expliquer comment utiliser le script
echo "Usage: $0 [-e|-g|-h] <nom d'équipe ou nom de groupe>"
exit 1
;;
esac
exit 0