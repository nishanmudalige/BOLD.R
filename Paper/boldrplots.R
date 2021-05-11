library(dplyr)
library(ggplot2)
library(tidyr)
library(scales)  # for percentage scales

library(BOLD.R)

################
### Bar Plot ###
################

df.bar = get.public(container="GRAMB")

# barplot(table(df.bar$taxon))

plotdata = data.frame(table(df.bar$taxon))
names(plotdata) = c("taxon", "frequency")

ggplot(data=plotdata, aes(x=taxon, y=frequency/sum(frequency), fill=taxon)) +
  geom_bar(stat="identity") +
  theme(legend.position="bottom", legend.title = element_blank()) +
  theme(axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        #axis.title.x=element_blank(),
        ) +
  xlab("Taxon") + 
  ylab("% Abundance") +
  ggtitle("Percentage abundance of each taxon in sample GRAMB") +
  theme(plot.title = element_text(hjust = 0.5))   # Required for centering of title





#################
### Pie Chart ###
#################


df.pie = get.public(container="CBMB")

plotdata = data.frame(table(df.pie$taxon))
names(plotdata) = c("taxon", "frequency")

ggplot(data=plotdata, aes(x="", y=frequency, fill=taxon)) +
  geom_bar(width = 1,  stat="identity") +
  coord_polar("y", start=0) +
  theme(legend.position="right", legend.title = element_blank()) +
  theme(axis.title.x=element_blank()) +
  theme(axis.title.y=element_blank()) +
  # + geom_text(aes(y = frequency/3 + c(0, cumsum(frequency)[-length(frequency)]), 
  #               label = percent(frequency/100)), size=5)
  ggtitle("Frequency of each taxon in sample CBMB") +
  theme(plot.title = element_text(hjust = 0.5))   # Required for centering of title



################
### Heat Map ###
################

library(stringdist)
library(gplots)

# example.df.heat = get.public(container="BNSC")

colfunc<-colorRampPalette(c("red","yellow","springgreen","royalblue"))

example.df.heat = get.public(container="BNABS")

example.df.heat <- example.df.heat[!duplicated(example.df.heat$taxon), ] 
rownames(example.df.heat) <- example.df.heat$taxon

example.df.heat2 <- example.df.heat[,"COI-5P_nucraw"]
example.df.heat2[is.na(example.df.heat2)] <- ""

dm <- stringdistmatrix(example.df.heat2, example.df.heat2, method="lv")
rownames(dm) <- example.df.heat$taxon

# heatmap(dm, col = colfunc(length(unique(example.df.heat$taxon))) )

heatmap.2(dm, dendrogram ='row', col=colfunc(30), trace='none', 
          main = "Heatmap of Project BNABS")


###################################

###########
### Map ###
###########

library("sf")
library("mapview")
# CERNA
example.map = get.public(container="CSCR")

example.map$lat = as.numeric(example.map$lat)
example.map$long = as.numeric(example.map$long)

example.map.df = example.map[,c("lat","long")]
example.map.df = example.map.df[complete.cases(example.map.df),]

map_locations = st_as_sf(example.map.df, coords = c("long", "lat"), crs = 4326)
mapview(map_locations)


##################
### Dendrogram ###
##################

library(ggdendro)
library(dendextend)

example.df.dend <- get.public(container="ASRO")
example.df.dend2 <- example.df.dend[!duplicated(example.df.dend$taxon), ]
example.df.dend2 = example.df.dend2[!is.na(example.df.dend2$"COI-5P_nucraw"),]
rownames(example.df.dend2) <- example.df.dend2$taxon
dmat = stringdistmatrix(example.df.dend2[,"COI-5P_nucraw"], 
                        example.df.dend2[,"COI-5P_nucraw"], method="lv")
rownames(dmat) = rownames(example.df.dend2)
colnames(dmat) = rownames(dmat)

dmat = as.dist(dmat)
hc = hclust(dmat, "ave")
# hc <- hclust(dist(USArrests[1:5,]), "ave")
dend <- as.dendrogram(hc)

