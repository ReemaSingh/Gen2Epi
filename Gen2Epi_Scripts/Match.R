library(methods)
library(dplyr)
Ngstar <- read.table(file="NgStarRes.txt",sep="\t",header=F)  ####### Reading output from NG-STAR search
ngprofile <- read.table(file="ngstar_profiles.txt",sep="\t",header=T) ### Reading NG-STAR profile used at https://ngstar.canada.ca
ngstarmetadata <- read.table(file="ngstar_profile_metadata.txt",sep="\t",header=T) ### Reading NG-STAR profile metadata used at https://ngstar.canada.ca

colnames(Ngstar) <- c("Samples","penA","mtrR","porB","ponA","gyrA","parC","23S") 
colnames(ngprofile)<- gsub(x = colnames(ngprofile),pattern = "X23S",replacement = "23S")
com <- inner_join(Ngstar,ngprofile)
com1 <- ngstarmetadata[which(ngstarmetadata$NG.STAR.Type %in% com$st),]
com11 <- com1[,1:2]
colnames(com11) <- c("st","AMR_Markers")
final <- merge(com,com11,by="st")
write.table(final,file="NgStarSearchResults-WithST.txt",sep="\t",col.names=TRUE,row.names=FALSE,quote=F)
