D'abord pour lancer ce script il vous faut :
1. L'INSTALLATION DE R
   - a l'adresse : https://cran.r-project.org/

2. L'INSTALLATION DE RSTUDIO (pour une experrience plus fluide)
   - Telecharger : https://posit.co/download/rstudio-desktop/
   - Version : RStudio 2023.12.0 ou +

3. INSTALLATION DES PACKAGES R
   Ouvrir R ou RStudio et executer les commandes suivantes :

   packages <- c(
     "ggplot2",    # Visualisation
     "dplyr",      # Manipulation de données
     "broom",      # Nettoyage des sorties statistiques
     "tidyr",      # Formatage des données
     "readr",      # Importation des données
   )
   
   install.packages(packages) #Installera tous les packages necessaire pour l'execution du programme