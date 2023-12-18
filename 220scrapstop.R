#7_31 modefication after meeting with Kelly. Don't need to solve for S in the scrap time. So 2 scenarios, either stop or continue in all time periods.
ab_values <- c(0.0003, 0.00015, 0.00012, 0.00009, 0.00006, 0.00003, 0)
C_R_values <- c(5450.866667, 8176.3, 8721.386667,	9266.473333,	9811.56,	10356.64667,	10901.73333)
p_values <- c(1.3, 1.59, 1.91)

beta <- 0.02
K <- 44000
gamma <- 0.8
ac <- 0.2
# ab <- 0.0003
# ab <- 0 #alpha=0.5
D <- 220
C_I <- 278.83
C_f<-642.64
C_M <- 849.84

N_0 = 4400 #20 per tree, 220 trees


#replant 220 trees 
# N =1000 0807 higher influx makes insecticides less valuable, but make resistant cultivar more attractive. Modify here to make real life sense numbers
N =500
ell = 2
r = 0.05
# phi = 36833.1250701846
# phi=22958.802

# Simulation Parameters
T <- 30
YieldF <- matrix(c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                   4.5, 4.5, 4.5, 4.275, 4.05, 3.6, 3.15, 2.7, 2.475, 2.025, 1.575, 1.125, 0.9, 0.7875, 0.675, 0.5625, 0.45, 0.3375, 0.225,
                   6, 6, 6, 5.7, 5.4, 4.8, 4.2, 3.6, 3.3, 2.7, 2.1, 1.5, 1.2, 1.05, 0.9, 0.75, 0.6, 0.45, 0.3,
                   7.7, 7.7, 7.7, 7.315, 6.93, 6.16, 5.39, 4.62, 4.235, 3.465, 2.695, 1.925, 1.54, 1.3475, 1.155, 0.9625, 0.77, 0.5775, 0.385,
                   9.6, 9.6, 9.6, 9.12, 8.64, 7.68, 6.72, 5.76, 5.28, 4.32, 3.36, 2.4, 1.92, 1.68, 1.44, 1.2, 0.96, 0.72, 0.48,
                   11.25, 11.25, 11.25, 10.6875, 10.125, 9, 7.875, 6.75, 6.1875, 5.0625, 3.9375, 2.8125, 2.25, 1.96875, 1.6875, 1.40625, 1.125, 0.84375, 0.5625,
                   12.825, 12.825, 12.825, 12.1838, 11.5425, 10.26, 8.9775, 7.695, 7.05375, 5.77125, 4.48875, 3.20625, 2.565, 2.24438, 1.92375, 1.60322, 1.2825, 0.96188, 0.64215,
                   14, 14, 14, 14, 13.3, 12.6, 11.9, 11.2, 10.5, 9.8, 8.4, 7.7, 7, 6.3, 5.6, 4.9, 4.2, 3.5, 2.8,
                   14.7, 14.7, 14.7, 14.7, 13.965, 13.23, 12.495, 11.76, 11.025, 10.29, 8.82, 8.085, 7.35, 6.615, 5.88, 5.145, 4.41, 3.675, 2.94,
                   16.1, 16.1, 16.1, 16.1, 15.295, 14.49, 13.685, 12.88, 12.075, 11.27, 9.66, 8.855, 8.05, 7.245, 6.44, 5.635, 4.83, 4.025, 3.22,
                   16.8, 16.8, 16.8, 16.8, 15.96, 15.12, 14.28, 13.44, 12.6, 11.76, 10.08, 9.24, 8.4, 7.56, 6.72, 5.88, 5.04, 4.2, 3.36,
                   17.5, 17.5, 17.5, 17.5, 16.625, 15.75, 14.875, 14, 13.125, 12.25, 10.5, 9.625, 8.75, 7.875, 7, 6.125, 5.25, 4.375, 3.5,
                   18.2, 18.2, 18.2, 18.2, 17.29, 16.38, 15.47, 14.56, 13.65, 12.74, 10.92, 10.01, 9.1, 8.19, 7.28, 6.37, 5.46, 4.55, 3.64,
                   18.9, 18.9, 18.9, 18.9, 17.955, 17.01, 16.065, 15.12, 14.175, 13.23, 11.34, 10.395, 9.45, 8.505, 7.56, 6.615, 5.67, 4.725, 3.78,
                   19.6, 19.6, 19.6, 19.6, 18.61, 17.64, 16.66, 15.68, 14.7, 13.72, 11.76, 10.78, 9.8, 8.82, 7.84, 6.86, 5.88, 4.9, 3.92,
                   20.3, 20.3, 20.3, 20.3, 19.285, 18.27, 17.255, 16.24, 15.225, 14.21, 12.18, 11.165, 10.15, 9.135, 8.12, 7.105, 6.09, 5.075, 4.06,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2, 
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2, 
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2, 
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2, 
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2, 
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2, 
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2,
                   21, 21, 21, 21, 19.95, 18.9, 17.85, 16.8, 15.75, 14.7, 12.6, 11.55, 10.5, 9.45, 8.4, 7.35, 6.3, 5.25, 4.2), nrow = 60, ncol = 19, byrow = TRUE)

