source("https://raw.githubusercontent.com/NicoleRadziwill/R-Functions/master/qlearn.R")

R <- matrix(c(-1,  -1, -1, -1,   0,   1,
              -1,  -1, -1,  0,  -1,   0,
              -1,  -1, -1,  0,  -1,  -1, 
              -1,   0,  0, -1,   0,  -1,
               0,  -1, -1,  0,  -1,   0,
              -1, 100, -1, -1, 100, 100), nrow=6, ncol=6, byrow=TRUE)

results <- q.learn(R,10000,alpha=0.1,gamma=0.8,tgt.state=6) 
round(results)
#[,1] [,2] [,3] [,4] [,5] [,6]
#[1,]    0    0    0    0   64   80
#[2,]    0    0    0   51    0   80
#[3,]    0    0    0   51    0    0
#[4,]    0   64   41    0   64    0
#[5,]   64    0    0   51    0   80
#[6,]    0   84    0    0   84  100

#https://www.r-bloggers.com/2017/12/a-simple-intro-to-q-learning-in-r-floor-plan-navigation/