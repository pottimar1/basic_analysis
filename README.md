# basic_analysis
serotyping (PSAE), MLST typing and resistome extraction

## Objet
Le répertoire basic_analysis permet de faire tourner les logiciels ci-après de manière automatisée, en local sur un terminal zsh.
Pour chaque analyse, il sera nécessaire de se placer dans le répertoire de l'outil -> Outils/PAst ; Outils/MLSTtyper ou Outils/resfinder.
Dans chacun de ces répertoire, ouvrir le fichier readme pour connaître la marche à suivre pour réaliser l'installation et l'analyse. 
- PAst (1, 2)
- MLST (2, 3, 4, 5, 6 , 7, 8, 9)
- ResFinder (2, 10, 11, 12) 

Le dossier comporte également les environnements conda nécessaires à faire tourner les scripts. Ces environnements ont été crées avec conda 4.12.0.

## Versions utilisées 
- PAst 1.0
- MLST 2.0 : Software version: 2.0.9 (2022-05-11) ; Database version: (2022-06-27)
- Resfinder 4.1 : ResFinder and PointFinder software: (2022-03-10) ; ResFinder database: EFSA_2021 (2022-05-24) ; PointFinder database: (2021-02-01)

### PAst
Le sérotypeur de Pseudomonas aeruginosa (PAst) est un outil en ligne de commande pour le sérotypage in silico rapide et fiable des isolats de P. aeruginosa, basé sur les données d'assemblage de la séquence du génome entier.

Logiciel disponible sur :  cge.cbs.dtu.dk/services/past-1.0/  et https://github.com/Sandramses/PAst

Créateurs : (1, 2)

## MLST 
Le service MLST contient un script python mlst.py qui est le script de la dernière version du service MLST. La méthode permet aux chercheurs de déterminer le ST sur la base des données WGS.

Logiciel disponible sur : https://cge.food.dtu.dk/services/MLST/ et https://bitbucket.org/genomicepidemiology/mlst/src/master/ 

Créateurs : (2, 3, 4, 5, 6 , 7, 8, 9)

## ResFinder 
ResFinder identifie les gènes de résistance aux antimicrobiens acquis dans les isolats de bactéries à séquençage total ou partiel.

Logiciel disponible sur : https://cge.food.dtu.dk/services/ResFinder/ et https://bitbucket.org/genomicepidemiology/resfinder/src

Créateurs : (2, 10, 11, 12)

# REFERENCES

  1.  Application of Whole-Genome Sequencing Data for O-Specific Antigen Analysis and In Silico Serotyping of Pseudomonas aeruginosa Isolates. Thrane SW, Taylor VL, Lund O, Lam JS, Jelsbak L.
    J. Clin. Micobiol. 2016. 54(7): 1782-1788.
    PMID: 27098958         doi: 10.1128/JCM.00349-16

  2. Camacho C, Coulouris G, Avagyan V, Ma N, Papadopoulos J, Bealer K, Madden TL. BLAST+: architecture and applications. BMC Bioinformatics 2009; 10:421. 
  
   3. Larsen, M., Cosentino, S., Rasmussen, S., Rundsten, C., Hasman, H., Marvig, R., Jelsbak, L., Sicheritz-PontÃ©n, T., Ussery, D., Aarestrup, F., & Lund, O. (2012). Multilocus Sequence Typing of Total Genome Sequenced Bacteria.
Journal of Clinical Microbiology, 50(4), 1355-1361.
View the abstract at PubMed here         doi: 10.12.0/JCM.06094-11

  4. Clausen, P., Aarestrup, F., & Lund, O.
(2018). Rapid and precise alignment of raw reads against redundant databases with KMA.
Bmc Bioinformatics,19(1), 307

  5. Bartual, S., Seifert, H., Hippler, C., Luzon, M., Wisplinghoff, H., & RodrÃ­guez-Valera, F. (2005). Development of a multilocus sequence typing scheme for characterization of clinical isolates of Acinetobacter baumannii.
Journal of Clinical Microbiology, 43(9), 4382-4390.

  6. Griffiths, D., Fawley, W., Kachrimanidou, M., Bowden, R., Crook, D., Fung, R., Golubchik, T., Harding, R., Jeffery, K., Jolley, K., Kirton, R., Peto, T., Rees, G., Stoesser, N., Vaughan, A., Walker, A., Young, B., Wilcox, M., & Dingle, K. (2010). Multilocus sequence typing of Clostridium difficile.
Journal of Clinical Microbiology, 48(3), 770-778.

  7. Lemee, L., Dhalluin, A., Pestel-Caron, M., Lemeland, J., & Pons, J. (2004). Multilocus sequence typing analysis of human and animal Clostridium difficile isolates of various toxigenic types.
Journal of Clinical Microbiology, 42(6), 2609-2617.

  8. Wirth, T., Falush, D., Lan, R., Colles, F., Mensa, P., Wieler, L., Karch, H., Reeves, P., Maiden, M., Ochman, H., & Achtman, M. (2006). Sex and virulence in Escherichia coli: An evolutionary perspective.
Molecular Microbiology, 60(5), 1136-1151.

  9. Jaureguy, F., Landraud, L., Passet, V., Diancourt, L., Frapy, E., Guigon, G., Carbonnelle, E., Lortholary, O., Clermont, O., Denamur, E., Picard, B., Nassif, X., & Brisse, S. (2008). Phylogenetic and genomic diversity of human bacteremic Escherichia coli strains.
Bmc Genomics, 9(1), 560.

 10. Bortolaia V, Kaas RF, Ruppe E, Roberts MC, Schwarz S, Cattoir V, Philippon A, Allesoe RL, Rebelo AR, Florensa AR, Fagelhauer L, Chakraborty T, Neumann B, Werner G, Bender JK, Stingl K, Nguyen M, Coppens J, Xavier BB, Malhotra-Kumar S, Westh H, Pinholt M, Anjum MF, Duggett NA, Kempf I, NykÃ¤senoja S, Olkkola S, Wieczorek K, Amaro A, Clemente L, Mossong J, Losch S, Ragimbeau C, Lund O, Aarestrup FM. (2020). ResFinder 4.0 for predictions of phenotypes from genotypes. Journal of Antimicrobial Chemotherapy, 75(12),3491-3500
View the abstract here.

  11. Zankari E, Allesøe R, Joensen KG, Cavaco LM, Lund O, Aarestrup FM. (2020) PointFinder: a novel web tool for WGS-based detection of antimicrobial resistance associated with chromosomal point mutations in bacterial pathogens. Journal of Antimicrobial Chemotherapy 72(10) 2764-2768.
View the abstract here.

  12. Clausen PTLC, Aarestrup FM, Lund O. (2018). Rapid and precise alignment of raw reads against redundant databases with KMA. BMC Bioinformatics 19(1):307.
View the abstract here.

