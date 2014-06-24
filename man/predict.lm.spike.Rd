% Copyright 2010 Google Inc. All Rights Reserved.
% Author: stevescott@google.com (Steve Scott)

\name{predict.lm.spike}
\Rdversion{1.1}
\alias{predict.lm.spike}
\alias{predict.logit.spike}
\title{
  Predictions using spike-and-slab regression.
}
\description{
  Generate draws from the posterior predictive distribution of a spike
  and slab regression.
}

\usage{
  \method{predict}{lm.spike}(object, newdata, burn = 0, na.action = na.pass, ...)
  \method{predict}{logit.spike}(object, newdata, burn = 0,
                      type = c("prob", "logit", "link", "response"),
                      na.action = na.pass, ...)
}
\arguments{
  \item{object}{
    An object of class \code{lm.spike}.
  }

  \item{newdata}{
    A data frame, matrix, or vector containing the predictors needed to
    make the prediction.  If \code{newdata} is a \code{data.frame} it
    must contain variables with the same names as the data frame used to
    fit \code{object}.  If it is a \code{matrix}, it must have the same
    number of columns as \code{object$beta}.  An intercept term will be
    implicitly added if the number of columns is too small by one.  If the
    dimension of \code{object$beta} is 1 or 2, then \code{newdata} can
    be a vector. }

  \item{burn}{
    The number of MCMC iterations in the object to be discarded as
    burn-in.
  }

  \item{na.action}{a function which indicates what should happen when
    the data contain \code{NA}'s.  The default is set by the
    \code{na.action} setting of \code{\link{options}}, and is
    \code{\link{na.fail}} if that is unset.  The "factory-fresh" default
    is \code{\link{na.omit}}.  Another possible value is \code{NULL}, no
    action.  Value \code{\link{na.exclude}} can be useful.}

  \item{type}{ The type of prediction desired.  If \code{prob} then the
    prediction is returned on the probability scale.  If \code{logit}
    then it is returned on the logit scale (i.e. the scale of the linear
    predictor).  Also accepts \code{link} and \code{response} for
    compatibility with \code{predict.glm}.  }

  \item{\dots}{Unused, but present for compatibility with generic \code{predict()}.}

}
\value{
  Returns a matrix of predictions, with each row corresponding to a row
  in newdata, and each column to an MCMC iteration.
}

\author{
  Steven L. Scott
}

\seealso{
  \code{\link{lm.spike}}
  \code{\link{SpikeSlabPrior}}
  \code{\link{summary.lm.spike}}
  \code{\link{plot.lm.spike}}
}

\examples{
  niter <- 1000
  n <- 100
  p <- 10
  ngood <- 3

  x <- cbind(1, matrix(rnorm(n * (p-1)), nrow=n))
  beta <- rep(0, p)
  good <- sample(1:p, ngood)
  beta[good] <- rnorm(ngood)
  sigma <- 1

  y <- rnorm(n, x \%*\% beta, sigma)
  model <- lm.spike(y ~ x - 1, niter=niter)
  plot(model)
  plot.ts(model$beta)
  hist(model$sigma)  ## should be near true value

  new.x <- cbind(1, matrix(rnorm(100 * (p-1)), ncol = (p-1)))
  pred <- predict(model, newdata = new.x, burn = 100)
}
\keyword{models, regression}