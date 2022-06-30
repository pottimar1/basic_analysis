#!/usr/bin/env zsh

# Informations  
    ## date : 220325
    ## nom : lancement_MLSTtyper.zsh
    ## auteur : MPo
    ## but :  ### lancer le script listetxt.R , 
              ### lancer le Multilocus sequence typing, 
              ### renommer tous les fichiers de sortie en ajoutant le nom associé à leur sequence
              ### concaténer les résultats 

##################################################################################################
# Conditions d'arrêt
    ## Le script va s'arrêter :
        ### - à la première erreur,
        ### - si une variable n'est pas définie,
        ### - si une erreur est recontrée dans un pipe.
        set -euo pipefail

# 1) Création des options et des flags
    ## Mémo auteur - Création de l'aide "-h" :
        ### ajout comme une option, si elle n'est pas présente pas d'erreur
        ### memo, ligne 20 entrer "h:"" si on veut une option qui demande de rentrer un argument et "h" si on ne veut pas avoir à ajouter d'argument (comme c'est le cas ici). On veut juste écrire -h pour avoir l'aide
        ### fonction bien expliquée sur https://unix.stackexchange.com/questions/663803/can-you-make-a-bash-scripts-option-arguments-be-optional

function help {
  echo "
                        #Help script lancement_MLSTtyper#
 >Option :     
    -h [help] : Help for use         
 
 >Flags flags to input (non-optional) :
    -s [species] : Choose ONE species among  
                              aactinomycetemcomitans
                              abaumannii
                              abaumannii_2
                              achromobacter
                              aeromonas
                              afumigatus
                              aphagocytophilum
                              arcobacter
                              bbacilliformis
                              bcepacia
                              bcereus
                              bhampsonii
                              bhenselae
                              bhyodysenteriae
                              bintermedia
                              blicheniformis
                              bordetella
                              borrelia
                              bpilosicoli
                              bpseudomallei
                              brachyspira
                              brucella
                              bsubtilis
                              bwashoensis
                              calbicans
                              cbotulinum
                              cconcisus
                              cdifficile
                              cdiphtheriae
                              cfetus
                              cfreundii
                              cglabrata
                              chelveticus
                              chlamydiales
                              chyointestinalis
                              cinsulaenigrae
                              cjejuni
                              ckrusei
                              clanienae
                              clari
                              cliberibacter
                              cmaltaromaticum
                              cperfringens
                              cronobacter
                              csepticum
                              csinensis
                              csputorum
                              ctropicalis
                              cupsaliensis
                              dnodosus
                              ecloacae
                              ecoli
                              ecoli_2
                              edwardsiella
                              efaecalis
                              efaecium
                              fpsychrophilum
                              ganatis
                              geotrichum
                              gparasuis
                              hcinaedi
                              hinfluenzae
                              hpylori
                              hsuis
                              kaerogenes
                              kkingae
                              koxytoca
                              kpneumoniae
                              kseptempunctata
                              leptospira
                              leptospira_2
                              leptospira_3
                              llactis
                              lmonocytogenes
                              lsalivarius
                              mabscessus
                              magalactiae
                              manserisalpingitidis
                              mbovis
                              mcanis
                              mcaseolyticus
                              mcatarrhalis
                              mflocculare
                              mgallisepticum
                              mgallisepticum_2
                              mhaemolytica
                              mhominis
                              mhyopneumoniae
                              mhyorhinis
                              miowae
                              mmassiliense
                              mplutonius
                              mpneumoniae
                              msciuri
                              msynoviae
                              mycobacteria
                              neisseria
                              orhinotracheale
                              otsutsugamushi
                              pacnes
                              paeruginosa
                              pdamselae
                              pfluorescens
                              pgingivalis
                              plarvae
                              pmultocida
                              pmultocida_2
                              ppentosaceus
                              pputida
                              psalmonis
                              ranatipestifer
                              rhodococcus
                              sagalactiae
                              saureus
                              sbovis
                              scanis
                              schromogenes
                              sdysgalactiae
                              senterica
                              sepidermidis
                              sgallolyticus
                              shaemolyticus
                              shewanella
                              shominis
                              sinorhizobium
                              slugdunensis
                              smaltophilia
                              soralis
                              sparasitica
                              spneumoniae
                              spseudintermedius
                              spyogenes
                              ssuis
                              sthermophilus
                              sthermophilus_2
                              streptomyces
                              suberis
                              szooepidemicus
                              taylorella
                              tenacibaculum
                              tpallidum
                              tvaginalis
                              ureaplasma
                              vcholerae
                              vcholerae_2
                              vibrio
                              vparahaemolyticus
                              vtapetis
                              vvulnificus
                              wolbachia
                              xfastidiosa
                              ypseudotuberculosis                              
                              yruckeri
    -t [type] : type of sequence data .fasta or .fastq
    -i [input] : input repertory (ex: input/)
    -o [output] : output repertory (ex: output/)
 for more details contact M.Pottier"
}

