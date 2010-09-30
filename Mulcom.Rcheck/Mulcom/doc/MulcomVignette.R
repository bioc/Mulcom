###################################################
### chunk number 1: Library
###################################################
#line 86 "/home/cisella/BioC/1.3/99.0/Mulcom/inst/doc/MulcomVignette.Rnw"
library(Mulcom)


###################################################
### chunk number 2: LoadDataSet
###################################################
#line 149 "/home/cisella/BioC/1.3/99.0/Mulcom/inst/doc/MulcomVignette.Rnw"
data("benchVign")


###################################################
### chunk number 3: index
###################################################
#line 157 "/home/cisella/BioC/1.3/99.0/Mulcom/inst/doc/MulcomVignette.Rnw"
Affy$Groups


###################################################
### chunk number 4: MulcomTest2
###################################################
#line 161 "/home/cisella/BioC/1.3/99.0/Mulcom/inst/doc/MulcomVignette.Rnw"
mulcomScore <- mulScores(Affy, Affy$Groups)


###################################################
### chunk number 5: MulcomCalc
###################################################
#line 171 "/home/cisella/BioC/1.3/99.0/Mulcom/inst/doc/MulcomVignette.Rnw"
sg <- mulCalc(mulcomScore, m = 0.3, t = 3)
sg


###################################################
### chunk number 6: MulcomPermutation
###################################################
#line 181 "/home/cisella/BioC/1.3/99.0/Mulcom/inst/doc/MulcomVignette.Rnw"
permutation <- mulPerm(Affy, Affy$Groups, np = 100, seed=7)
#permutationIlmn <- mulPerm(Ilmn, Ilmn$Groups, 5, 7)
#load("permutation.rda")
#load("permIlmn.rda")


###################################################
### chunk number 7: FDR
###################################################
#line 191 "/home/cisella/BioC/1.3/99.0/Mulcom/inst/doc/MulcomVignette.Rnw"
fsg <- mulFSG(permutation, m = 0.3, t = 3)
fsg

fdr <- fsg/sg
fdr


###################################################
### chunk number 8: optimization
###################################################
#line 206 "/home/cisella/BioC/1.3/99.0/Mulcom/inst/doc/MulcomVignette.Rnw"
optimization <- mulOpt(permutation, vm = seq(0,0.5, 0.1), vt = seq(1,3, 0.1))


###################################################
### chunk number 9: ThresholdOptimization
###################################################
#line 221 "/home/cisella/BioC/1.3/99.0/Mulcom/inst/doc/MulcomVignette.Rnw"
h1Opt <- mulParOpt(permutation, optimization, ind = 1, th = 0.05)


###################################################
### chunk number 10: thOpt
###################################################
#line 225 "/home/cisella/BioC/1.3/99.0/Mulcom/inst/doc/MulcomVignette.Rnw"
h1Opt


###################################################
### chunk number 11: ThresholdOptimization
###################################################
#line 230 "/home/cisella/BioC/1.3/99.0/Mulcom/inst/doc/MulcomVignette.Rnw"
#line 221 "/home/cisella/BioC/1.3/99.0/Mulcom/inst/doc/MulcomVignette.Rnw#from line#230#"
h1Opt <- mulParOpt(permutation, optimization, ind = 1, th = 0.05)
#line 231 "/home/cisella/BioC/1.3/99.0/Mulcom/inst/doc/MulcomVignette.Rnw"


###################################################
### chunk number 12: MulComGenes
###################################################
#line 244 "/home/cisella/BioC/1.3/99.0/Mulcom/inst/doc/MulcomVignette.Rnw"
## 1h
h1Opt <- mulParOpt(permutation, optimization, ind = 1, th = 0.05)
affyMulc1Probes <- mulDiff(Affy, permutation, m = h1Opt[2], t = h1Opt[1], ind = 1)


###################################################
### chunk number 13: MulComGenes
###################################################
#line 251 "/home/cisella/BioC/1.3/99.0/Mulcom/inst/doc/MulcomVignette.Rnw"
## 6h
h6Opt <- mulParOpt(permutation,optimization, ind = 2, th = 0.05)
affyMulc6Probes <- mulDiff(Affy, permutation, h6Opt[2], h6Opt[1], 2)


###################################################
### chunk number 14: MulComGenes1
###################################################
#line 256 "/home/cisella/BioC/1.3/99.0/Mulcom/inst/doc/MulcomVignette.Rnw"
## 24h
h24Opt <- mulParOpt(permutation,optimization, ind = 3, th = 0.1)
affyMulc24Probes <- mulDiff(Affy, permutation, h24Opt[2], h24Opt[1], 3)


###################################################
### chunk number 15: MulComGenes2
###################################################
#line 261 "/home/cisella/BioC/1.3/99.0/Mulcom/inst/doc/MulcomVignette.Rnw"
## B4
b4Opt <- mulParOpt(permutation,optimization, ind = 4, th = 0.05)
affyMulcB4Probes <- mulDiff(Affy, permutation, b4Opt[2], b4Opt[1], 4)


