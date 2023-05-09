#!/bin/bash

#Voici le fichier des fonctions. Dans ce fichier, toutes les fonctions sont écrites à la suite.
#Nous avions d'abord commencer par écrire plusieurs scripts dans des fichiers séparés, seulement lorsque nous avons décidé
#de modifier les scripts en fonctions, nous avons eu des problèmes pour les appeler dans les scripts principaux.

function AffiScore() {
#Fonction AffiScore, qui prend en argument deux entiers correspondant respectivement au buts de l'équipe 1 et au buts de l'équipe 2.
#La fonction calcule ensuite le nombre de points gagnés par l'équipe 1 la différence de buts entre l'équipe 1 et 2, puis le nombre de buts de l'équipe 1.
#La fonction affiche ensuite ces trois valeurs séparées par un espace.

# On vérifie qu'il y a bien deux nombre entiers passés en arguments, sinon on affiche un message à l'utilisateur pour lui expliquer
# comment utiliser le script
if [[ $# -lt 2 || ! $1 =~ ^[0-9]+$ || ! $2 =~ ^[0-9]+$ ]]; then
    echo "Usage : AffiScore <scoreÉquipe1> <scoreÉquipe2>"
    return 1
fi

# On récupère les deux scores passés en arguments
local scoreEquipe1=$1
local scoreEquipe2=$2
# On calcule la différence de buts entre les deux équipes
local differenceScore=$(($scoreEquipe1-$scoreEquipe2))

# On affiche le nombre de points gagnés par l'équipe 1, la différence de buts entre l'équipe 1 et 2, puis le nombre de buts de l'équipe 1
if [ $scoreEquipe1 -gt $scoreEquipe2 ]; then
  echo "3 $differenceScore $scoreEquipe1"
elif [ $scoreEquipe1 -lt $scoreEquipe2 ]; then
  echo "0 $differenceScore $scoreEquipe1"
else
  echo "1 0 $scoreEquipe1"
fi
}

#############################################################################################################################################
#############################################################################################################################################
#############################################################################################################################################

function ResultatMatch(){
#Fonction ResultatMatch, qui prend en argument le numéro d'un match et le nom d'une équipe.
#La fonction affiche le score de l'équipe

#On vérifie qu'un argument a été passé, sinon on affiche un message à l'utilisateur pour lui expliquer comment utiliser le script
if [[ $# -lt 2 || $# -gt 2 || ! $1 =~ ^[0-9]+$ || ! $2 =~ ^[[:alpha:]àéèç_-]+$ ]]; then
  echo "Usage : $0 <numéroMatch> <nomÉquipe>"
  exit 1
fi

#On récupère le numéro du match et le nom de l'équipe passés en argument
match=$1
equipe=$2

#On vérifie que le match $1 existe bien
if [ ! -f "GroupesMatchs/match${match}.txt" ]; then
  echo "Le fichier match${match}.txt n'existe pas"
  exit 1
fi

#On récupère les deux équipes du match depuis le fichier match$1.txt
equipe1=$(head -n 2 "GroupesMatchs/match${match}.txt" | tail -n 1)
equipe2=$(head -n 3 "GroupesMatchs/match${match}.txt" | tail -n 1)

#On vérifie que l'équipe passée en argument a bien joué le match $1
if [ "$equipe" != "$equipe1" ] && [ "$equipe" != "$equipe2" ]; then
  echo "L'équipe $equipe n'a pas joué le match $match"
  exit 1
fi

#On affiche le score de l'équipe passée en argument en utilisant la fonction AffiScore.sh, avec soit l'équipe 1 soit l'équipe 2, suivant
#l'équipe passée en argument
if [ "$equipe" == "$equipe1" ]; then
  score=$(tail -n 2 "GroupesMatchs/match${match}.txt" | head -n 1)
  AffiScore $score $(tail -n 1 "GroupesMatchs/match${match}.txt")
  return 0
elif [ "$equipe" == "$equipe2" ]; then
  score=$(tail -n 1 "GroupesMatchs/match${match}.txt" | head -n 1)
  AffiScore $score $(tail -n 2 "GroupesMatchs/match${match}.txt" | head -n 1)
  return 0
fi
}

#############################################################################################################################################
#############################################################################################################################################
#############################################################################################################################################

function ResultatsEquipe(){
#Fonction ResultatsEquipe, qui prend en argument le nom d'une équipe.
#La fonction affiche le score de l'équipe pour chaque match du premier tour

#On vérifie qu'un argument a été passé, sinon on affiche un message à l'utilisateur pour lui expliquer comment utiliser le script
if [ -z "$1" ]; then
  echo "Usage : $0 <nom de l'équipe>"
  exit 1
fi

#On vérifie que le nom de l'équipe ne contient que des lettres ou des _ pour les espaces, sinon on affiche un message à l'utilisateur
if [[ ! "$1" =~ ^[[:alpha:]àéèç_-]+$ ]]; then
  echo "Le nom de l'équipe ne doit contenir que des lettres. Utilisez _ pour les espaces"
  exit 1
fi

#On récupère le nom de l'équipe passée en argument
equipe=$1

#On parcourt les 48 fichiers de matchs différents et on vérifie si l'équipe a joué le match
for i in {1..48}
do
  #On récupère les deux équipes du match depuis le fichier match$i.txt
  equipe1=$(head -n 2 "GroupesMatchs/match${i}.txt" | tail -n 1)
  equipe2=$(head -n 3 "GroupesMatchs/match${i}.txt" | tail -n 1)

  #On vérifie que l'équipe passée en argument a bien joué le match $i
  if [ "$equipe" == "$equipe1" ] || [ "$equipe" == "$equipe2" ]; then
    #On récupère le score de l'équipe passée en argument en utilisant la fonction AffiScore.sh, avec soit l'équipe 1 soit l'équipe 2,
    #suivant l'équipe passée en argument
    if [ "$equipe" == "$equipe1" ]; then
      score=$(tail -n 2 "GroupesMatchs/match${i}.txt" | head -n 1)
      AffiScore $score $(tail -n 1 "GroupesMatchs/match${i}.txt")
    elif [ "$equipe" == "$equipe2" ]; then
      score=$(tail -n 1 "GroupesMatchs/match${i}.txt" | head -n 1)
      AffiScore $score $(tail -n 2 "GroupesMatchs/match${i}.txt" | head -n 1)
    fi
  fi
done
}

#############################################################################################################################################
#############################################################################################################################################
#############################################################################################################################################

function AssemblerResultats(){
#Fonction AsserResultats, qui prend en argument le nom d'une équipe. La fonction applique la fonction ResultatsEquipe sur 
#chaque match de l'équipe, ce qui permet d'obtenir le nombre magique de l'équipe. 
#Enfin, la fonction affiche le nombre magique de l'équipe, le nom de l'équipe ainsi que le nombre de points, 
#la différence de buts et le nombre de buts de l'équipe.

#On vérifie qu'un argument a été passé, sinon on affiche un message à l'utilisateur pour lui expliquer comment utiliser la fonction
if [ -z "$1" ]; then
  echo "Usage : $0 <nom de l'équipe>"
  exit 1
fi

#On vérifie que le nom de l'équipe ne contient que des lettres ou des _ pour les espaces, sinon on affiche un message à l'utilisateur
if [[ ! "$1" =~ ^[[:alpha:]àéèç_-]+$ ]]; then
  echo "Le nom de l'équipe ne doit contenir que des lettres. Utilisez _ pour les espaces"
  exit 1
fi

#On récupère le nom de l'équipe passée en argument
equipe=$1

#On initialise les variables qui contiendront le nombre de points, la différence de buts et le nombre de buts de l'équipe à 0
points=0
difference=0
buts=0

#On lit le résultat de la fonction ResultatsEquipe.sh ligne par ligne et on somme les valeurs de chaque colonne


while read p d b; do
  points=$(($points + $p))
  difference=$(($difference + $d))
  buts=$(($buts + $b))
done < <(ResultatsEquipe "$equipe")

#On affiche le résultat souhaité
echo "$(($points + 500))$(($difference + 500))$(($buts + 500)) \"$equipe\" $points $difference $buts"
}

#############################################################################################################################################
#############################################################################################################################################
#############################################################################################################################################

function ClasserGroupe(){
#Fonction ClasserGroupe, qui prend en argument le nom d'un fichier de groupe. La fonction applique la fonction AssemblerResultats
#sur chaque équipe du groupe, puis classe les équipes grâce au nombre magique. Enfin, la fonction affiche le classement du groupe.

#On vérifie qu'un argument a été passé, sinon on affiche un message à l'utilisateur pour lui expliquer comment utiliser le script
if [ $# -eq 0 ]; then
  echo "Usage : $0 <fichier de groupe>"
  exit 1
fi

# On récupère le nom du fichier de groupe passé en argument
groupe=$1

# On vérifie que le fichier de groupe existe, sinon on affiche un message à l'utilisateur
if [ ! -f "GroupesMatchs/$groupe" ]; then
  echo "Le fichier $groupe n'existe pas."
  exit 1
fi

#On initialise le tableau qui contiendra les résultats des équipes
declare -a resultats

#On applique la fonction AssemblerResultats.sh sur chaque équipe du groupe
while read equipe; do
    #On stocke le résultat de la fonction dans une variable resultat
    resultat=$(AssemblerResultats "$equipe")
    #On ajoute le résultat à la fin du tableau resultats
    resultats+=("$resultat")
done < "$groupe"

#On trie le tableau resultats en utilisant le nombre magique comme clé de tri. En effet, le nombre magique permet
#de classer les équipes facilement sans avoir à se soucier des égalités de points ou de différence de buts.

#On utilise l'Internal Field Separator (IFS) pour que le tri se fasse sur le retour à la ligne
IFS=$'\n' resultats=($(sort -rn <<<"${resultats[*]}"))
unset IFS

#On affiche enfin le classement du groupe
#echo "Classement du groupe $(basename "$groupe" .txt):"
for resultat in "${resultats[@]}"; do
    echo "$resultat"
done
}