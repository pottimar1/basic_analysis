#!/usr/bin/env Rscript
# Informations
    ## date : 220327
    ## nom : analyseMLST.R
    ## auteur : MPo
    ## but : Concaténer les résultats obtenus pour le typage MLST
      
########################################################################
# Préparation de l'environnement

    ### attention, si les packages suivants ne sont pas installé, lancer la commande suivante (retirer le # en début de ligne) : 
    install.packages("here",repos = "http://cran.us.r-project.org")

    ###chargement des librairies
     library(here)

  ## changement du répertoire de travail pour MSLTtyper/
    setwd(".")

  ## message
     cat("R - Création de la liste des souches... \n")

########################################################################
# Concaténation des fichiers
  ## Préparation des variables et des vecteurs
   samples<-read.table("output/liste_souches/listesouches.txt",sep=";",header=FALSE,col.names=FALSE)
   profilcumul<-vector()

  ## Début de la boucle 1 for pour concaténation...
   for (strain in as.matrix(samples)){
   
  ## Pour chaque tour de boucle (donc chaque souche) : Extraction des fichiers souche_results.txt et souche_results_tabs.tsv
   resultMLST<-read.table(paste0("output/results/",strain,"_results.txt"),header = FALSE,sep ="\n")
   profilMLST<-read.table(paste0("output/results_tab/",strain,"_results_tabs.tsv"),header = TRUE,sep ="\t")

   ## détermination du profil MLST
    ### définir dans un vecteur de séquence 1, de 1 au nombre de lignes du tableau profilMLST 
    ### définir dans un vecteur de séquence 1, de 1 au nombre de colonnes du tableau profilMLST 
      nombreligne<-seq(from=1,to=nrow(profilMLST),by=1)
      nombrecol<-seq(from=1,to=ncol(profilMLST),by=1)   
   
  ## définition des messages d'erreur
      for(i in nombreligne) {
        ### erreur si certains des gènes de ménage étudiés ont un profil MLST avec une identité <100 
         if(profilMLST[i,2]<100) {
          cat(paste0("ERREUR: pour la souche ",strain," le gène ",i," du profilm MLST à une couverture <100 \n"))
         }
        ### erreur si certains des gènes de ménage étudiés ont un profil MLST avec une couverture <100 
         if(profilMLST[i,3]<100) {
          cat(paste0("ERREUR: pour la souche ",strain," le gène ",i," du profilm MLST à une identité <100 \n"))
         }
        ### erreur si certains des gènes de ménage étudiés ont un profil MLST avec des gaps
         if(profilMLST[i,6]>0) {
          cat(paste0("ERREUR: pour la souche ",strain," le gène ",i," du profilm MLST à des gaps \n"))
         }
        }
   
  ## extraire le ST identifié
   ST<-resultMLST[4,]
   ST<-as.character(resultMLST[4,])
   ST<-substr(ST,16,nchar(ST))
   ST<-as.data.frame(ST)

  ## extraction du profil de gène du typage MLST
      ### Préparation des variables et des vecteurs
      profiltable<-vector()
      
      ### Début de la boucle 2 pour concaténer dans "profilparsouche" le nom de la souche, son ST et son profil MLST.
       for (row in nombreligne) {
        profiltable<-profiltable  
        profiltable<-cbind(profiltable,paste0(profilMLST[row,ncol(profilMLST)]))
        profilparsouche<-cbind(strain,ST,profiltable)
        }
      ### Fin boucle 2
      
    ## Avant fin boucle 1, concaténation du profil obtenu pour la souche "profilparsouche" à la table globale profilcumul qui contiendra les data de toutes les souches analysées.
     profilcumul<-profilcumul
     profilcumul<-rbind(profilcumul,profilparsouche)
}
   ##Fin boucle 1
   
# Définir le noms des colonnes
  colnames(profilcumul)<-c("Strain","ST",profilMLST[,1])   

# Enregistrer la table
  date<-Sys.Date()
  ## message
  cat("Enregistrement de la table concaténée... \n")
  
  ## enregistrement
  write.table(x = profilcumul ,append = FALSE, quote = TRUE, sep = "\t",
              na = "NA", dec = ".", row.names = FALSE,
              col.names = TRUE, file = paste0(date,"_profil_MLST.txt"))
  
  ## message
  cat("Table concaténée entregistrée! \n")
  
  