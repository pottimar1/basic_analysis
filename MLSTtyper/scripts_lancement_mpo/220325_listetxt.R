#!/usr/bin/env Rscript
# Informations
## date : 220325
## nom : 220325_listetxt.R
## auteur : MPo
## but : lister le noms des fichiers (avec et sans extension) présents dans le dossier. 

# DEFINITION ENVIRONNEMENT
  #install.packages("here",repos = "http://cran.us.r-project.org")
 # install.packages("stringr",repos = "http://cran.us.r-project.org")

   library(here)
   library(stringr)

######################################################################
# CREATION DE LA LISTE DES SOUCHES listesouches.txt ET DES FICHIERS listefichiers.txt
   
  ## changement du dossier de travail vers MLSTtyper/ 
  setwd(".")

  ## message
  cat("R - Création de la liste des souches... \n")

###############################
# LISTER LES SOUCHES A ANALYSER  
  
  ## Si les fichiers listesouches.txt listefichiers.txt et existent déjà, les supprimer.
  if((file.exists("listesouches.txt"))==TRUE){file.remove("listesouches.txt")}else{cat("")}
  if((file.exists("listefichiers.txt"))==TRUE){file.remove("listefichiers.txt")}else{cat("")}

  ## Création du fichier listesouches.txt et listefichiers.txt qui contiennent les souches à analyser et leur nom de fichier. 
   ### mise en forme des objets
    souche <- list.files(path=here("input/"))
    nomfichier<-souche
    souche<-str_replace(as.character(souche), 
                         pattern = "\\..*", 
                         replacement = "")

    ### convertir les objets en matrice (note, je passe par une liste pour ne pas avoir " avant et après mes valeurs)
    souche<-as.list(souche) 
    souche<-cbind(souche)
    
    nomfichier<-as.list(nomfichier) 
    nomfichier<-cbind(nomfichier)
    ### enregistrement des tables
     write.table(x =souche , file ="output/liste_souches/listesouches.txt",sep=";",row.names=FALSE,col.names=FALSE)
     write.table(x =nomfichier, file ="output/liste_souches/listefichiers.txt",sep=";",row.names=FALSE,col.names=FALSE)
  
  
  