analyse_demographie <- function(df) {

  age_stats <- simple_summary(df$age)

  genre_stats <- count_percent(df$genre)

  filiere_stats <- count_percent(df$filiere)

  ville_stats <- count_percent(df$ville)

  result <- list(
    age = age_stats,
    genre = genre_stats,
    filiere = filiere_stats,
    villes = ville_stats
  )

  return(result)
}
