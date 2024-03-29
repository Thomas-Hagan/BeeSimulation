Create_Queens <- function(Start_D, End_D, Sep, N_of_Mates, N_Initial_Alleles, N_Unequal_Alleles, Proportion_Unequal) {
  Position = c(seq(Start_D, End_D, by =Sep))
  #Fitness = c(runif(length(Position), min=0.5, max=1))
  #Only use above if just running fitness randomly - for proof of concept
  
  N_Unequal = round(Proportion_Unequal*N_of_Mates)
  
  Equal_Unequal_Dif = N_Initial_Alleles - N_Unequal_Alleles
  
  Alleles1 <- data.frame(t(rmultinom(n=length(Position), size=N_Unequal, prob = rep(1/Equal_Unequal_Dif, Equal_Unequal_Dif))))
  Alleles2 <- data.frame(t(rmultinom(n=length(Position), size=(N_of_Mates-N_Unequal), prob = rep(1/N_Unequal_Alleles, N_Unequal_Alleles))))
  Alleles <- cbind.data.frame(Alleles1, Alleles2)
  
  Allelenames = c()
  
  for (j in 1:N_Initial_Alleles) {
    Allelenames = c(Allelenames, paste("Aus", j, sep=""))
  }
  
  colnames(Alleles) <- Allelenames
  Queen_Allele <- data.frame(Allele_1=numeric(0), Allele_2=numeric(0))
  
  N_Unequal_Queens = round(Proportion_Unequal*length(Position))
  
  #This creates random alleles for the queen to begin with. Later make an input file that has alleles we think the queen might actually have had
  for (i in 1:N_Unequal_Queens) {
    Queen_Allele[i,] <- t(sample(1:Equal_Unequal_Dif, 2))
  }
  for (i in (N_Unequal_Queens+1):(length(Position))) {
    Queen_Allele[i,] <- t(sample(1:N_Initial_Alleles, 2))
  }
  Fitnesshalves <- data.frame(Fitness1=numeric(length(Position)), Fitness2=numeric(length(Position)))
  Fitness <- data.frame(Fitness=numeric(length(Position)))
  
  #Below is for calculating the Fitness of each "Colony/Queen" I wish I could make this smaller. It is a real drain on the code.
  for (i in 1:length(Position)) {
    All1Col = Queen_Allele$Allele_1[i]
    All2Col = Queen_Allele$Allele_2[i]
    Fitnesshalves$Fitness1[i] = Alleles[i, All1Col]*0.5/sum(Alleles[i,])
    Fitnesshalves$Fitness2[i] = Alleles[i, All2Col]*0.5/sum(Alleles[i,])
    Fitness[i,] = 1 - sum(Fitnesshalves[i,])
  } 
  
  Age = vector(mode = "numeric", length=length(Position))
  
  Average_Dist=vector(mode="numeric", length=length(Position))
  Queens <- data.frame(Position, Age, Fitness, Average_Dist, Queen_Allele, Alleles)
  #Create the data.frame variables, Position is the point along the line, fitness is the fitness of the colony (this will be an actual term later but for now it is random) and 
  #average distance is the weighted average of the surrounding colonies
  return(Queens)
}