###################################################
### chunk number 16: MulComGenes3
###################################################
#line 266 "/home/cisella/BioC/1.3/99.0/Mulcom/inst/doc/MulcomVignette.Rnw"
mulcomGeneList <- unique(c(affyMulc1Probes, affyMulc6Probes, affyMulcB4Probes))


###################################################
### chunk number 17: permutation and optimization illumina
###################################################
#line 270 "/home/cisella/BioC/1.3/99.0/Mulcom/inst/doc/MulcomVignette.Rnw"
#permutationIlmn <- mulPerm(Ilmn, Ilmn$Groups, np = 100, seed = 7)
#optimizationIlmn <- mulOpt(permutationIlmn, vm = seq(0.1,0.5, 0.1), vt = seq(1,3, 0.1))


###################################################
### chunk number 18: IlmnMulcomGene
###################################################
#line 274 "/home/cisella/BioC/1.3/99.0/Mulcom/inst/doc/MulcomVignette.Rnw"
# ,echo=F, results=hide
## 1h
#h1OptIlmn <- mulParOpt(permutationIlmn,optimizationIlmn,1,0.05)
#IlmnMulc1ProbesIlmn <- mulDiff(Ilmn, permutationIlmn, h1OptIlmn[2], h1OptIlmn[1], 1)
## 6h
#h6OptIlmn <- mulParOpt(permutationIlmn,optimizationIlmn,2,0.05)
#IlmnMulc6ProbesIlmn <- mulDiff(Ilmn, permutationIlmn, h6OptIlmn[2], h6OptIlmn[1], 2)
## 24h
#h24OptIlmn <- mulParOpt(permutationIlmn,optimizationIlmn,3,0.05)
#IlmnMulc24ProbesIlmn <- mulDiff(Ilmn, permutationIlmn, h24OptIlmn[2], h24OptIlmn[1], 2)
# B4
#b4OptIlmn <- mulParOpt(permutationIlmn,optimizationIlmn,4,0.05)
#IlmnMulcB4ProbesIlmn <- mulDiff(Ilmn, permutationIlmn, b4OptIlmn[2], b4OptIlmn[1], 4)
#Ilmnmulcom <- Ilmn[which(match(featureNames(Ilmn), unique(c(IlmnMulc24ProbesIlmn, IlmnMulc1ProbesIlmn, IlmnMulc6ProbesIlmn, IlmnMulcB4ProbesIlmn)), nomatch = 0)>0),]
#mulcomGeneListIlmn <- unique(c(IlmnMulc24ProbesIlmn, IlmnMulc1ProbesIlmn, IlmnMulc6ProbesIlmn, IlmnMulcB4ProbesIlmn))


###################################################
### chunk number 19: Intersetction
###################################################
#line 298 "/home/cisella/BioC/1.3/99.0/Mulcom/inst/doc/MulcomVignette.Rnw"
data("others")
mulAffy <- rep(0, length(AffyIlmn$Probe.x))
mulAffy[which(match(AffyIlmn$Probe.x, mulcomGeneList, nomatch=0)>0)] <-1
mulIlmn <- rep(0, length(AffyIlmn$Probe.x))
mulIlmn[which(match(AffyIlmn$Probe.y, mulcomGeneListIlmn, nomatch=0)>0)] <-1
mulConc <- mulAffy * mulIlmn
mulTot <- length(which(mulAffy + mulIlmn >0))
sum(mulConc)/mulTot


###################################################
### chunk number 20: 
###################################################
#line 336 "/home/cisella/BioC/1.3/99.0/Mulcom/inst/doc/MulcomVignette.Rnw"
mulIlmnSymbols <- unique(AffyIlmn[which(match(AffyIlmn$Probe.y, mulcomGeneListIlmn, nomatch = 0)>0),]$Symbol)
mulAffySymbols <- unique(AffyIlmn[which(match(AffyIlmn$Probe.x, mulcomGeneList, nomatch = 0)>0),]$Symbol)

mulIntSym <- length(intersect(mulIlmnSymbols, mulAffySymbols))
mulTotSym <- length(unique(c(mulIlmnSymbols, mulAffySymbols)))

samIntSym <- length(intersect(samIlmnSymbols, samAffySymbols))
samTotSym <- length(unique(c(samIlmnSymbols, samAffySymbols)))

limIntSym <- length(intersect(limmaIlmnSymbols, limmaAffySymbols))
limTotSym <- length(unique(c(limmaIlmnSymbols, limmaAffySymbols)))


###################################################
### chunk number 21: 
###################################################
#line 349 "/home/cisella/BioC/1.3/99.0/Mulcom/inst/doc/MulcomVignette.Rnw"
mulIntSym/mulTotSym
samIntSym/samTotSym
limIntSym/limTotSym


