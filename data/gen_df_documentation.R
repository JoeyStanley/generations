# Generate data


if(FALSE){
  library(dplyr)
  
  # These names and years are taken from Wikipedia: https://en.wikipedia.org/wiki/Strauss–Howe_generational_theory 
  gen_df <- dplyr::tibble(name  = c("Aurthurian", "Humanist",
                                    "Reformation", "Reprisal", "Elizabethan", "Parliamentary",
                                    "Puritan", "Cavalier", "Glorious", "Enlightenment",
                                    "Awakening", "Liberty", "Republican", "Compromise",
                                    "Transcendental", "Gilded", "Progressive",
                                    "Missionary", "Lost", "G.I.", "Silent",
                                    "Baby Boom", "Gen X", "Millennial", "Gen Z"),
                          start = c(1435,1459,
                                    1497,1517,1542,1569,
                                    1594,1621,1649,1675,
                                    1704,1727,1746,1773,
                                    1794,1822,1844,
                                    1865,1886,1908,1929,
                                    1946,1964,1984,2008)) %>%
    dplyr::mutate(end = c(dplyr::lead(start, default = 2031) - 1)) %>%
    dplyr::arrange(-start) %>%
    dplyr::rowwise() %>%
    dplyr::mutate(range = list(c(start:end))) %>%
    dplyr::ungroup()
  use_data(gen_df)
}