library(methods)
library(dplyr)
Ngstar <- read.table(file="NgStarRes.txt",sep="\t",header=F) 
colnames(Ngstar) <- c("Samples","penA","mtrR","porB","ponA","gyrA","parC","TTS")

##### NgSTAR metadata file for each gene
penA <- read.table(file="penA_metadata.txt",sep="\t",header=T)
mtrR <- read.table(file="mtrR_metadata.txt",sep="\t",header=T)
porB <- read.table(file="porB_metadata.txt",sep="\t",header=T)
ponA <- read.table(file="ponA_metadata.txt",sep="\t",header=T)
gyrA <- read.table(file="gyrA_metadata.txt",sep="\t",header=T)
parC <- read.table(file="parC_metadata.txt",sep="\t",header=T)
S_23 <- read.table(file="23S_metadata.txt",sep="\t",header=T)

#### Extract the allele type and AMR marker information from large files
penA1 <- penA[,1:2]
colnames(penA1) <- c("penA","AMR-Markers")
mtrR1 <- mtrR[,1:2]
colnames(mtrR1) <- c("mtrR","AMR-Markers")
porB1 <- porB[,1:2]
colnames(porB1) <- c("porB","AMR-Markers")
ponA1 <- ponA[,1:2]
colnames(ponA1) <- c("ponA","AMR-Markers")
gyrA1 <- gyrA[,1:2]
colnames(gyrA1) <- c("gyrA","AMR-Markers")
parC1 <- parC[,1:2]
colnames(parC1) <- c("parC","AMR-Markers")
S_231 <- S_23[,1:2]
colnames(S_231) <- c("TTS","AMR-Markers")

### extract the matching entries 
Ngstar1 <- merge(Ngstar,penA1,by="penA",all.x = TRUE)
colnames(Ngstar1)[which(names(Ngstar1) == "AMR-Markers")] <- "penA-Markers"
Ngstar1 <- merge(Ngstar1,mtrR1,by="mtrR",all.x = TRUE)
colnames(Ngstar1)[which(names(Ngstar1) == "AMR-Markers")] <- "mtrR-Markers"
Ngstar1 <- merge(Ngstar1,porB1,by ="porB",all.x = TRUE)
colnames(Ngstar1)[which(names(Ngstar1) == "AMR-Markers")] <-"porB-Markers"
Ngstar1 <- merge(Ngstar1,ponA1,by = "ponA",all.x = TRUE)
colnames(Ngstar1)[which(names(Ngstar1) == "AMR-Markers")] <-"ponA-Markers"
Ngstar1 <- merge(Ngstar1,gyrA1,by = "gyrA",all.x = TRUE)
colnames(Ngstar1)[which(names(Ngstar1) == "AMR-Markers")] <-"gyrA-Markers"
Ngstar1 <- merge(Ngstar1,parC1,by = "parC",all.x = TRUE)
colnames(Ngstar1)[which(names(Ngstar1) == "AMR-Markers")] <-"parC-Markers"
Ngstar1 <- merge(Ngstar1,S_231,by = "TTS",all.x = TRUE)
colnames(Ngstar1)[which(names(Ngstar1) == "AMR-Markers")] <-"TTS-Markers"

#### order the coloumns
final <- Ngstar1[c(8,7,9,6,10,5,11,4,12,3,13,2,14,1,15)]
colnames(final)[which(names(final) == "TTS")] <- "23S"
colnames(final)[which(names(final) == "TTS-Markers")] <-"23S-Markers"
write.table(final,file="NgStarSearchResults-WithoutST.txt",sep="\t",col.names=TRUE,row.names=FALSE,quote=F)


