source("./R/bsPlainVanilla.R")
source("./R/distribution.R")
source("./R/quadratic.R")
source("./R/sabr.R")
source("./R/SVI.R")
source("./R/vols.R")

load("./data/opt_chain.rda")

sabrVol_ <- calibrate(opt_chain,as.Date("2017-07-11"),model="sabr")
sviVol_ <- calibrate(opt_chain,as.Date("2017-07-11"),model="SVI")
quadVol_ <- calibrate(opt_chain,as.Date("2017-07-11"))
k <- seq(9000,10000,0.5)
vols1 <- getVol(sabrVol_,1,k)
vols2 <- getVol(quadVol_,1,k)
vols3 <- getVol(sviVol_,1,k)
plot(k,vols3,type="l")
lines(k,vols1,col="red")
lines(k,vols2,col="blue")
lines(k,vols3,col="black")

for(i in 1:10){
  volsss[i] <- sviVol(vol$f[1],strike[i],vol$a,vol$b,vol$sigma,vol$rho,vol$m)
}


voldist <- impliedDistribution(sviVol_)
plot(voldist$k,voldist$p,type="n")
lines(voldist$k,voldist$p,col="blue")
distributionPricer(100,101,voldist,type="call")

#Helloworld


install.packages('rvest')
library(rvest)
url<-"http://www.eurexchange.com/exchange-en/products/fx/fx/EUR-USD-Options/650654"
webpage <- read_html(url)
rank_data_html <- html_nodes(webpage,'span')
rank_data <- html_text(rank_data_html)
