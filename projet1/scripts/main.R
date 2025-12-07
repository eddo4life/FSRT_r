# ===================================================================================================
# PROJET FINAL 1 - ANALYSE DE PERFORMANCES ETUDIANTES
# ===================================================================================================
# Auteur: Boaz Eddy Cadet THEODORIS
# Date: 04 DECEMBRE 2025
# Description: Vous êtes data analyst pour une université qui souhaite comprendre 
#              les facteurs influençant la performance académique de ses étudiants. 
#              L'université a collecté des données sur 200 étudiants sur deux semestres consécutifs.
# ===================================================================================================

source("scripts/01_load_data.R")
source("scripts/02_utils_stats.R")
source("scripts/03_analyse_demographie.R")
source("scripts/04_analyse_comportement.R")

df <- load_students_data()

# Analyse démographique
demographie <- analyse_demographie(df)

print("Analyse démographique terminée.")
print(demographie)

# Analyse comportementale
comportement <- analyse_comportement(df)
print("Analyse comportement académique terminée.")
print(comportement)
