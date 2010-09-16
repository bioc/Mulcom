mulCAND <- function(eset, Mulcom_P, m, t, ese = "T"){
   if(class(eset) == "ExpressionSet" & class(Mulcom_P) == "MULCOM_P" & is.numeric(m) & is.numeric(t)){
      if(ese == "T"){
         d <- abs(Mulcom_P@FC)-(Mulcom_P@MSE_Corrected*t)
         d[which(d < m)]=0; 
         d[-which(d < m)]=1
         tmp <- apply(d, 2, max)
         test <- d[,which(tmp == "1")]
         out <- eset[which(tmp == "1"),]
         return(list(eset = out, dunnett = test))
      }else{
         d <- abs(Mulcom_P@FC) - (Mulcom_P@MSE_Corrected * t)
         d[which(d < m)]=0; 
         d[-which(d < m)]=1
         tmp=apply(d, 2, max)
         out <- featureNames(eset[which(tmp == "1"),])
      }
   }else{
      stop("error in input files", call.=FALSE)
   }
}





