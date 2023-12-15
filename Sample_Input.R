library(doParallel)
library(foreach)

source("Simulation.R")
source("Growth_Rates.R")
source("Small_Functions.R")
source("Pressure_To_Move.R")
source("Movement.R")
source("Mate_New_Queens.R")

#source("Create_Unequal_Queens.R")
#OR
#source("New_Queen_Fitness_Unlinked.R")

#source("Carrying_Capacity_Random_NewFitness.R")
#OR
#source("Carrying_Capacity_Random.R")

#source("Reproduce_NewFitness.R")
#OR
#source("Reproduce.R")

#source("New_Queen_Fitness.R")
#OR
#source("New_Queen_Fitness_Unlinked.R")

Start_D = -1
End_D = 1
N_Ran_Queens = 10
Sep = (End_D - Start_D)/(N_Ran_Queens)
N_Initial_Alleles = 7
N_Unequal_Alleles = 2
Proportion_Unequal = 0.8
Mean_Mates = 29
SD_Mates = 8
Max_Jump = 10
radius_sight = 4
alpha_jump = 1
Jump_sd = 4
K_Dist = 0.5
Male_Flight = 5
WLColony = 0
WBD_Chance = 0
A_Norm_Drones = .5
Max_Drones = 1000
Drone_Spread = 2
GQL = 5
Samp_Cutoff = 50
Queenless_Chance = 0.3
Chance_Mutate = 0

registerDoParallel(cores=detectCores())

Iterations = 20
#K_Num = 30 OR 100 OR 300
#Max_Swarms = 2, 3 OR 4
#beta_jump = 0 OR 5 OR 10
#Samples = 96

foreach (z=01:Samples, .packages = "tidyverse") %dopar% {
  Run = Simulation(Iterations, K_Num, Max_Swarms)
  filename = paste(paste("MN3W", sprintf("%03d", z), sep="_"), ".txt", sep= "")
  write.table(Run, filename, sep="\t", row.names = FALSE)
}
