source("./R/bsPlainVanilla.R")
source("./R/distribution.R")
source("./R/quadratic.R")
source("./R/sabr.R")
source("./R/vols.R")

load("./data/opt_chain.rda")

sabrVol <- calibrate(opt_chain,as.Date("2017-07-11"),model="sabr")
quadVol <- calibrate(opt_chain,as.Date("2017-07-11"))
k <- seq(90,110,0.5)
vols1 <- getVol(sabrVol,100,k)
vols2 <- getVol(quadVol,100,k)
plot(k,vols1,type="n")
lines(k,vols1,col="red")
lines(k,vols2,col="blue")


voldist <- impliedDistribution(sabrVol)
plot(voldist$k,voldist$p,type="n")
lines(voldist$k,voldist$p,col="blue")
distributionPricer(100,101,voldist,type="call")

#Helloworld