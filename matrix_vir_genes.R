# Install required packages (if needed)

#install.packages("ggplot2")  
#install.packages("dplyr")    
#install.packages("reshape2")  
#install.packages("RColorBrewer")

# Load libraries
library(ggplot2)  
library(dplyr)    
library(reshape2)
library(RColorBrewer)

# Read CSV file
data_df <- read.csv("spreadsheet.csv", row.names = 1, check.names = FALSE)
molten <- melt(as.matrix(data_df))
colnames(molten) <- c("Gene", "Lineage", "Presence")

# Gene → class dictionary
gene_classes <- list(
  "Adherence" = c("cbpA", "spaA", "spaB", "spaC", "srtA", "spaD", "spaE", "spaF", "srtB", "srtC",
                  "spaG", "spaH", "spaI", "srtD", "srtE", "sapA", "sapD", "sapE"),
  "Iron uptake" = c("fagA", "fagB", "fagC", "fagD", "hmuT", "hmuU", "hmuV", "ciuA", "ciuB", "ciuC", 
                    "ciuD", "ciuE", "irp6A", "irp6B", "irp6C", "Exochelin"),
  "Regulation" = c("dtxR", "senX3", "sigA/rpoV", "sigD"),
  "Toxin" = c("tox", "pld"),
  "Amino acid and purine metabolism" = c("lysA"),
  "Cell surface components" = c("sugC"),
  "Copper uptake" = c("ctpV"),
  "Phagosome arresting" = c("ptpA"),
  "Protease" = c("mpa", "pafA"),
  "Secretion system" = c("secA2")
)

# Colors per class
class_colors <- c(
  "Adherence" = "#F08080",
  "Iron uptake" = "#66CDAA",
  "Regulation" = "lightblue",
  "Toxin" = "#DC143C",
  "Amino acid and purine metabolism" = "orange",
  "Cell surface components" = "#9370DB",
  "Copper uptake" = "lightgreen",
  "Phagosome arresting" = "gold",
  "Protease" = "pink",
  "Secretion system" = "#4682B4",
  "Other" = "grey"
)

# Function to assign gene class
get_class <- function(gene) {
  for (class in names(gene_classes)) {
    if (gene %in% gene_classes[[class]]) {
      return(class)
    }
  }
  return("Other")
}

# Add class and color columns
molten$Class <- sapply(molten$Gene, get_class)
molten$Color <- ifelse(molten$Presence == 1, class_colors[molten$Class], "#FFFFFF")  # branco se ausente

# Plot with functional class colors + title
ggplot(molten, aes(x = Lineage, y = Gene)) +
  geom_tile(aes(fill = Color), color = "gray") +
  scale_fill_identity(
    guide = "legend", 
    labels = names(class_colors), 
    breaks = class_colors,
    name = "Virulence Class"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 90, hjust = 1, vjust = 1),
    axis.text.y = element_text(face = "italic"),
    legend.position = "right",
    plot.title = element_text(hjust = 0.5, size = 10, face = "bold")  # center and style title
  ) +
  labs(
    title = "Distribution of Virulence-Associated Genes",
    x = expression("optional_text"*italic("species name")),
    y = "Virulence factors-associated genes"
  )