library(dendextend)
# par(mfrow = c(1,2), mar = c(5,2,1,0))
# dend <- dend %>%
# color_branches(k = 3) %>%
# set("branches_lwd", c(2,1,2)) %>%
# set("branches_lty", c(1,2,1))

plot(dend)

dend <- color_labels(dend, k = 15)
# The same as:
# labels_colors(dend)  <- get_leaves_branches_col(dend)
# par(mar=c(3,1,1,15))
plot(dend, horiz = TRUE, main = "\nDendrogram of Project ASRO", axes = FALSE)

# plot(as.phylo(hc), cex = 0.6, label.offset = 0.5, 
#      tip.color=c("red","blue", "green", "purple", "orange") )



########################################

example.df.dend <- get.public(container="ASMIN")

example.df.dend2 <- example.df.dend[!duplicated(example.df.dend$taxon), ]
example.df.dend2 = example.df.dend2[!is.na(example.df.dend2$"COI-5P_nucraw"),]
rownames(example.df.dend2) <- example.df.dend2$taxon
dmat = stringdistmatrix(example.df.dend2[,"COI-5P_nucraw"], 
                 example.df.dend2[,"COI-5P_nucraw"], method="lv")
rownames(dmat) = rownames(example.df.dend2)
colnames(dmat) = rownames(dmat)

dmat = as.dist(dmat)
hc = hclust(dmat, "ave")

# par(mar=c(3,1,1,15))
# plot(as.dendrogram(hc), horiz=T)
# ggdendrogram(hc, rotate=TRUE, theme_dendro=FALSE) # + coord_flip() +scale_y_reverse()


dendr    <- dendro_data(hc, type="rectangle") # convert for ggplot
clust    <- cutree(hc,k=7)                    # find 2 clusters
clust.df <- data.frame(label=names(clust), cluster=factor(clust))
# dendr[["labels"]] has the labels, merge with clust.df based on label column
dendr[["labels"]] <- merge(dendr[["labels"]],clust.df, by="label")


# plot the dendrogram; note use of color=cluster in geom_text(...)
# par(mar=c(3,1,1,15))
ggplot() + 
  geom_segment(data=segment(dendr), aes(x=x, y=y, xend=xend, yend=yend)) + 
  geom_text(data=label(dendr), aes(x, y, label=label, hjust=0, color=cluster), 
            size=4.3) +
  coord_flip() + scale_y_reverse(expand=c(0.3, 100)) + 
  theme(axis.line.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.text.y=element_blank(),
        axis.title.y=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.x=element_blank(),
        # panel.background=element_rect(fill="white"),
        panel.grid=element_blank()) +
  theme(legend.position="none") +
  theme(plot.margin = unit(c(1,1,1,-3), "cm")) +
  ggtitle("Dendrogram of sample ????") +
  theme(plot.title = element_text(hjust = 0.6))



#########################
## Sequence Alignement ##
#########################

x.df <- get.public(container="ASHEM")
example.DNAbin <- gen.DNAbin(x.df, alignment="COI-5P_nucraw", labels.headers=c("processid"))

# dna.pastel.h = c("#ED7080", 
#                  "#9FF3C2", 
#                  "#ffeead", 
#                  "#5bc0de", 
#                  "gray", "black")
dna.pastel.h = c("#ffabab", 
                 "#aff8db", 
                 "#fff5ba", 
                 "#6eb5ff", 
                 "gray", "black")

par(mar=c(5.1, 7.1, 4.1, 2.1))
image(example.DNAbin[,100:200], col=dna.pastel.h, grid=TRUE)
# title("Sequence alignments for a subset of records in ASHEM", line = +3.5)

# title("Sequence alignments for a subset of records in ASHEM", line = 8.5)

# rug(seg.sites(example.DNAbin), -0.02, 3, 1)
# 
# # par(mai=c(1.02,0.82,0.82,0.42))
# par(mai=c(0.50,1.70,1.00,1.00))
# image.DNAbin(example.DNAbin[10:18, 1:100], col=dna.pastel.h, grid=TRUE)
