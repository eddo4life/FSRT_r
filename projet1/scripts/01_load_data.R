# load data
load_students_data <- function() {
  df <- read.csv("data/raw/etudiants_performance.csv",
                 stringsAsFactors = TRUE)
  return(df)
}
