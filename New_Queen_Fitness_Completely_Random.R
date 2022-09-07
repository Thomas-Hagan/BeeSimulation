New_Queen_Fitness <- function(New_Queens) {
  Fitness <- runif(length(New_Queens$Fitness), 0.5, 1)
  return(Fitness)
}