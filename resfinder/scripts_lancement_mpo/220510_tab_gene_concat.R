#!/usr/bin/env Rscript
cat("R - Début analyse R \n")

cat("R - Début script 'scripts_lancement_mpo/' \n")


### téléchargement des packages et chargement des librairies
## attention, si les packages suivants ne sont pas installer, lancer les commandes suivantes (retirer le # en début de ligne) : 
    install.packages('plyr', repos = "http://cran.us.r-project.org")
    install.packages("here", repos = "http://cran.us.r-project.org")
    install.packages("data.table", repos = "http://cran.us.r-project.org")
    install.packages("ggplot2", repos = "http://cran.us.r-project.org")
    install.packages("dplyr", repos = "http://cran.us.r-project.org")
    install.packages("tibble", repos = "http://cran.us.r-project.org")
    install.packages("tidyverse", repos = "http://cran.us.r-project.org")

library(plyr)
library(here)
library(data.table)
library(ggplot2)
library(dplyr)
library(tibble)
library(tidyverse)
########################################################################

# Partie 1) Importer en une seule table, tous les phénotypes de résistance obtenus à partir du résistome

## Création des variables, tables, vecteurs
setwd("~/Outils/resfinder")
titre=read.table("output/liste_souches/listesouches.txt",sep=";")
atb<-c("Beta-lactam","Aminoglycoside","Fluoroquinolone","Fosfomycin","Fusidic.Acid","MLS","Nitroimidazole","Oxazolidinone","Colistin","Phenicol","Rifampicin","Sulphonamide","Tetracycline","Trimethoprim","Glycopeptide")

tab<-0
tab_long<-0
tab_short<-0
taille_titre=length(titre[,1])
taille_atb=length(atb)
concat<-matrix(ncol=1,nrow=1,)

for(i in as.matrix(titre)){
 
  tab<-read.table(paste0("output/resfinder_results_tab/",i,"_ResFinder_results_tab.txt"),sep = "\t", quote = "\t", header=TRUE)
  tab_long<-cbind(tab[,8],paste0(tab[,1],"(",tab[,2],";",tab[,3],";",tab[,4],")"))
  tab_short<-cbind(tab[,8],paste0(tab[,1],"(",tab[,2],";",tab[,4],")"))
  
  data<-as_data_frame(tab_short)
  
  resultat <- data %>% group_by(data[,1]) %>% 
    summarise_all(funs(if(is.numeric(.))sum(.) else str_c(unique(.),collapse="_")))
  
  transpose<-t(resultat[,2])
  transpose<-cbind(i,transpose)
  names<-c("strain",resultat$V1)
  colnames(transpose)<-names
  print(i)

#note : resultat$V1[order(resultat$V1,decreasing=F) pour ordonner les colonnes par ordre alphabétique
  concat<-rbind(concat)
  concat<-rbind.fill.matrix(concat,transpose)
}

concat<-concat[-1,]
date<-Sys.Date()
write.table(x = concat , file = paste0(date,"_table_gene_resistance_acquis.txt"),
            append = FALSE, quote = TRUE, sep = "\t",na = "-", dec = ".", row.names = FALSE,col.names = TRUE)



  