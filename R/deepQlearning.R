

library(package='neuralnet')
library(nnet)

R <- matrix(c(-1,  -1, -1, -1,   0, -1,
              -1,  -1, -1,  0,  -1,   0,
              -1,  -1, -1,  0,  -1,  -1, 
              -1,   0,  0, -1,   0,  -1,
              0,  -1, -1,  0,  -1,   0,
              -1, 100, -1, -1, 100, 100), nrow=6, ncol=6, byrow=TRUE)


initData = "state0 , state1, state2, state3,state4,state5,action0,action1,action2,action3,action4,action5
              1   ,   0    ,  0    ,   0   , 0    , 0    , 0.5     , 0.5     , 0.5     , 0.5     ,  0.5    , 0.5
"

trainData=read.csv(text=initData , header=TRUE)

model=nnet( x = trainData[, c('state0','state1','state2','state3','state4','state5')]  ,
            y = trainData[, c('action0','action1','action2','action3','action4','action5')]  ,
           hidden        =  20                  ,
           softmax       =  TRUE                 , 
           size          =  10                   )


findDx=function(statDx)
{
  if (names(statDx)=='state0') return (1)
  if (names(statDx)=='state1') return (2)
  if (names(statDx)=='state2') return (3)
  if (names(statDx)=='state3') return (4)
  if (names(statDx)=='state4') return (5)
  if (names(statDx)=='state5') return (6)
}


restartGame=function()
{
  trainData=read.csv(text=initData , header=TRUE)
  return(trainData)
}

showResult=function(result)
{
  old=paste('i:',i,'  ', displayStatus(result[[1]]), '  room ', fromWhichstateDx(trainData)-1, '->  room ', (result[[2]]-1))
  print(old)
}

trainNet=function(trainData, model, maxit)
{
  weights=model$wts 
  model=nnet( x = trainData[, c('state0','state1','state2','state3','state4','state5')]  ,
              y = trainData[, c('action0','action1','action2','action3','action4','action5')]  ,
              weigths       =  weights            , 
              hidden        =  20                  ,
              softmax       =  FALSE                 , 
              size          =  10                  ,
              maxit         =  maxit                   )
  return(model)
}


displayStatus=function(status) if(status==1) return("Alive") else return("Dead")

fromWhichstateDx=function(trainData)
{
  stateDx=which.max(trainData[ ,c('state0','state1','state2','state3','state4','state5')])
  stateDx=findDx(stateDx)
  return(stateDx)
}

playOneStepGame=function(trainData)
{
  
  predictData=predict(model, trainData[ ,c('state0','state1','state2','state3','state4','state5')] )
  stateDx=which.max(trainData[ ,c('state0','state1','state2','state3','state4','state5')])
  stateDx=findDx(stateDx)
  actionDx=which.max(predictData) 
  
  if (R[stateDx, actionDx]<0) 
  { 
    status="0"
  } else
  {
    status="1" 
  }
  return(list(status=status, actionDx=actionDx))
}
library(dplyr)




memory=NULL
for (k in 1:100)
{
  for (i in 1:100)
  {
  result=playOneStepGame(trainData)
  showResult(result)
  actionDx=result[[2]]
  trainData[,actionDx+6]= trainData[,actionDx+6] + R[fromWhichstateDx(trainData), actionDx]*0.3
  memory=distinct(rbind(memory,trainData))
  model=trainNet(memory,model, maxit=10)
  
  if (result[[1]]==0) 
  {
     trainData=restartGame()
  } else
  {
     if (actionDx==6) {print("Win");  trainData=restartGame(); break;}
     trainData=restartGame()
     trainData[, 1 ]=0
     trainData[, result[[2]] ]=1
     
  }
  }
}


