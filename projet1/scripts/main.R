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
source("scripts/05_analyse_performance.R")
source("scripts/06_analyse_evolution.R")
source("scripts/07_analyse_evolution_matieres.R")
source("scripts/08_analyse_par_filiere.R")

df <- load_students_data()

# Analyse démographique
demographie <- analyse_demographie(df)

print("Analyse démographique terminée.")
print(demographie)

# Analyse comportementale
comportement <- analyse_comportement(df)
print("Analyse comportement académique terminée.")
print(comportement)

# Analyse de performance académique
perf <- analyse_performance(df)

print("Analyse de performance académique terminée.")
print(perf)

# Analyse de l'évolution des performances entre S1 et S2
resultats_evolution <- analyse_evolution(df)
print("Analyse de l'évolution des performances terminée.")

print(resultats_evolution$comparaison_moyennes)
print(resultats_evolution$distribution_variations)
print(resultats_evolution$progression_regression)

View(resultats_evolution$top_10_progressions)
View(resultats_evolution$top_10_regressions)

# Analyse de l'évolution des performances par matière entre S1 et S2
result_matieres <- analyse_evolution_matieres(df)
print("Analyse de l'évolution des performances par matière terminée.")

print(result_matieres$comparaison_moyennes)
print(result_matieres$progression_regression)
print(result_matieres$tests_statistiques)

# Analyse par filière
result_filiere <- analyse_par_filiere(df)
print("Analyse par filière terminée.")

print(result_filiere$statistiques)
print(result_filiere$comparaison_filiere)
print(result_filiere$meilleure_filiere)
print(result_filiere$taux_reussite)