while [[ $# -gt 0 ]]; do
  param="$1"

  case $param in
    -s|--species)
      species="$2"
      #shift : decalage de la liste des arguments
      #vers la gauche.
      shift # passer argument
      shift # passer valeur
      ;;
    -t|--type)
      type="$2"
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
    -h|--help)
      help
      exit 1 
      ;;
  esac
done

    ## Vérification étape 
     echo "Species: $species";
     echo "Type of file: $type";
     echo "Output: $output";
     echo "Input: $input";

##################################################################################################
# 2) Répertoires de sortie
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

        ### répertoire output/datajson/
         if [ ! -d "${output}datajson/" ];then
         echo "Dossier datajson non existant, création du répertoire...";
         mkdir ${output}datajson/
         fi

        ### répertoire output/hit_genome_seq/
         if [ ! -d "${output}hit_genome_seq/" ];then
         echo "Dossier hit_genome_seq non existant, création du répertoire...";
         mkdir ${output}hit_genome_seq/
         fi

        ### répertoire output/results_tab/
         if [ ! -d "${output}results_tab/" ];then
         echo "Dossier results_tab non existant, création du répertoire...";
         mkdir ${output}results_tab/
         fi

        ### répertoire output/results/
         if [ ! -d "${output}results/" ];then
         echo "Dossier results non existant, création du répertoire...";
         mkdir ${output}results/
         fi

        ### répertoire output/MLST_allele_seq/
         if [ ! -d "${output}MLST_allele_seq/" ];then
         echo "Dossier MLST_allele_seq non existant, création du répertoire...";
         mkdir ${output}MLST_allele_seq/
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

# 3) Création fichier listesouches.txt et listefichiers.txt qui listent le noms des souches et des fichiers présents en input/, respectivement. 
    ### message
     echo "zsh - Lancement du script R 220325_listetxt"

    ### lancement du script 'scripts_lancement_mpo/220325_listetxt.R'
     Rscript scripts_lancement_mpo/220325_listetxt.R

    ### message
     echo "zsh - Liste des souches créee"

##################################################################################################

# 4) Création des variables
    ## Chemin d'accès à la database 
     ### SI NECESSAIRE CHANGER LE CHEMIN D'ACCES A LA DATABASE
 pwd
    # MLST_DB=("/Users/marinepottier/Outils/MLSTtyper/mlst_db")
    MLST_DB=("/Users/marinepottier/Outils/MLSTtyper/mlst_db")

    ## Liste du noms des échantillons / souches à analyser
     samples=(`cat output/liste_souches/listesouches.txt`)

    ## Liste des fichiers à analyser
     files=(`cat output/liste_souches/listefichiers.txt`)

    ## Espèce bactérienne à analyser
     species=$species

    ## Nombre d'échantillon
     longueur=${#samples}
        echo "$longueur"
##################################################################################################
# 5) Lancement du MLST, renomination des fichiers de sortie et déplacement dans les dossiers approriés

    ## Message
     echo "zsh - Début du typage MLST et de la renomination des fichiers ..."

    ## Début de la boucle for pour chaque souche. Cette boucle permet de renommer les fichiers en ajoutant le numero de la souche
     for positionliste in {1..$longueur}
     do
        echo "${samples[$positionliste]}"

        ### typage MLST en utilisant docker. Si besoin d'aide pour cette fonction voir le read.me
        docker run --rm -it \
       -v $MLST_DB:/database \
       -v $(pwd):/workdir \
       mlst -i ${input}${files[$positionliste]}  -o ${output} -s ${species} -x
        
        ### déplacer les fichiers de sortie grâce à mv et ajouter le noms de la souche aux fichiers 
        mv ${output}data.json ${output}datajson/${samples[$positionliste]}_data.json    
        mv ${output}Hit_in_genome_seq.fsa ${output}hit_genome_seq/${samples[$positionliste]}_hit_in_genome_seq.fsa
        mv ${output}results_tab.tsv ${output}results_tab/${samples[$positionliste]}_results_tabs.tsv
        mv ${output}results.txt ${output}results/${samples[$positionliste]}_results.txt
        mv ${output}MLST_allele_seq.fsa ${output}MLST_allele_seq/${samples[$positionliste]}_MLST_allele_seq.fsa
        
        ### message à la fin de chaque tour de boucle 
         echo "zsh - Ajout de la souche" ${samples[$positionliste]} "de l'espèce bactérienne" ${species} "au dossier" ${output} "!"

     done

    ## message à la fin de la boucle
    echo "zsh - MLST typing terminé."

##################################################################################################
# 6) Compilation des résultats par R
    ## message
    echo "R - Début de la concaténation des souches..."
    ## lancement script R
     Rscript scripts_lancement_mpo/analyseMLST.R
    ## message
     echo "R - Tous les profils concaténés!"
    ## déplacement des fichiers
        mv $(date +%Y-%m-%d)_profil_MLST.txt ${output}resultats_concatenes/$(date +%Y-%m-%d)_profil_MLST.txt

## Fin du script
    echo "zsh - Toutes les tâches sont finalisées."