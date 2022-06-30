#!/usr/bin/env zsh
# date : 220321
# nom : lancement_resfinder.zsh
# auteur : MPo
# but : lancer le script listetxt.R , lancer resfinder, renommer tous les fichiers de sortie en ajoutant le nom associé à leur sequence

##################################################################################################

# Le script va s'arrêter :
# - à la première erreur,
# - si une variable n'est pas définie,
# - si une erreur est recontrée dans un pipe.
set -euo pipefail

# 1) Création des options et des flags
    ## Création de l'aide "-h" :
        ### ajout comme une option, si elle n'est pas présente pas d'erreur
        ### memo, ligne 20 entrer "h:"" si on veut une option qui demande de rentrer un argument et "h" si on ne veut pas avoir à ajouter d'argument (comme c'est le cas ici). On veut juste écrire -h pour avoir l'aide
        ### fonction bien expliquée sur https://unix.stackexchange.com/questions/663803/can-you-make-a-bash-scripts-option-arguments-be-optional

function help {
  echo "
                        #Help script lancement_MLSTtyper#
 >Option :     
    -h [help] : Help for use         
 
 >Flags :
 flags to input (non-optional) :                              
    -s [--species]
         Available species: Campylobacter, Campylobacter jejuni, Campylobacter coli, 
         Enterococcus faecalis, Enterococcus faecium, Escherichia coli, Helicobacter pylori,
         Klebsiella, Mycobacterium tuberculosis, Neisseria gonorrhoeae,
         Plasmodium falciparum, Salmonella, Salmonella enterica, Staphylococcus aureus
         -s "Other" can be used for metagenomic samples or samples with unknown species.
    -ift [--input_file_type] : type of sequence data choose <ifa> for .fasta files and <ifq> for .fastq files
    -i [--input] : input repertory (ex: input/)
    -o [--output] : output repertory (ex: output/)
    -l [--min_cov] : Minimum (breadth-of) coverage of ResFinder within the range 0-1.
    -t [--threshold] : Threshold for identity of ResFinder within the range 0-1.
 for more details contact M.Pottier"
}

while [[ $# -gt 0 ]]; do
  param="$1"

  case $param in
    -s|--species)
      species="$2"
      shift # passer argument
      shift # passer valeur
      ;;
    -ift|--input_file_type)
      input_file_type="$2"
      shift # passer argument
      shift # passer valeur
      ;;      
    -i|--input)
      input="$2"
      shift # passer argument
      shift # passer valeur
      ;;
    -o|--output)
      output="$2"
      shift # passer argument
      shift # passer valeur
      ;;
    -l|--min_cov)
      min_cov="$2"
      shift # passer argument
      shift # passer valeur
      ;;
    -t|--threshold)
      threshold="$2"
      shift # passer argument
      shift # passer valeur
      ;;
    -h|--help)
      help
      exit 1 
      ;;
  esac
done

     echo "Species: $species";
     echo "Type of file: $input_file_type";
     echo "Input: $input";
     echo "Output: $output";
     echo "min coverage: $min_cov";
     echo "threshold: $threshold";

    ## Création des variables restantes :