# Initialize the arrays to store the population sizes
N_t <- rep(0, T+1)
Z_t <- rep(0, T+1)
X_t <- rep(0, T+2)
Y_t <- rep(0, T+1)
# max_NPV_indices <- rep(0, T)
# optimal_replanting_times <- rep(0, T)
# NPVS_A <- matrix(0, nrow = T, ncol = 20)
# YIELDS_A <- matrix(0, nrow = T, ncol = 20)
# PROFITS_A <- matrix(0, nrow = T, ncol = 20)
# Revenue_A <- matrix(0, nrow = T, ncol = 20)

# Initialize a list to store all the results
list_of_allresults <-list()

# Loop over the different scenarios
for (scenario in 1:length(ab_values)) {
  
  # Update the ab and C_R parameters
  ab <- ab_values[scenario]
  C_R <- C_R_values[scenario]
  
  # Initialize a list to store the results of all price scenarios
  pricescenarios <-list()
  
  # Loop over the different price values
  for (iii in 1:length(p_values)) {
    p <- p_values[iii]
    # Initialize a data frame to store the results
    results <- data.frame(initial_age = integer(), ab = numeric(), C_R = numeric(), p = numeric(), NPV = numeric(), T = integer())
    
    # Loop over possible initial ages
    for (initial_age in 1:20) {
      Trees <- matrix(0, nrow = initial_age + T, ncol = 19)
      # Initialize variables for the current initial age
      max_NPV <- -Inf
      optimal_T <- 0
      
      # Calculate the initial population sizes
      q = 10 #80% of all FL trees are infected (x and y)evenly distributed across 18 infected classes, so 10 max per class (D=225)
      #change for D=300, 13 max for q. 
      
      if (initial_age >= 18)
        
      {asym1 = q#change backlog of disease when age < 18
      asym2 = q
      sym1 = q
      sym2 = q
      sym3 = q
      sym4 = q
      sym5 = q
      sym6 = q
      sym7 = q
      sym8 = q
      sym9 = q
      sym10 = q
      sym11 = q
      sym12 = q
      sym13 = q
      sym14 = q
      sym15 = q
      sym16 = q
      } else if (initial_age == 17)
      {asym1 = q
      asym2 = q
      sym1 = q
      sym2 = q
      sym3 = q
      sym4 = q
      sym5 = q
      sym6 = q
      sym7 = q
      sym8 = q
      sym9 = q
      sym10 = q
      sym11 = q
      sym12 = q
      sym13 = q
      sym14 = q
      sym15 = q
      sym16 = 0}
      
      else if (initial_age ==16)
      {asym1 = q
      asym2 = q
      sym1 = q
      sym2 = q
      sym3 = q
      sym4 = q
      sym5 = q
      sym6 = q
      sym7 = q
      sym8 = q
      sym9 = q
      sym10 = q
      sym11 = q
      sym12 = q
      sym13 = q
      sym14 = q
      sym15 = 0
      sym16 = 0
      }
      
      else if (initial_age ==15)
      {asym1 = q
      asym2 = q
      sym1 = q
      sym2 = q
      sym3 = q
      sym4 = q
      sym5 = q
      sym6 = q
      sym7 = q
      sym8 = q
      sym9 = q
      sym10 = q
      sym11 = q
      sym12 = q
      sym13 = q
      sym14 = 0
      sym15 = 0
      sym16 = 0
      }
      
      else if (initial_age==14)
      {asym1 = q
      asym2 = q
      sym1 = q
      sym2 = q
      sym3 = q
      sym4 = q
      sym5 = q
      sym6 = q
      sym7 = q
      sym8 = q
      sym9 = q
      sym10 = q
      sym11 = q
      sym12 = q
      sym13 = 0
      sym14 = 0
      sym15 = 0
      sym16 = 0
      }
      else if (initial_age==13)
      {asym1 = q
      asym2 = q
      sym1 = q
      sym2 = q
      sym3 = q
      sym4 = q
      sym5 = q
      sym6 = q
      sym7 = q
      sym8 = q
      sym9 = q
      sym10 = q
      sym11 = q
      sym12 = 0
      sym13 = 0
      sym14 = 0
      sym15 = 0
      sym16 = 0
      }
      else if (initial_age==12)
      {asym1 = q
      asym2 = q
      sym1 = q
      sym2 = q
      sym3 = q
      sym4 = q
      sym5 = q
      sym6 = q
      sym7 = q
      sym8 = q
      sym9 = q
      sym10 = q
      sym11 = 0
      sym12 = 0
      sym13 = 0
      sym14 = 0
      sym15 = 0
      sym16 = 0
      }
      else if (initial_age==11)
      {asym1 = q
      asym2 = q
      sym1 = q
      sym2 = q
      sym3 = q
      sym4 = q
      sym5 = q
      sym6 = q
      sym7 = q
      sym8 = q
      sym9 = q
      sym10 = 0
      sym11 = 0
      sym12 = 0
      sym13 = 0
      sym14 = 0
      sym15 = 0
      sym16 = 0
      }
      else if (initial_age==10)
      {asym1 = q
      asym2 = q
      sym1 = q
      sym2 = q
      sym3 = q
      sym4 = q
      sym5 = q
      sym6 = q
      sym7 = q
      sym8 = q
      sym9 = 0
      sym10 = 0
      sym11 = 0
      sym12 = 0
      sym13 = 0
      sym14 = 0
      sym15 = 0
      sym16 = 0
      }
      else if (initial_age==9)
      {asym1 = q
      asym2 = q
      sym1 = q
      sym2 = q
      sym3 = q
      sym4 = q
      sym5 = q
      sym6 = q
      sym7 = q
      sym8 = 0
      sym9 = 0
      sym10 = 0
      sym11 = 0
      sym12 = 0
      sym13 = 0
      sym14 = 0
      sym15 = 0
      sym16 = 0
      }
      
      else if (initial_age==8)
      {asym1 = q
      asym2 = q
      sym1 = q
      sym2 = q
      sym3 = q
      sym4 = q
      sym5 = q
      sym6 = q
      sym7 = 0
      sym8 = 0
      sym9 = 0
      sym10 = 0
      sym11 = 0
      sym12 = 0
      sym13 = 0
      sym14 = 0
      sym15 = 0
      sym16 = 0
      }
      else if (initial_age == 7)
      {asym1 = q
      asym2 = q
      sym1 = q
      sym2 = q
      sym3 = q
      sym4 = q
      sym5 = q
      sym6 = 0
      sym7 = 0
      sym8 = 0
      sym9 = 0
      sym10 = 0
      sym11 = 0
      sym12 = 0
      sym13 = 0
      sym14 = 0
      sym15 = 0
      sym16 = 0
      }
      else if (initial_age ==6)
      {asym1 = q
      asym2 = q
      sym1 = q
      sym2 = q
      sym3 = q
      sym4 = q
      sym5 = 0
      sym6 = 0
      sym7 = 0
      sym8 = 0
      sym9 = 0
      sym10 = 0
      sym11 = 0
      sym12 = 0
      sym13 = 0
      sym14 = 0
      sym15 = 0
      sym16 = 0
      }
      
      else if (initial_age ==5)
      {asym1 = q
      asym2 = q
      sym1 = q
      sym2 = q
      sym3 = q
      sym4 = 0
      sym5 = 0
      sym6 = 0
      sym7 = 0
      sym8 = 0
      sym9 = 0
      sym10 = 0
      sym11 = 0
      sym12 = 0
      sym13 = 0
      sym14 = 0
      sym15 = 0
      sym16 = 0
      }
      else if (initial_age==4)
      {asym1 = q
      asym2 = q
      sym1 = q
      sym2 = q
      sym3 = 0
      sym4 = 0
      sym5 = 0
      sym6 = 0
      sym7 = 0
      sym8 = 0
      sym9 = 0
      sym10 = 0
      sym11 = 0
      sym12 = 0
      sym13 = 0
      sym14 = 0
      sym15 = 0
      sym16 = 0
      }
      else if (initial_age==3)
      {asym1 = q
      asym2 = q
      sym1 = q
      sym2 = 0
      sym3 = 0
      sym4 = 0
      sym5 = 0
      sym6 = 0
      sym7 = 0
      sym8 = 0
      sym9 = 0
      sym10 = 0
      sym11 = 0
      sym12 = 0
      sym13 = 0
      sym14 = 0
      sym15 = 0
      sym16 = 0
      }
      else if (initial_age==2)
      {asym1 = q
      asym2 = q
      sym1 = 0
      sym2 = 0
      sym3 = 0
      sym4 = 0
      sym5 = 0
      sym6 = 0
      sym7 = 0
      sym8 = 0
      sym9 = 0
      sym10 = 0
      sym11 = 0
      sym12 = 0
      sym13 = 0
      sym14 = 0
      sym15 = 0
      sym16 = 0
      }
      else if (initial_age==1) 
      {asym1 = q
      asym2 = 0
      sym1 = 0
      sym2 = 0
      sym3 = 0
      sym4 = 0
      sym5 = 0
      sym6 = 0
      sym7 = 0
      sym8 = 0
      sym9 = 0
      sym10 = 0
      sym11 = 0
      sym12 = 0
      sym13 = 0
      sym14 = 0
      sym15 = 0
      sym16 = 0
      }
      
      Y1 = sym1 + sym2 + sym3 + sym4 + sym5 + sym6 + sym7 + sym8 + sym9 + sym10 + sym11 + sym12 + sym13 + sym14 + sym15 + sym16 #total symptomatic
      X1 = asym1 #new asympto
      X2 = asym2 #second year asympto
      Trees[initial_age, 1] <- D - (asym1 + asym2 + sym1 + sym2 + sym3 + sym4 + sym5 + sym6 + sym7 + sym8 + sym9 + sym10 + sym11 + sym12 + sym13 + sym14 + sym15 + sym16)  # Initial number of healthy trees
      Trees[initial_age, 2] <- asym1
      Trees[initial_age, 3] <- asym2
      Trees[initial_age, 4] <- sym1
      Trees[initial_age, 5] <- sym2
      Trees[initial_age, 6] <- sym3
      Trees[initial_age, 7] <- sym4
      Trees[initial_age, 8] <- sym5
      Trees[initial_age, 9] <- sym6
      Trees[initial_age, 10] <- sym7
      Trees[initial_age, 11] <- sym8
      Trees[initial_age, 12] <- sym9
      Trees[initial_age, 13] <- sym10
      Trees[initial_age, 14] <- sym11
      Trees[initial_age, 15] <- sym12
      Trees[initial_age, 16] <- sym13
      Trees[initial_age, 17] <- sym14
      Trees[initial_age, 18] <- sym15
      Trees[initial_age, 19] <- sym16
      
      # Assuming X_t, Y_t are matrices or data frames
      X_t[1] <- X1  # Assign X1 to the first column of X_t
      X_t[2] <- X2  # Assign X2 to the second column of X_t
      Y_t[1] <- Y1  # Assign Y1 to the first column of Y_t
      N_t[1] <- N_0
      # Initialize the Trees matrix
      yields <- numeric (T)
      totalyield <-numeric (T)
      profits <- numeric(T)
      revenues <- numeric(T)
      totalrevenue <-numeric (T)
      # npvs <- numeric(T)
      # cumulnpv <-numeric (T)
      # # Loop over possible Stopping spraying time values
      # for (S in 1:T) {
      
      # time loop
      for (t in 1:T) {
        # Calculate the initial population sizes
        # q = 10 #80% of all FL trees are infected (x and y)evenly distributed across 18 infected classes, so 10 max per class (D=225)
        #change for D=300, 13 max for q. 
        
        # Set the initial values
        # max_age <- min(a + T, 31)
        # profits <- numeric(T)
        
        
        # Simulate the population dynamics
        # for (i in 1:t)) {
        # age <- a + t - 1  # Calculate the current age
        # N_t[t+1] <- round(N_t[t] + beta * N_t[t] * ((1 - N_t[t])/K) - gamma * N_t[t] + N)
        # # Modify the equation for N_t
        # if (t >= S) {
        N_t[t+1] <- round(N_t[t] + beta * N_t[t] * (1 - (N_t[t]/K)) + N)
        # } else {
        #   N_t[t+1] <- round(N_t[t] + beta * N_t[t] * ((1 - N_t[t])/K) - gamma * N_t[t] + N)
        # }
        Z_t[t+1] <- round(ac * N_t[t+1] *  ((X_t[t] + X_t[t+1] + Y_t[t] )/ D )+ 0.8*N)
        X_t[t+2] <- round(ab * Z_t[t+1] * (D -(X_t[t] + X_t[t+1] + Y_t[t]) ))
        Y_t[t+1] <- Y_t[t] + X_t[t] 
      }
      # Calculate the population sizes
      
      for (i in initial_age:T) {
        if (Trees[i, 1]>1) {
          Trees[i+1, 1] <- max((Trees[i, 1] - round(ab * Z_t[i-initial_age+2] * Trees[i, 1]) ), 0)
        } else {
          Trees[i+1, 1] <-0
        }
        Trees[i+1, 2] <- round(ab * Z_t[i-initial_age+2] * Trees[i, 1])
        for (j in 3:19) {
          Trees[i+1, j]<-Trees[i, j-1]
        }
      }
      # }
      # Calculate the profit profits[t] <- profit
      # profit <- sum(sum(p * YieldF[a:age, ] * Trees[a:age,])) - C_I * t - C_M * t - C_R
      
      # Calculate the NPV
      #profit <- sum(sum(p * YieldF[a:age, ] * Trees[a:age, ])) - C_I * t - C_M * t - C_R
      # revenue <- sum(p * YieldF[initial_age: initial_age+t, ] * Trees[initial_age: initial_age+t, ])
      for (ii in 1:T) {
        yield <- sum(YieldF[initial_age: initial_age+ii-1, ] * Trees[initial_age: initial_age+ii-1, ])
        yields[ii] <- yield
        totalyield[ii]<-sum(yields[1:ii])
        revenue <- p * yield
        revenues[ii] <- revenue
        totalrevenue[ii]<-sum(revenues[1:ii])
        profits[ii] <- totalrevenue[ii] - C_f * ii - C_M * ii - C_R
        
        # Modify the equation for profits
        # profits[ii] <- totalrevenue[ii]- C_I * (S-1)- C_f * ii - C_M * ii - C_R
        # Calculate the Net Present Value (NPV)
        # NPV <- (profit+ phi)/ ((1 + r)^ii)
        # NPV <- (profits[ii])/ ((1 + r)^ii) this for solving the current period
        NPV <- profits[ii]/((1 + r)^ii-1)
        # npvs[t] <-  (profits[t])/ ((1 + r)^t)
        if (NPV > max_NPV) {
          max_NPV <- NPV
          optimal_T <- ii #this is the optimal t for that initial age
        }
      }
      # Add the maximum NPV and the optimal T and S for the current scenario and price to the results data frame
      results <- rbind(results, data.frame(a = initial_age, ab = ab, C_R = C_R, p = p, NPV = max_NPV, T = optimal_T))
      
      # results <- rbind(results, data.frame(a = initial_age, NPV = max_NPV, T = optimal_T, S = optimal_S))
    }
    pricescenarios[[iii]]<- results
  }
  list_of_allresults[[scenario]]<-pricescenarios
}

