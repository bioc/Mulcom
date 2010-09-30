mulScores <-
function(eset, index){
   if(class(eset) == "ExpressionSet" & is.vector(index) ){
      mulcom <- new("MULCOM")
      data <- as.vector(as.matrix(exprs(eset)))
      groups <- index
      ngroups <- length(levels(factor(groups)))
      means <- c( seq ( 0, 0, length = ( (dim(eset))[1] * ( ngroups - 1 ) ) ) )
      SS <- c( seq ( 0, 0, length = ( (dim(eset))[1] * ngroups ) ) )
      harmonic_means <- c(seq(0, 0, length=ngroups-1 ) )
      n <- as.integer((dim(eset))[1])
      m <- as.integer((dim(eset))[2])
      reference <- c( 0 )
      means <- .C("fast_mean", as.double(data), as.double(means), as.integer(n), as.integer(m), as.integer(groups), as.integer(reference),PACKAGE = "Mulcom")
      harm <- .C("fast_harmonic_sample_size", as.double(harmonic_means), as.integer(m), as.integer(groups), as.integer(reference),PACKAGE = "Mulcom")
      harmDF <- data.frame(matrix(harm[[1]], ncol=ngroups-1,byrow=TRUE))
      mulcom@FC <- t(data.frame(matrix(means[[2]], ncol=(ngroups-1), byrow=TRUE), row.names=featureNames(eset)))
      sumsq <- .C("fast_SS", as.double(data), as.double(SS) , as.integer(n), as.integer(m), as.integer(groups),PACKAGE = "Mulcom")
      sumsqDF <- data.frame(matrix(sumsq[[2]], ncol=ngroups,byrow=TRUE), row.names=featureNames(eset))
      df <- length(groups) - ngroups
      sss <-  apply(sumsqDF,1,sum)
      mse <- sqrt((sss*2/df)%*%harmDF^-1)
      mulcom@MSE_Corrected <- t(mse)
      return(mulcom)
   }else{ 
      stop("error in input files", call. = FALSE)
   }
}

