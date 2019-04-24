\name{mulDiff}
\alias{mulDiff}
\title{MulCom Test Differential analysis}
\description{
<<<<<<< HEAD
  Identify the differentially expressed features for a specific comparison with given m and t value}
=======
  Identify the differentially expressed features for a specific comparison with given m and t value
}
>>>>>>> upstream/master
\usage{
mulDiff(eset, Mulcom_P, m, t, ind)
}
\arguments{
<<<<<<< HEAD
  \item{eset}{An ExpressionSet object from package Biobase}
=======
  \item{eset}{An ExpressionSet object from package affy}
>>>>>>> upstream/master
  \item{Mulcom_P}{An object of class Mulcom_P}
  \item{m}{the m values for the analysis}
  \item{t}{the t values for the analysis}
  \item{ind}{and index refeing to te comparison, should be numeric}
}
\value{
<<<<<<< HEAD
  \item{eset}{An ExpressionSet object from package Biobase}
=======
  \item{eset}{An ExpressionSet object from package affy}
>>>>>>> upstream/master
  \item{Mulcom_P}{An object of class Mulcom_P}
  \item{m}{the m values for the analysis}
  \item{t}{the t values for the analysis}
  \item{ind}{and index refeing to te comparison, should be numeric}
}

\examples{
data(benchVign)
mulcom_perm <- mulPerm(Affy, Affy$Groups, 10, 7)
mulcom_diff <- mulDiff(Affy, mulcom_perm, 0.2, 2)
}



\author{Claudio Isella, \email{claudio.isella@ircc.it}}
\keyword{MulCom}
