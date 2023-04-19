install.packages("tidyverse")
library(tidyverse)
microbiome.fungi <- read.csv("Microbiome.csv")

###Select

microbiome.fungi2 <- select(microbiome.fungi, OTU,
                            SampleID,
                            Abundance,
                            Crop,
                            Compartment,
                            DateSampled,
                            GrowthStage,
                            Treatment,
                            Rep,
                            Fungicide,
                            Kingdom:Taxonomy)

filter(microbiome.fungi2, Class == "Sordariomycetes")

mutate(microbiome.fungi2, Percent = Abundance*100)

###Piping
microbiome.fungi %>%
  select( OTU,
          SampleID,
          Abundance,
          Crop,
          Compartment,
          DateSampled,
          GrowthStage,
          Treatment,
          Rep,
          Fungicide,
          Kingdom:Taxonomy) %>%
  filter(Class == "Sordariomycetes") %>%
  mutate(Percent = Abundance*100)

### Summarize
microbiome.fungi %>%
  select( OTU,
          SampleID,
          Abundance,
          Crop,
          Compartment,
          DateSampled,
          GrowthStage,
          Treatment,
          Rep,
          Fungicide,
          Kingdom:Taxonomy) %>%
  filter(Class == "Sordariomycetes") %>%
  mutate(Percent = Abundance*100) %>%
  summarise(Mean = mean(Percent),
            n = n(),
            sd.dev = sd(Percent)) %>%
  mutate(std.err = sd.dev/sqrt(n))

microbiome.fungi %>%
  select( OTU,
          SampleID,
          Abundance,
          Crop,
          Compartment,
          DateSampled,
          GrowthStage,
          Treatment,
          Rep,
          Fungicide,
          Kingdom:Taxonomy) %>%
  filter(Class == "Sordariomycetes") %>%
  mutate(Percent = Abundance*100) %>%
  group_by(Order) %>%
  summarise(Mean = mean(Percent),
            n = n(),
            sd.dev = sd(Percent)) %>%
  mutate(std.err = sd.dev/sqrt(n)) %>%
  arrange(-Mean) %>%
  ggplot(aes(x = Mean, y = Order)) +
  geom_bar(stat = "identity")

microbiome.fungi %>%
  select( OTU,
          SampleID,
          Abundance,
          Crop,
          Compartment,
          DateSampled,
          GrowthStage,
          Treatment,
          Rep,
          Fungicide,
          Kingdom:Taxonomy) %>%
  filter(Class == "Sordariomycetes") %>%
  mutate(Percent = Abundance*100) %>%
  group_by(Order) %>%
  summarise(Mean = mean(Percent),
            n = n(),
            sd.dev = sd(Percent)) %>%
  mutate(std.err = sd.dev/sqrt(n)) %>%
  replace_na(list(Order = "unidentified")) %>%
  mutate(Order2 = fct_reorder(Order, desc(-Mean))) %>%
  ggplot(aes(x = Mean, y = Order2)) +
  geom_bar(stat = "identity") 

## Joining

taxonomy <- microbiome.fungi2 %>%
  select(OTU, Kingdom:Taxonomy) %>%
  sample_n(size = 100)

metadata <- microbiome.fungi2   %>%
  select(OTU:Fungicide) %>%
  sample_n(size = 100)

left_join(taxonomy, metadata, by = "OTU") #Column header in both data sets
#Can combine with by = c("____" = "____")

inner_join(taxonomy, metadata, by = "OTU") #Only fully matching data

full_join(taxonomy, metadata, by = "OTU") #All data available

## Pivoting

pivot_longer()
pivot_wider()

microbiome.fungi %>%
  select( OTU,
          SampleID,
          Abundance,
          Crop,
          Compartment,
          DateSampled,
          GrowthStage,
          Treatment,
          Rep,
          Fungicide,
          Kingdom:Taxonomy) %>%
  filter(Class == "Sordariomycetes") %>%
  mutate(Percent = Abundance*100) %>%
  group_by(Order, Crop, Compartment, Fungicide) %>%
  summarise(Mean = mean(Percent))

microbiome.fungi3 <-microbiome.fungi %>%
  select( OTU,
          SampleID,
          Abundance,
          Crop,
          Compartment,
          DateSampled,
          GrowthStage,
          Treatment,
          Rep,
          Fungicide,
          Kingdom:Taxonomy)
          
microbiome.fungi3 %>%
  filter(Class == "Sordariomycetes") %>%
  mutate(Percent = Abundance*100) %>%
  group_by(Order, Crop, Compartment, Fungicide) %>%
  summarise(Mean = mean(Percent)) %>%
  pivot_wider(names_from = Fungicide,values_from = Mean) %>%
  mutate(diff = C - F ) %>%
  ggplot(aes(x = Order, y = diff))+
  geom_point()+
  facet_wrap(~Crop*Compartment) +
  coord_flip()
