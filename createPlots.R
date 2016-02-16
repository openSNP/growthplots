library(ggplot2)
library(ggthemes)
library(reshape2)

# get base directory and file handles

args = commandArgs(trailingOnly=TRUE)
base_dir = args[1]

genotype_file = paste(base_dir,"number_genotypes.csv", sep = "/")
user_file = paste(base_dir,"number_users.csv", sep = "/")
phenotype_file = paste(base_dir,"number_phenotypes.csv", sep = "/")
user_phenotype_file = paste(base_dir,"number_user_phenotypes.csv", sep = "/")

# read all files in & fix date format
genotype <- read.csv(file=genotype_file,sep="\t",head=F)
genotype$date <- as.POSIXct(as.character(genotype$V2),format="%d.%m.%Y %H:%M")
user <- read.csv(file=user_file,sep="\t",head=F)
user$date <- as.POSIXct(as.character(user$V2),format="%d.%m.%Y %H:%M")
phenotype <- read.csv(file=phenotype_file,sep="\t",head=F)
phenotype$date <- as.POSIXct(as.character(phenotype$V2),format="%d.%m.%Y %H:%M")
user_phenotype <- read.csv(file=user_phenotype_file,sep="\t",head=F)
user_phenotype$date <- as.POSIXct(as.character(user_phenotype$V2),format="%d.%m.%Y %H:%M")

# do single plots for each
# genotype
ggplot(genotype,aes(date,V1)) +
  geom_point()  +
  geom_smooth() +
  theme_light() +
  scale_x_datetime("Date") +
  scale_y_continuous("# of Genotypes")
ggsave(paste(base_dir,"genotypes.png",sep="/"),width=4, height=3, dpi=100)

# users
ggplot(user,aes(date,V1)) +
  geom_point()  +
  geom_smooth() +
  theme_light() +
  scale_x_datetime("Date") +
  scale_y_continuous("# of Users")
ggsave(paste(base_dir,"users.png",sep="/"),width=4, height=3, dpi=100)

# users
ggplot(phenotype,aes(date,V1)) +
  geom_point()  +
  geom_smooth() +
  theme_light() +
  scale_x_datetime("Date") +
  scale_y_continuous("# of Phenotypes")
ggsave(paste(base_dir,"phenotypes.png",sep="/"),width=4, height=3, dpi=100)

# user phenotypes
ggplot(user_phenotype,aes(date,V1)) +
  geom_point()  +
  geom_smooth() +
  theme_light() +
  scale_x_datetime("Date") +
  scale_y_continuous("# of Phenotype Answers")
ggsave(paste(base_dir,"user_phenotypes.png",sep="/"),width=4, height=3, dpi=100)

# now let's do merged graphs of user & genotypes and phenotype/user phenotypes
# users & genotypes

# nicer column labels
user$users <- user$V1
genotype$genotypes <- genotype$V1

# merge DFs and drop useless columns
geno_user_merge <- merge(user,genotype,by="date")
geno_user_merge$V1.x <- NULL
geno_user_merge$V1.y <- NULL
geno_user_merge$V2.y <- NULL
geno_user_merge$V2.x <- NULL

# convert from wide to long
geno_user_merge_long <- melt(geno_user_merge, id.vars="date",variable.name="category")

# plot graphs
ggplot(geno_user_merge_long,aes(date,value,color=category)) +
  geom_smooth() +
  scale_color_discrete("Category") +
  scale_x_datetime("Date") +
  scale_y_continuous("total #") +
  theme_minimal()
ggsave(paste(base_dir,"geno_plus_phenotypes.png",sep="/"),width=4, height=3, dpi=100)

# now we do phenotypes & user phenotypes
# nicer column labels
phenotype$phenotypes <- phenotype$V1
user_phenotype$phenotype_answers <- user_phenotype$V1

# merge DFs and drop useless columns
pheno_userpheno_merge <- merge(user_phenotype,phenotype,by="date")
pheno_userpheno_merge$V1.x <- NULL
pheno_userpheno_merge$V1.y <- NULL
pheno_userpheno_merge$V2.y <- NULL
pheno_userpheno_merge$V2.x <- NULL

# convert from wide to long
pheno_userpheno_merge_long <- melt(pheno_userpheno_merge, id.vars="date",variable.name="category")

# plot graphs
ggplot(pheno_userpheno_merge_long,aes(date,value,color=category)) +
  geom_smooth() +
  scale_color_discrete("Category") +
  scale_x_datetime("Date") +
  scale_y_continuous("total #") +
  theme_minimal()
ggsave(paste(base_dir,"pheno_plus_userpheno.png",sep="/"),width=4, height=3, dpi=100)
