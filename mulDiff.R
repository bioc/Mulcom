mulDiff <-
function(eset, Mulcom_P, m, t, ind){
   if(class(eset) == "ExpressionSet" & class(Mulcom_P) == "MULCOM_P" & is.numeric(m) & is.numeric(t)){
   tmp <- mulCAND(eset, Mulcom_P, m, t)
#   return(tmp)
   out <- featureNames(tmp$eset)[which(tmp$dunnett[ind,]>0)]
   return(out)
   }else{
      stop("error in input files", call. = FALSE)
   }
}