# Save the list_of_allresults to a .rds file
saveRDS(list_of_allresults, file = "C:/Users/juanj/Desktop/RA/Research/citrus supply chain/modeling/results/220scrapstop.rds")
# Read the list_of_allresults from a .rds file
list_of_allresults <- readRDS("C:/Users/juanj/Desktop/RA/Research/citrus supply chain/modeling/results/220scrapstop.rds")
# Flatten the list of lists of data frames to a single data frame
flat_df <- do.call(rbind, do.call(rbind, list_of_allresults))

# Write the data frame to a CSV file
write.csv(flat_df, file = "C:/Users/juanj/Desktop/RA/Research/citrus supply chain/modeling/results/220scrapstop.csv")

# Print the results
# print(results)
# Calculate the Net Present Value (NPV)
# plot(npvs,type="l")
# npv_data <- data.frame(NPVS_A)
# # Set the names for the columns
# col_names <- c("NPV")
# colnames(npv_data) <- col_names
# 
# write_xlsx(npv_data, output_file)
# # Find the optimal replanting time
# optimal_time <- which.max(npvs)
# optimal_npv <- npvs[optimal_time]
# npvs

# # Print the results
# cat("Optimal Replanting Time:", optimal_time, "\n")
# cat("Optimal NPV:", optimal_npv, "\n")
# warnings()

