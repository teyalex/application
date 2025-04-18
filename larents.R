# setup
  
  library(tidyverse)

  rents <- read.csv("medianrents.csv") %>%  # data from la.myneighborhooddata.org/2021/06/rent-price
    select(year, med_gross_rent_adj) %>%
    group_by(year) %>%
    summarize(median = median(med_gross_rent_adj))
  
# computing difference between 2017 and 2011
  
  change <- rents %>%
    filter(year %in% c(2011, 2017)) %>% # for the years 2011 and 2017…
    arrange(year) %>%                   # …order the rows by year…
    pull(median) %>%                    # …extract the values for the medians rents…
    { (.[2] - .[1]) / .[1] * 100 }      # …and plug the values into the % change formula
  
  print(change) # about 4.29%