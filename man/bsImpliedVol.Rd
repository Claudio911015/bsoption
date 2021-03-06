% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bsPlainVanilla.R
\name{bsImpliedVol}
\alias{bsImpliedVol}
\title{Compute implied volatility of plain vanilla European options from market
price}
\usage{
bsImpliedVol(date, forward, strike, expiry, price, type = "call",
  discount = 1, model = "lognormal")
}
\arguments{
\item{date}{Value date of the option.}

\item{forward}{Forward level(s) of the underlying.}

\item{strike}{strike(s) of the option.}

\item{expiry}{Expiry date(s).}

\item{price}{Option market price(s).}

\item{type}{Option type - "call" or "put".}

\item{discount}{Discount factor.}

\item{model}{Model type, only lognormal is implemented.}
}
\value{
Implied volatility estimate. The function is vectorized.
}
\description{
Compute implied volatility of plain vanilla European options
from market price using lognormal Black-76 model.
}
\details{
Black's formula is arguably more useful for pricing index options
compared to traditional Black-Scholes formula. The Black-76 option pricing
model uses the price of futures directly, instead of accreting the spot
index at the cost of carry. This is useful where the index futures trade
at prices below spot plus cost of carry, providing a model consistent with
market. In many places this is now standard to use Black-76 for index
options valuation for margining and fair value determination purposes.
}

