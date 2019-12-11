library(tidyverse)
library(janitor)
library(countrycode)
library(rio)


dhs <- read_csv("dhs.csv") %>%
  mutate(iso3c = countrycode(countryname, 'country.name', 'iso3c'),
         iso2c = countrycode(countryname, 'country.name', 'iso2c'),
         region = countrycode(countryname, 'country.name', 'region'),
         continent = countrycode(countryname, 'country.name', 'continent'))

hdi_wide <- read_csv("hdi_df.csv") %>%
  mutate(iso3c = countrycode(country, 'country.name', 'iso3c')) %>%
  gather(year, hdi, `2010`:`2018`) %>%
  mutate(year = paste0('hdi', year)) %>%
  spread(year, hdi) %>%
  right_join(., dhs)
  

hdi <- read_csv("hdi_df.csv") %>%
  mutate(iso3c = countrycode(country, 'country.name', 'iso3c')) %>%
  gather(year, hdi, `2010`:`2018`) %>%
  right_join(., dhs)

export(hdi, "hdi.dta")
export(hdi, "hdi.csv")

export(hdi_wide, "hdi_wide.csv")
export(hdi_wide, "hdi_wide.dta")
