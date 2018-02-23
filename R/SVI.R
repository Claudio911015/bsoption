
sviVol <- function(f,k,a,b,sigma,rho,m){
  x<-f/k-1
    
  y<-a + b * (rho*(x-m) + sqrt( (x-m)^2 + sigma^2 ) )
  
  return(y)
}

squared_error_svi <- function(params,strikes,IV,fwd){
  N <- NROW(strikes)
  err <- rep(0,N)
  f <- fwd
  a <- params[1]
  b <- params[2]
  sigma<-params[3]
  rho<-params[4]
  m<-params[5]
  for(i in 1:N){
    err[i] <- (sviVol(f,strikes[i],a,b,sigma,rho,m) - IV[i])^2
  }
  y <- sum(err)
  
  # penalities for non-admissible values of r and v
  #if(abs(r)>1) y <- Inf
  #if(v<0) y <- Inf
  
  return(y)
}
calibrate.svivol <- function(options, valuedate, atmvol, precision){

  f <- options$forward[1]
  strikes <- options$strike
  IV <- options$IV
  params <- c(-0.5,0.5,.5,.5,.5)
  fit <- stats::optim(params,fn=squared_error_svi, method = "SANN",
                      strikes=strikes,IV=IV,fwd=f)
  
  if(sqrt(fit$value)/NROW(strikes) > 1e-03){
    rms <- round(sqrt(fit$value)/NROW(strikes),6)
    warning(paste("Average error:",rms,". Goodness of fit is below threshold."))
  }
  
  a<-fit$par[1]
  b<-fit$par[2]
  sigma<-fit$par[3]
  rho<-fit$par[4]
  m<-fit$par[5]
  
  r = fit$par[1]
  v=fit$par[2]
  discfact <- 1
  if(!is.na(match("discount",colnames(options))))discfact<-options$discount[1]
  vol <- list(valuedate=valuedate, atmvol=atmvol,a=a,b=b,sigma=sigma,rho=rho,m=m,discfact=discfact)
  class(vol) <- "svivol"
  return(vol)
}

#'@export
getVol.svivol <- function(vol,atm, strike){
  N <- max(NROW(atm),NROW(strike))
  strike <- utils::head(rep(strike,N),N)
  atm <- utils::head(rep(atm,N),N)
  vols <- rep(0,N)
  
  for(i in 1:N){
    vols[i] <- sviVol(9774.35,strike[i],vol$a,vol$b,vol$sigma,vol$rho,vol$m)
  }
  
  return(vols)
}