##################################################################################################
# 2) Création des répertoires de sortie
    ## Vérification de l'existence des répertoires nécessaires à l'execution du script. Si les dossiers n'existent pas, les créer.
        ### message
     echo "zsh - Vérification des répertoires d'entrée et de sortie..."

        ### répertoire input
         if [ ! -d "$input" ];then
         echo "Dossier input non existant, création du répertoire...";
         mkdir $input/
         fi

        ### répertoire output
         if [ ! -d "${output}" ];then
         echo "Dossier output non existant, création du répertoire...";
         mkdir ${output}
         fi

        ### répertoire output/liste_souches/
         if [ ! -d "${output}liste_souches/" ];then
         echo "Dossier liste_souches non existant, création du répertoire...";
         mkdir ${output}liste_souches/
         fi

        ### fichier listefichiers.txt
         if [ ! -d "${output}liste_souches/listefichiers.txt" ];then
         echo "Fichier listefichiers.txt non existant, création du fichier...";
         touch "${output}liste_souches/listefichiers.txt"
         fi

        ### fichier listesouches.txt
         if [ ! -d "${output}liste_souches/listesouches.txt" ];then
         echo "Fichier listesouches.txt non existant, création du fichier...";
         touch "${output}liste_souches/listesouches.txt"
         fi

        ### répertoire output/resfinder_phenotable/
         if [ ! -d "${output}resfinder_phenotable/" ];then
         echo "Dossier resfinder_phenotable non existant, création du répertoire...";
         mkdir ${output}resfinder_phenotable/
         fi

        ### répertoire output/resfinder_hit_genome/
         if [ ! -d "${output}resfinder_hit_genome/" ];then
         echo "Dossier resfinder_hit_genome non existant, création du répertoire...";
         mkdir ${output}resfinder_hit_genome/
         fi

        ### répertoire output/kma/
         if [ ! -d "${output}kma/" ];then
         echo "Dossier kma non existant, création du répertoire...";
         mkdir ${output}kma/
         fi

        ### répertoire output/resfinder_resistance_gene_seq/
         if [ ! -d "${output}resfinder_resistance_gene_seq/" ];then
         echo "Dossier resfinder_resistance_gene_seq non existant, création du répertoire...";
         mkdir ${output}resfinder_resistance_gene_seq/
         fi

        ### répertoire output/resfinder_results_tab/
         if [ ! -d "${output}resfinder_results_tab/" ];then
         echo "Dossier resfinder_results_tab non existant, création du répertoire...";
         mkdir ${output}resfinder_results_tab/
         fi

        ### répertoire output/resfinder_results_table/
         if [ ! -d "${output}resfinder_results_table/" ];then
         echo "Dossier resfinder_results_table non existant, création du répertoire...";
         mkdir ${output}resfinder_results_table/
         fi

        ### répertoire output/resfinder_results/
         if [ ! -d "${output}resfinder_results/" ];then
         echo "Dossier resfinder_results non existant, création du répertoire...";
         mkdir ${output}resfinder_results/
         fi

        ### répertoire output/resfinder_std/
         if [ ! -d "${output}resfinder_std/" ];then
         echo "Dossier resfinder_std non existant, création du répertoire...";
         mkdir ${output}resfinder_std/
         fi

        ### répertoire output/liste_souches/
         if [ ! -d "${output}liste_souches/" ];then
         echo "Dossier liste_souches non existant, création du répertoire...";
         mkdir ${output}liste_souches/
         fi

        ### répertoire output/resultats_concatenes/
         if [ ! -d "${output}resultats_concatenes/" ];then
         echo "Dossier resultats_concatenes non existant, création du répertoire...";
         mkdir ${output}resultats_concatenes/
         fi        

        ### message
         echo "zsh - Répertoires de sortie tous présents!"

##################################################################################################

# 3) Création fichier listesouches.txt contenant le noms des souches présent dans le dossier /resfinder/input.    
    ### message
     echo "zsh - Lancement du script R 220325_listetxt"

    ### lancement du script 'scripts_lancement_mpo/220325_listetxt.R'
     Rscript scripts_lancement_mpo/220325_listetxt_resfinder.R

    ### message
     echo "zsh - Liste des souches créee"

##################################################################################################

# 4) Création des variables

    ## Liste du noms des échantillons / souches à analyser
     samples=(`cat ${output}liste_souches/listesouches.txt`)

    ## Liste des fichiers à analyser
     files=(`cat ${output}liste_souches/listefichiers.txt`)

    ## Choix de l'espèce à analyser
     species=$species

     longueur=${#samples}
        echo "$longueur"

##################################################################################################

# 5) Début de la boucle for. Cette boucle permet de renommer les fichiers en ajoutant le numero de la souche
echo "zsh - Début du resfinder et de la renomination des fichiers ..."

     for positionliste in {1..$longueur}
     do
        echo "${samples[$positionliste]}"

python3 run_resfinder.py -o ${output}  -s "${species}" -l ${min_cov} -t ${threshold} --acquired -${input_file_type} ${input}${files[$positionliste]}
mv output/pheno_table.txt output/resfinder_phenotable/${samples[$positionliste]}_pheno_table.txt 
mv output/ResFinder_Hit_in_genome_seq.fsa output/resfinder_hit_genome/${samples[$positionliste]}_ResFinder_Hit_in_genome_seq.fsa 
mv output/ResFinder_Resistance_gene_seq.fsa output/resfinder_resistance_gene_seq/${samples[$positionliste]}_rfinder_Rgene_seq.fsa
mv output/ResFinder_results_tab.txt output/resfinder_results_tab/${samples[$positionliste]}_ResFinder_results_tab.txt
mv output/ResFinder_results_table.txt output/resfinder_results_table/${samples[$positionliste]}_ResFinder_results_table.txt
mv output/ResFinder_results.txt output/resfinder_results/${samples[$positionliste]}_ResFinder_results.txt
mv output/std_format_under_development.json output/resfinder_std/${samples[$positionliste]}_std_format_under_development.json

echo "zsh - Ajout souche" ${samples[$positionliste]} "au dossier"

done

echo "zsh - Resfinder terminé"

# 6) Mise en forme de la table des phénotyp⎪es de résistance
Rscript scripts_lancement_mpo/220510_tab_gene_concat.R

echo "zsh - Analyse R terminée"

echo "zsh - Toutes les tâches sont finaliées"