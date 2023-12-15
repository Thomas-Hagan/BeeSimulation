Simulation <- function(Iterations, K_Num, Max_Swarms) {
  
  Queens <- Create_Queens(Start_D, End_D, Sep, Mean_Mates, N_Initial_Alleles, N_Unequal_Alleles, Proportion_Unequal)
  
  t=1
  
  Push <- Pressure_To_Move(radius_sight, K_Num, K_Dist, Queens)
  
  Queens <- Movement(alpha_jump, beta_jump, Max_Jump, Jump_sd, Queens, Push)
  
  Queens <- Carrying_Capacity(K_Dist, K_Num, Queens)
  
  CurrentGen = CreateStore(t, Queens)
  
  StoredValues = CurrentGen
  
  repeat {
    
    New_Queens <- Reproduce(Max_Swarms, GQL, Queens, Chance_Mutate, Queenless_Chance)
    
    Queenless_Colonies = New_Queens[New_Queens$Age == GQL, ]
    
    New_Queens = New_Queens[New_Queens$Age == 0, ]
    
    Queens <- AddColoumn(Queens, New_Queens, 6)
    
    New_Queens <- Mate_New_Queens(Male_Flight, Mean_Mates, SD_Mates, WLColony, WBD_Chance, A_Norm_Drones, Max_Drones, Drone_Spread, 
                                  Queens, New_Queens, Samp_Cutoff, Chance_Mutate, Queenless_Colonies)
    
    Queens$Age = Queens$Age + 1
    
    for (i in 1:length(Queens$Age)) {
      if (Queens$Age[i] == GQL) {
        Queens$Allele_1[i] = 0
      }
    }
    
    Queens <- Queens[Queens$Allele_1 != 0,]
    
    Fitness <- New_Queen_Fitness(New_Queens)
    
    New_Queens$Fitness = Fitness
    
    Queens <- AddColoumn(Queens, New_Queens, 6)
    
    Queens <- rbind.data.frame(Queens, New_Queens)
    
    Queens = Queens[order(Queens$Position), ]
    
    Queenless_Colonies = c()
    
    New_Queens = c()
    
    Push <- Pressure_To_Move(radius_sight, K_Num, K_Dist, Queens)
    
    Queens <- Movement(alpha_jump, beta_jump, Max_Jump, Jump_sd, Queens, Push)
    
    Queens = Queens[order(Queens$Position),]
    
    Queens <- Carrying_Capacity(K_Dist, K_Num, Queens)
    
    if (t+1 == Iterations) {
      break
    }
    t = t+1
    
    CurrentGen = CreateStore(t, Queens)
    StoredValues <- AddColoumn(StoredValues, CurrentGen, 7)
    StoredValues = StoreValue(StoredValues, CurrentGen)
  }
  
  t = t+1
  
  CurrentGen = CreateStore(t, Queens)
  StoredValues <- AddColoumn(StoredValues, CurrentGen, 7)
  StoredValues = StoreValue(StoredValues, CurrentGen)
  StoredValues = StoredValues[,-5]
  return(StoredValues)
}
