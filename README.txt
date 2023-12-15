Bee Simulation Code

The code you have downloaded is intended to be run in R 4.0.4. It does not require any additional programs, or additional input documents. Packages required to run this code in R are doParallel, foreach and tidyverse. Input variables are described in the Sample_Input.R file, and may be edited to your preference. Some functions are intended to be swapped in or out to your preference and are loaded as needed.

This program is intended to simulate an expanding population of social insects for the publication "Serial founder effects slow range expansion in an invasive social insect". This is an agent-based model to examine how allele frequencies at the sex locus (and thus genetic load) vary over time and space in a colonizing population of honey bees. This model uses a single, continuous spatial dimension along which agents (colonies) reproduce and disperse in discrete generations, expanding in two directions from the point of incursion. Each colony is assigned a fitness score according to the proportion of diploid males (DMP) it would produce (which is determined by the sex alleles present in the queen and her mates). This fitness score is used to determine, per colony, both the reproductive output and the likelihood of survival until the next generation. The model has three phases that comprise a discrete generation: reproduction, dispersal and persistence. During the reproductive phase, colonies produce virgin queens and drones, according to their fitness score. These then mate with neighbouring virgin queens and drones to produce new colonies. During the dispersal phase, colonies stochastically move to a new position on the single spatial dimension. Each colony is capable of moving in both directions along the spatial axis, however we consider scenarios where movement is both unbiased and scenarios where movement is somewhat biased towards regions of lower density. Finally, during the persistence phase some colonies persist while others perish (i.e., are removed from the simulation) based on their fitness score, colony density and age. This simulation outputs a full description of colony position, fitness and allelic makeup at the end of each generation.

## Installation

The only installation needed for this project is that of R, preferable version 4.0.4 (https://cran.r-project.org/bin/windows/base/old/4.0.4/), as well as the packages doParallel, foreach and tidyverse.

## Usage

To use this simulation, make sure all files are located in the same folder. Load R, and run the Sample_Input.R file. Edit the variables to your preference, each variable is described below:
Start_D - The leftmost bound for the population initialisation. In our publication, this is -1.
End_D - The rightmost bound for the population initialisation. In our publication, this is 1.
N_Ran_Queens - The number of queens the population initially begins with. This is recommended to be >3. In our publication, this is 10.
N_Initial_Alleles - The number of allele the population begins with. The population will cease functioning below 1 allele. In our publication, this is 7.
N_Unequal_Alleles - This function is intended for starting populations with unequal allele numbers. If you would like your population to start with a dominant or few dominant alleles, set this number as equal to the number of dominant alleles you want, such that the following is true: 0<N_Unequal_Alleles<N_Initial_Alleles. In our publication, this is 2.
Proportion_Unequal - This function is intended for starting populations with unequal allele numbers. This is intended to be between 0.5 and 1, and represents the frequency the dominant alleles cumulatively start at in the population. In our publication, this is 0.8.
Mean_Mates - This value is the average number of mates a queen will mate with, when not constrained by a lack of mates. In our publication, this is 29.
SD_Mates - This value is the standard deviation of mates a queen will mate with, when not constrained by a lack of mates. In our publication, this is 4.
Max_Jump - This is the maximum bound a colony can move in a single generation, and is intended to represent the maximum distance a colony could fly to look for a new nest location. In our publication, this is 10.
radius_sight - This is the distance around a new colony, before moving, in which it can detect neighbour density. This then determines which direction a colony will move, if the simulation is biased. In our publication, this is 4.
alpha_jump - This is a factor that could proportionally increase or decrease the distance a colony moves during dispersal. In our publication, this is 1, so this has no impact on the simulation.
Jump_sd - The standard deviation of of the normal distribution that models dispersal in this simulation. In our publication, this is 4.
K_Dist - The distance to the left and right of a colony that other colonies are included for carrying capacity calculations. In our publication, this is 0.5, meaning that colonies from a 1 unit block are included in carrying capacity calculations.
Male_Flight - The maximum distance in which colonies are considered to contribute drones to a virgin queens "mate pool". In our publication, this is 5.
WLColony - The chances that a colony has workers that produce drones while the colony is queenright. In our publication, this is 0, meaning no colonies have worker reproduction in the presence of a queen.
WBD_Chance - The proportion of drones in a colony that are produced by workers, if the colony has worker reproduction in the presence of a queen. In our publication, this is 0, as there are no colonies with worker reproduction in the presence of a queen.
A_Norm_Drones - The distance surrounding a virgin queen in which she travels to mate with drones - a value needed for drone density calculation. This input is intended to be small, but more than 0. In our publication, this is 0.5.
Max_Drones - The maximum number of drones produced by a healthy colony without any fitness losses. In our publication, this is 1000.
Drone_Spread - The standard deviation of of the normal distribution that models drone dispersal in this simulation. In our publication, this is 2.
GQL - The maximum lifespan of a queen. In our publication, this is 5.
Samp_Cutoff - This is an optimization parameter, intended to reduce computational time. This determines the maximum number of drones that are randomly selected from a drone producing colony, if a colony contributes more drones than this cutoff the extra drones are assigned to csd allele proportionally rather than stochastically. In our publication, this is 50.
Queenless_Chance - The chance a colony will become queenless during the reproductive phase, i.e., the likelihood a virgin queen dies during mating. In our publication, this is 0.3.
Chance_Mutate - The chance a csd allele mutates, In our publication, this is 0, indicating no mutation. This parameter is not optimised and may cause issues if changed.

The following parameter are highly important to simulation function, and were used in parameter optimisation
Iterations - The number of generations this simulates. In our publication, this is 20. Note, this significantly inflates the run time of the simulation, the initial generations grow as O^n, but later generations grow as n*logn, but each generation takes several hours to run through. This parameter must be 1 or above.
#K_Num - The carrying capacity of the simulation, per unit. In our publication, this is 30, 100 or 300. Not, this significantly inflates the run time of a simulations if large. It is not recommended that this parameter is set below 10.
#Max_Swarms - The number of swarms a colony produces without fitness losses, on average. In our publication, this is 2, 3 or 4. It is not recommended that this parameter is set below 1.5, and may result in early termination due to extinction.
#beta_jump - This determines the magnitude of the movement bias from surrounding colonies. In our publication, this is 0 or 5 or 10. Setting this below 0 would likely simulate populations with Allee effects. Setting this parameter at higher magnitudes than 10 may result in rapid dispersal/complete movement stagnancy and unrealistic models of movement.
#Samples - The number of times the simulation is run with the same parameter set. In our publication, this is 96. Note, this also significantly inflates simulation times if not parallelised.

Finally, there are some options for different function to be loaded, depending on the type of fitness function wanted. The following fitness functions warrant the following loaded functions:
Sigmoid Fitness
Create_Unequal_Queens.R
Carrying_Capacity_Random_NewFitness.R
Reproduce_NewFitness.R
New_Queen_Fitness.R

Linear Fitness
Create_Unequal_Queens.R
Carrying_Capacity_Random.R
Reproduce.R
New_Queen_Fitness.R

Unlinked Fitness
Create_Unequal_Queens_Unlinked.R
Carrying_Capacity_Random_NewFitness.R
Reproduce_NewFitness.R
New_Queen_Fitness_Unlinked.R

## License

Copyright (c) 2023 Thomas Hagan

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

