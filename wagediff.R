# setup

  setwd("~/Documents/work/Applications/The Nation internship")

  library(tidyverse)
  
  wagedata <- read.csv("wagedata.csv") %>% # importing data pasted into a .csv from table generated at data.bls.gov/cew
    select(state, avg_weekly_wage) %>%
    filter(!state %in% c("District of Columbia, not unknown", "Puerto Rico", "Virgin Islands")) %>%
    slice(1:50)

# list of right-to-work states
  
  rtw_states_list <- c("Alabama", "Arizona", "Arkansas", "Florida", "Georgia", "Guam", "Idaho", "Indiana", "Iowa",
                       "Kansas", "Kentucky", "Louisiana", "Mississippi", "Nebraska", "Nevada", "North Carolina",
                       "North Dakota", "Oklahoma", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah",
                       "Virginia", "West Virginia", "Wisconsin", "Wyoming")
  
# tables for average weekly wage in right-to-work and non-right-to-work states
  
  wagediff <- wagedata %>%
    mutate(rtw = ifelse(state %in% rtw_states_list, T, F))
  
  rtw_state_wages <- wagediff %>%
    filter(rtw == TRUE)
  
  non_state_wages <- wagediff %>%
    filter(rtw == FALSE)
  
# computing and comparing average wages
  
  non_avg <- mean(non_state_wages$avg_weekly_wage) # mean weekly wage in non-right-to-work states
  
  rtw_avg <- mean(rtw_state_wages$avg_weekly_wage) # mean weekly wage in right-to-work states

  avg_diff <- non_avg - rtw_avg # difference in mean weekly wages
  
  print(avg_diff) # about $275.58 absolute difference
  
  (non_avg - rtw_avg) / non_avg # about 17% difference
