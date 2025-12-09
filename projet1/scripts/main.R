# ==============================================================================================
# PROJET FINAL 1 - ANALYSE DE PERFORMANCES ETUDIANTES
# ==============================================================================================
# Auteur: Boaz Eddy Cadet THEODORIS
# Date: 04 DECEMBRE 2025
# Description: Ce projet vise à analyser les performances académiques de 200 étudiants 
#              sur deux semestres consécutifs.
# ==============================================================================================

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

print("Donnes importe avec succes.")

df <- load_students_data()
# Vérification
#  str(df)
#  summary(df)
#  head(df)
#  print("Fin de la verification des donnees.\n\n")

# ============= Analyse 1 ============
# Analyse démographique
demographie <- analyse_demographie(df)
print("[Analyse démographique terminée.]\nAffichage des résultats :\n")
print(demographie)

write.csv(demographie$genre, "output/tables/demographie_genre.csv", row.names = FALSE)
write.csv(demographie$filiere, "output/tables/demographie_filiere.csv", row.names = FALSE)
write.csv(demographie$villes, "output/tables/demographie_villes.csv", row.names = FALSE)

age_df <- data.frame(
  statistique = c("moyenne", "mediane", "ecart_type"),
  valeur = c(demographie$age$moyenne, 
             demographie$age$mediane, 
             demographie$age$ecart_type)
)
write.csv(age_df, "output/tables/demographie_age.csv", row.names = FALSE)

# Analyse comportementale
comportement <- analyse_comportement(df)
print("Analyse comportement académique terminée.")
print(comportement)
write.csv(comportement, "output/tables/comportement.csv", row.names = FALSE)

# Analyse de performance académique
perf <- analyse_performance(df)
print("Analyse de performance académique terminée.")
print(perf)
write.csv(perf, "output/tables/performance.csv", row.names = FALSE)

# Analyse de l'évolution des performances entre S1 et S2
resultats_evolution <- analyse_evolution(df)
print("Analyse de l'évolution des performances terminée.")

print(resultats_evolution$comparaison_moyennes)
print(resultats_evolution$distribution_variations)
print(resultats_evolution$progression_regression)

write.csv(resultats_evolution$comparaison_moyennes, "output/tables/comparaison_moyennes_s1_s2.csv", row.names = FALSE)
write.csv(resultats_evolution$distribution_variations, "output/tables/distribution_variations.csv", row.names = FALSE)
write.csv(resultats_evolution$progression_regression, "output/tables/progression_regression.csv", row.names = FALSE)

# Exporter les top 10 progressions et régressions
write.csv(resultats_evolution$top_10_progressions, "output/tables/top_10_progressions.csv", row.names = FALSE)
write.csv(resultats_evolution$top_10_regressions, "output/tables/top_10_regressions.csv", row.names = FALSE)

# Analyse de l'évolution des performances par matière
result_matieres <- analyse_evolution_matieres(df)
print("Analyse de l'évolution des performances par matière terminée.")

print(result_matieres$comparaison_moyennes)
print(result_matieres$progression_regression)
print(result_matieres$tests_statistiques)

write.csv(result_matieres$comparaison_moyennes, "output/tables/comparaison_moyennes_matieres.csv", row.names = FALSE)
write.csv(result_matieres$progression_regression, "output/tables/progression_regression_matieres.csv", row.names = FALSE)
write.csv(result_matieres$tests_statistiques, "output/tables/tests_statistiques_matieres.csv", row.names = FALSE)

# Analyse par filière
result_filiere <- analyse_par_filiere(df)
print("Analyse par filière terminée.")

print(result_filiere$statistiques)
write.csv(result_filiere$statistiques, "output/tables/statistiques_filiere.csv", row.names = FALSE)

print(result_filiere$comparaison_filiere)
write.csv(result_filiere$comparaison_filiere, "output/tables/comparaison_filiere.csv", row.names = FALSE) 

print(result_filiere$meilleure_filiere)
write.csv(result_filiere$meilleure_filiere, "output/tables/meilleure_filiere.csv", row.names = FALSE)

print(result_filiere$taux_reussite)
write.csv(result_filiere$taux_reussite, "output/tables/taux_reussite_filiere.csv", row.names = FALSE)

# Analyse par genre
result_genre <- analyse_par_genre(df)
print("Analyse par genre terminée.")

cat("\n=== Comparaison des performances H/F ===\n")
print(result_genre$global)
write.csv(result_genre$global, "output/tables/comparaison_genre_global.csv", row.names = FALSE)

# Exporter les données par matière dans un seul fichier
donnees_genre_matieres <- do.call(rbind, lapply(names(result_genre$matieres), function(m) {
  df_temp <- result_genre$matieres[[m]]
  df_temp$matiere <- m
  df_temp
}))
write.csv(donnees_genre_matieres, "output/tables/comparaison_genre_matieres.csv", row.names = FALSE)

# Analyse par âge
result_age <- analyse_par_age(df)
print("Analyse par âge terminée.")

# Comparaison globale par âge
print(result_age$global)
write.csv(result_age$global, "output/tables/comparaison_age_global.csv", row.names = FALSE)

# Exporter les données par matière dans un seul fichier
donnees_age_matieres <- do.call(rbind, lapply(names(result_age$matieres), function(m) {
  df_temp <- result_age$matieres[[m]]
  df_temp$matiere <- m
  df_temp
}))
write.csv(donnees_age_matieres, "output/tables/comparaison_age_matieres.csv", row.names = FALSE)

# Impact des Absences
result_heures <- analyse_heures_etude(df)
print("Analyse de l'impact des heures d'etude terminee.")

cat("\n=== Corrélation heures d'étude / moyenne générale S2 ===\n")
print(result_heures$correlation)
write.csv(result_heures$correlation, "output/tables/correlation_heures.csv", row.names = FALSE)

cat("\n=== Performance par tranche d'heures ===\n")
print(result_heures$perfs_par_tranche)
write.csv(result_heures$perfs_par_tranche, "output/tables/performance_par_tranche_heures.csv", row.names = FALSE)

cat("\n=== Seuil optimal d'heures d'étude ===\n")
print(result_heures$seuil_optimal)
write.csv(result_heures$seuil_optimal, "output/tables/seuil_optimal_heures.csv", row.names = FALSE)

# Message de confirmation
cat("\n✓ Tous les tableaux ont été exportés dans le dossier 'output/tables/'\n")
cat("Fichiers créés :\n")
list.files("output/tables/", full.names = FALSE)

# Visualisations
graphs <- visualiser(df)
print("Visualisations générees.")

# Affichage des graphiques
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

print("Graphiques sauvegardés dans le dossier output/figures.")