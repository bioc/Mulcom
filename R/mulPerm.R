mulPerm <- function(eset, index, np, seed){
   if (class(eset) == "ExpressionSet" & is.vector(index) & is.numeric(np) & is.numeric(seed) | class(eset) == "matrix" | class(eset) == "data.frame") {
      
#      if(class(eset) == "ExpressionSet"){
         
         mul <- new("MULCOM_P")
         
         multest <- mulScores(eset, index)
         
#         return(multest)
         mul <- new("MULCOM_P")
         mul@FC <- multest@FC
         mul@MSE_Corrected <- multest@MSE_Corrected
         
         set.seed(seed)

         fc <- vector()
         mse <- vector()

         ngroups <- length(levels(factor(index)))
         means <- c( seq ( 0, 0, length = ( (dim(eset))[1] * ( ngroups - 1 ) * np ) ) )
         mse <- c( seq ( 0, 0, length = ( (dim(eset))[1] * ( ngroups - 1 ) * np ) ) )
         
         n <- as.integer((dim(eset))[1])
         m <- as.integer((dim(eset))[2])
         reference <- c(0)
         
         rand_ind <- mulIndex(index, np = np, seed = seed)
         
         mul_out <- mulPermC(eset, rand_ind, means, mse, n, m, np, ngroups, reference)
         
         mul@FCp <- as.matrix(mul_out[[3]])
         dim(mul@FCp) <- c(c(ngroups -1),dim(eset)[1],np)

         mul@MSE_Correctedp <- as.matrix(mul_out[[4]])
         dim(mul@MSE_Correctedp) <- c(c(ngroups -1),dim(eset)[1],np)

         return(mul)
#      }else{
#         print("hello")
#      }
   }else{

      stop("error in input files", call. = FALSE)

   }
}



