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
source("scripts/09_analyse_par_genre.R")
source("scripts/10_analyse_par_age.R")
source("scripts/11_analyse_heures_etude.R")
source("scripts/12_visualisations.R")


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

# Analyse par genre
result_genre <- analyse_par_genre(df)
print("Analyse par genre terminée.")

cat("\n=== Comparaison des performances H/F ===\n")
print(result_genre$global)

cat("\n=== Différences par matière ===\n")
for (m in names(result_genre$matieres)) {
  cat("\n--- Matière :", m, "---\n")
  print(result_genre$matieres[[m]])
}

cat("\n=== Évolution S1 → S2 par genre ===\n")
cat("\n--- Évolution globale ---\n")
print(result_genre$global[, c("genre", "evolution")])

cat("\n--- Évolution par matière ---\n")
for (m in names(result_genre$matieres)) {
  cat("\nMatière :", m, "\n")
  print(result_genre$matieres[[m]][, c("genre", "evolution")])
}

# Analyse par âge
result_age <- analyse_par_age(df)
print("Analyse par âge terminée.")

# Comparaison globale par âge
print(result_age$global)

# Comparaison par matière
for (m in names(result_age$matieres)) {
  cat("\n--- Matière :", m, "---\n")
  print(result_age$matieres[[m]])
}

# Impact des Absences
result_heures <- analyse_heures_etude(df)
print("Analyse de l'impact des heures d'etude terminee.")

cat("\n=== Corrélation heures d'étude / moyenne générale S2 ===\n")
print(result_heures$correlation)

cat("\n=== Performance par tranche d'heures ===\n")
print(result_heures$perfs_par_tranche)

cat("\n=== Seuil optimal d'heures d'étude ===\n")
print(result_heures$seuil_optimal)


# Visualisations (optionnel)

graphs <- visualiser(df)

# Afficher directement dans R
print(graphs$histo_moyennes)
print(graphs$boxplot_filiere)
print(graphs$scatter_heures)
print(graphs$evo_s1_s2)
print(graphs$bar_tranche)

# Sauvegarder
ggsave("output/figures/histo_moyennes.png", plot = graphs$histo_moyennes, dpi = 300)
ggsave("output/figures/boxplot_filiere.png", plot = graphs$boxplot_filiere, dpi = 300)
ggsave("output/figures/scatter_heures.png", plot = graphs$scatter_heures, dpi = 300)
ggsave("output/figures/evo_s1_s2.png", plot = graphs$evo_s1_s2, dpi = 300)
ggsave("output/figures/bar_tranche.png", plot = graphs$bar_tranche, dpi = 300)