# Presence/Absence Matrix Plot for Virulence Genes
This repository contains an R script to generate a presence/absence matrix heatmap of virulence-associated genes based on results from VFanalyzer (VFDB).  
The output is a publication-ready figure showing the distribution of virulence factors across clinical isolates.

# Overview
The script:

Reads a CSV file (spreadsheet.csv);

Interprets gene presence (1) and absence (0);

Assigns each gene to a functional virulence class;

Generates a heatmap-style plot using ggplot2;

Colors genes based on their functional category;

# Input File Requirements (IMPORTANT!!)

The script requires a CSV file named 'spreadsheet.csv'. Your table must follow the exact structure of the example table attached. 

📁 Key formatting rules:
Rows = Genes
- Each row corresponds to a virulence gene. Gene names must match those defined in the script (e.g., cbpA, spaA, tox, etc.).

Columns = Isolates / Strains
- Each column represents a genome / strain; Column names will appear on the x-axis of the plot.

Values must be binary:
- 1 → gene present; 0 → gene absent

# Functional Classification
Genes are grouped into virulence-related classes and each class is assigned a specific color in the plot.

# Required R Packages
Install the required packages if needed:
- install.packages("ggplot2")
- install.packages("dplyr")
- install.packages("reshape2")
- install.packages("RColorBrewer")
