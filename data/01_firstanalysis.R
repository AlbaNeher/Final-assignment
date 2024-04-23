#load libraries
install.packages("unibeCols", repos = "https://ctu-bern.r-universe.dev")
install.packages("here")
library(tidyverse)
library(lubridate)
library(here)
library(unibeCols)

# Load and read data
Dog_data <- read_csv("data/raw/breed_traits.csv")

# Check data 
head(Dog_data)
# Select interesting traits for this family
Interesting_Traits <- Dog_data |> select("Breed", "Barking Level", "Adaptability Level", "Energy Level")
show(Interesting_Traits)

# Selecting our candidate breeds by filtering variables' levels
Interesting_Traits_Filtered <- subset(Interesting_Traits, 
                                      `Barking Level` <= 2 & 
                                        `Adaptability Level` > 4 & 
                                        `Energy Level` <= 3)
unique(Interesting_Traits_Filtered$Breed)

# Load packages and read data
library(readxl)
MedicalConditions_Breed <- read_excel("data/raw/MedicalConditions_Breed.xlsx")
View(MedicalConditions_Breed)

# Count number of times a breed is anotated in the column
count_FB <- sum(MedicalConditions_Breed$Breed == "French Bulldog")
count_GR <- sum(MedicalConditions_Breed$Breed == "Golden Retriever")
count_P <- sum(MedicalConditions_Breed$Breed == "Pug")
MedicalConditions_table <- data.frame(Value = c("FB", "GR", "P"), Count = c(count_FB, count_GR, count_P))
print(MedicalConditions_table)

# Now we can show this as a plot to show the family
#| label: fig-cases
#| fig-cap: "Number of registered veterinary visits by breed"
#| fig-width: 8
#| fig-height: 4
library(ggplot2)
ggplot(MedicalConditions_table, aes(x = Value, y = Count)) + 
  geom_bar(stat = "identity", fill = unibePastelS()) +
  labs(x = "Breeds", y = "Registered veterinary visits")