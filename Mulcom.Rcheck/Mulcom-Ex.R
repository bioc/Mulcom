pkgname <- "Mulcom"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('Mulcom')

assign(".oldSearch", search(), pos = 'CheckExEnv')
cleanEx()
nameEx("MULCOM-class")
### * MULCOM-class

flush(stderr()); flush(stdout())

### Name: MULCOM-class
### Title: Class MulCom
### Aliases: class:MULCOM MULCOM-class MULCOM
### Keywords: classes

### ** Examples

data(benchVign)
mulcom_scores <- mulScores(Affy, Affy$Groups)



cleanEx()
nameEx("MULCOM_P")
### * MULCOM_P

flush(stderr()); flush(stdout())

### Name: MULCOM_P-class
### Title: Class MulCom Permutation
### Aliases: class:MULCOM_P MULCOM_P-class MULCOM_P
### Keywords: classes

### ** Examples

data(benchVign)
mulcom_scores <- mulScores(Affy, Affy$Groups)



cleanEx()
nameEx("mulCAND")
### * mulCAND

flush(stderr()); flush(stdout())

### Name: mulCAND
### Title: Identify the Mulcom candidate feature selection
### Aliases: mulCAND
### Keywords: MulCom

### ** Examples

data(benchVign)
mulcom_perm <- mulPerm(Affy, Affy$Groups, 10,2)
mulcom_cand <- mulCAND(Affy, mulcom_perm, 0.2, 2)



cleanEx()
nameEx("mulCalc")
### * mulCalc

flush(stderr()); flush(stdout())

### Name: mulCalc
### Title: MulCom Calculation
### Aliases: mulCalc mulCalc
### Keywords: MulCom

### ** Examples

data(benchVign)
mulcom_scores <- mulScores(Affy, Affy$Groups)
mulcom_calc <- mulCalc(mulcom_scores, 0.2, 2)



cleanEx()
nameEx("mulDELTA")
### * mulDELTA

flush(stderr()); flush(stdout())

### Name: mulDELTA
### Title: MulCom Delta
### Aliases: mulDELTA
### Keywords: MulCom

### ** Examples

data(benchVign)
mulcom_delta <- mulDELTA(exprs(Affy[1,]),Affy$Groups)




cleanEx()
nameEx("mulDiff")
### * mulDiff

flush(stderr()); flush(stdout())

### Name: mulDiff
### Title: MulCom Test Differential analysis
### Aliases: mulDiff
### Keywords: MulCom

### ** Examples

data(benchVign)
mulcom_perm <- mulPerm(Affy, Affy$Groups, 10, 7)
mulcom_diff <- mulDiff(Affy, mulcom_perm, 0.2, 2)



cleanEx()
nameEx("mulFSG")
### * mulFSG

flush(stderr()); flush(stdout())

### Name: mulFSG
### Title: MulCom False Significant Genes
### Aliases: mulFSG
### Keywords: MulCom

### ** Examples

data(benchVign)
mulcom_perm <- mulPerm(Affy, Affy$Groups, 10, 7)
mulcom_fsg <- mulFSG(mulcom_perm, 0.2, 2)



cleanEx()
nameEx("mulOpt")
### * mulOpt

flush(stderr()); flush(stdout())

### Name: mulOpt
### Title: MulCom optimization
### Aliases: mulOpt
### Keywords: MulCom

### ** Examples

data(benchVign)
mulcom_perm <- mulPerm(Affy, Affy$Groups, 10, 7)
mulcom_opt <- mulOpt(mulcom_perm, seq(0.1, 0.5, 0.1), seq(1, 3, 0.1))



cleanEx()
nameEx("mulOptPars")
### * mulOptPars

flush(stderr()); flush(stdout())

### Name: mulOptPars
### Title: MulCom Parameter Optimization
### Aliases: mulOptPars
### Keywords: MulCom

### ** Examples

data(benchVign)
mulcom_perm <- mulPerm(Affy, Affy$Groups, 10, 7)
#mulcom_opt <- mulOpt(mulcom_perm, seq(0.1, 0.5, 0.1), seq(1, 3, 0.1))
#optThs <- mulOptPars(mulcom_opt, 1, 0.05)



cleanEx()
nameEx("mulOptPlot")
### * mulOptPlot

flush(stderr()); flush(stdout())

### Name: mulOptPlot
### Title: MulCom optimization Plot
### Aliases: mulOptPlot mulOptPlot
### Keywords: MulCom

### ** Examples

   data(benchVign)
   mulcom_perm <- mulPerm(Affy, Affy$Groups, 10,2)
   mulcom_opt <- mulOpt(mulcom_perm, vm=seq(0.1, 0.5, 0.1), vt=seq(1, 3,1))
   mulOptPlot(mulcom_opt, 1, 0.05)



cleanEx()
nameEx("mulParOpt")
### * mulParOpt

flush(stderr()); flush(stdout())

### Name: mulParOpt
### Title: MulCom Parameters Optimization
### Aliases: mulParOpt
### Keywords: MulCom

### ** Examples

   data(benchVign)
   mulcom_perm <- mulPerm(Affy, Affy$Groups, 10,2)
   mulcom_opt <- mulOpt(mulcom_perm, vm=seq(0.1, 0.5, 0.1), vt=seq(1, 3,1))
   mulParOpt(mulcom_perm, mulcom_opt, 1, 0.05)



cleanEx()
nameEx("mulPerm")
### * mulPerm

flush(stderr()); flush(stdout())

### Name: mulPerm
### Title: MulCom Permutation
### Aliases: mulPerm
### Keywords: MulCom

### ** Examples

data(benchVign)
mulcom_perm <- mulPerm(Affy, Affy$Groups, 10,2)



cleanEx()
nameEx("mulScores")
### * mulScores

flush(stderr()); flush(stdout())

### Name: mulScores
### Title: MulCom Score Calculation
### Aliases: mulScores
### Keywords: MulCom

### ** Examples

data(benchVign)
mulcom_scores <- mulScores(Affy, Affy$Groups)



### * <FOOTER>
###
cat("Time elapsed: ", proc.time() - get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
