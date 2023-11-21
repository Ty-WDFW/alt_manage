library(framrsquared)
library(tidyverse)
fram_db <- connect_fram_db(here::here('data/chinook_pre_season_runs.mdb'))


msf_encounters_report <- fram_db |>
  msf_encounters() %>%
  dplyr::filter(
    .data$fishery_id %in% c(56),
    time_step == 3
    ) %>%
  mutate(across(legal_marked:sublegal_unmarked, \(x) x / (legal_marked + legal_unmarked + sublegal_marked + sublegal_unmarked)))


disconnect_fram_db(fram_db)

msf_encounters_report %>%
  ggplot(aes(factor(run_id), legal_marked, group=factor(fishery_id), color = factor(fishery_id))) +
  geom_line()


write_csv(msf_encounters_report, here::here('data/fram_lm.csv'))

disconnect_fram_db(fram_db)
  