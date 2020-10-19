# Generate data
if (FALSE) {
  
  # These names and years are taken from Wikipedia: https://en.wikipedia.org/wiki/Strauss–Howe_generational_theory 
  gen_df <- data.frame(name  = rev(c("Aurthurian", "Humanist",
                                "Reformation", "Reprisal", "Elizabethan", "Parliamentary",
                                "Puritan", "Cavalier", "Glorious", "Enlightenment",
                                "Awakening", "Liberty", "Republican", "Compromise",
                                "Transcendental", "Gilded", "Progressive",
                                "Missionary", "Lost", "G.I.", "Silent",
                                "Boomer", "Gen X", "Millennial", "Gen Z")),
                      start = rev(c(1435,1459,
                                1497,1517,1542,1569,
                                1594,1621,1649,1675,
                                1704,1727,1746,1773,
                                1794,1822,1844,
                                1865,1886,1908,1929,
                                1946,1964,1984,2008)))
  gen_df$end <- c(2030, gen_df$start[-length(gen_df$start)]-1)
  gen_df <- gen_df[order(-gen_df$start),]
  print(gen_df)
  
  usethis::use_data(gen_df, overwrite = TRUE)
}