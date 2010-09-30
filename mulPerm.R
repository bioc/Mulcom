mulPerm <- function (eset, index, np = 10, seed = 1){
    if (class(eset) == "ExpressionSet" & is.vector(index) & is.numeric(np) &
        is.numeric(seed)) {
        mul <- new("MULCOM_P")
        b <- mulScores(eset, index)
        mul@FC <- b@FC
        mul@MSE_Corrected <- b@MSE_Corrected
        set.seed(seed)
        fc <- vector()
        mse <- vector()
        quant <- quantile(1:np, seq(0, 1, 0.1))
        h <- 1
        ind <- quant[h]
        message("MulCom permutation starts")
        packageStartupMessage("initializing ...", appendLF = TRUE)
        for (i in 1:np) {
            tmp <- sample(index)
            while (min(tapply(sample(index), as.vector(index),
                function(x) {
                  length(unique(x))
                })) == 1) {
                tmp <- sample(index)
            }

            if(i > ind){
               h <- h+1
               ind <- quant[h]
               packageStartupMessage(paste(names(quant[h]), "\r"), appendLF = FALSE)
            }
            a <- mulScores(eset, tmp)
            fc <- cbind(fc, a@FC)
            mse <- cbind(mse, a@MSE_Corrected)
        }
        packageStartupMessage("Done")
        dim(fc) <- c(dim(a@FC), np)
        mul@FCp <- fc
        dim(mse) <- c(dim(a@MSE_Corrected), np)
        mul@MSE_Correctedp <- mse
        return(mul)
    }
    else {
        stop("error in input files", call. = FALSE)
    }
}


