#	Expression analysis of Danio rerio semaphorin6a and plexinA2 morpholino-injected embryos

#Investigation of whole genome gene expression level changes in Danio rerio semaphorin6A and plexinA2 morphant animals, compared to the wild-type strain.

#This script's purpose is to provide an example dataset for students interested in working with genetic expression data, provided by Dr. Ebert of UVM's Biology department. 

#Accessing this dataset requires installation of the package BiocManager first, then installation of "GEOquery".

library(BiocManager) #Install this first to manage and install requisite packages from Bioconductor
BiocManager::install("GEOquery") #Install GEOquery package
library(GEOquery) #Load in GEOquery package 

#Accessing NCBI datasets only requires knowing the accession number, in this case "GSE86246". 
gse<-getGEO("GSE86246", GSEMatrix = TRUE )


show(gse) #Expression sets are simply collections of related experiments organized into a large list. We can access them with the subsequent functions: "pData", "fdata", "exprs"

#Accessing sample information, characteristics, etc.
x<-pData(gse[[1]]) 
#Subset the dataset for just 200 rows
x<-pData(phenoData(gse[[1]]))[1:5, ]

#Accessing genetic annotation and ID
y<-fData(gse[[1]]) 
#Subset the dataset for just 200 rows
y<-pData(featureData(gse[[1]]))[1:200, c(1:2)]


#Accessing genetic expression level data
z<-exprs(gse[[1]]) 
#Subset the dataset for just 200 rows
z<-exprs(gse[[1]])[1:200,]
