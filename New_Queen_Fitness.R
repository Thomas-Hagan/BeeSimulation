New_Queen_Fitness <- function(New_Queens) {
  Fitnesshalves <- data.frame(Fitness1=numeric(length(New_Queens$Fitness)), Fitness2=numeric(length(New_Queens$Fitness)))
  Fitness <- c(Fitness=numeric(length(New_Queens$Fitness)))
  Alleles <- data.frame(New_Queens[,-(1:6)])
  for (i in 1:length(New_Queens$Fitness)) {
    All1Col = New_Queens$Allele_1[i]
    All2Col = New_Queens$Allele_2[i]
    Fitnesshalves$Fitness1[i] = Alleles[i, All1Col]*0.5/sum(Alleles[i,])
    Fitnesshalves$Fitness2[i] = Alleles[i, All2Col]*0.5/sum(Alleles[i,])
    Fitness[i] = 1 - sum(Fitnesshalves[i,])
  } 
  return(Fitness)
}