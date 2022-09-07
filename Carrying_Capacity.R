Carrying_Capacity <- function(K_Dist, K_Num, Queens) {
  for (i in 1:length(Queens$Position)) {
    Up_K = Queens$Position[i] + K_Dist
    Low_K = Queens$Position[i] - K_Dist
    Kdf = Queens$Fitness[between(Queens$Position, Low_K, Up_K)]
    Kdf<- Kdf[order(-Kdf)]
    if (isTRUE(length(Kdf) >= K_Num && Kdf[K_Num] > Queens$Fitness[i])) {
      #This is the carrying capacity number, currently 5, HEURISTIC
      Queens$Allele_1[i] = 0
    } else if (length(Kdf) >= K_Num && isTRUE(Queens$Fitness[i] == Kdf[K_Num])) {
      #This is a bug fix for edge cases. This mostly will not matter, but at very high N with very small (or zero) seperation of fitness
      #This can matter quite a lot, and can reduce the overpopulation problem SIGNIFICANTLY
      Edge_Cases = length(Kdf[Kdf == Kdf[i]])
      Spots_Left = K_Num - length(Kdf[Kdf > Kdf[i]])
      p = Spots_Left/Edge_Cases
      if (runif(1) > p) {
        Queens$Allele_1[i] = 0
      }
    }
  }
  
  Queens <- Queens[Queens$Allele_1 != 0,]
  
  if (length(Queens$Position) == 0) {
    print("Stop. Stop, they're already dead!")
    break
  }
  
  return(Queens)
}