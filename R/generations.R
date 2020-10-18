#' Convert year of birth to generations
#' 
#' This is the main function in this package. It will convert one or more years
#' to the corresponding generation. Generation names and years are taken from 
#' Howe & Strauss' \href{https://en.wikipedia.org/wiki/Strauss–Howe_generational_theory}{generational theory}.
#' 
#' Note that labels are included for years between 1435 and 2030. Anything outside
#' of that range will return \code{NA}.
#' 
#' @param yob a vector of integers. Currently, integers are the only accepted 
#' input, so characters and date types must be converted first.
#' @param full_names logical. If \code{TRUE}, the generation name will typically have
#' the word "generation" at the end (e.g., "Millennial" becomes "Millennial 
#' Generation"). "Gen X" (together with Y and Z) expands to "Generation X". 
#' \code{FALSE} by default.
#' @param years logical. Should the year range be included in the output? Useful
#' for printing, plotting, or otherwise displaying. For example, "Gen X" becomes
#' "Gen X (1964–1983)". \code{FALSE} by default.
#' @param years_sep a string. If \code{years} is \code{TRUE}, what should the 
#' separator between the generation name and opening parenthesis in the year 
#' range be? A single space by default, but it may look better in a visual if 
#' a new line character (backslash + n) is used.
#' @param years_range_sep a string. If \code{years} is \code{TRUE}, what should 
#' go between the start and end years. By default, an en-dash ("–"). For more 
#' print-friendly characters, try a hyphen.
#' @param as_factor logical. Should the vector be returned as a factor? If so, 
#' the levels will be chronological order (oldest generation first). If not, it
#' will be returned as a character vector. \code{TRUE} by default.
#' 
#' @return a vector 
#'
#' @examples
#' # Generate some sample data
#' yobs <- sort(floor(runif(10, 1880, 2020)))
#' 
#' # Convert to the generations
#' generations(yobs)
#' generations(yobs, full_names = TRUE)
#' generations(yobs, full_names = TRUE, years = TRUE)
#' generations(yobs, years = TRUE, years_range_sep = " to ")
#' 
#' @export
generations <- function(yob, full_names = FALSE, 
                        years = FALSE, years_sep = " ", years_range_sep = "–",
                        as_factor = TRUE) {
  
  # https://jennybc.github.io/purrr-tutorial/bk01_base-functions.html#vapply()_vs_map_*()
  gens <- vapply(yob,
                 function(x) .gen_df[x >= .gen_df$start & x <= .gen_df$end,"name"][[1]],
                 character(1))
  
  if (full_names) {
    gens <- full_generation_names(gens)
  }
  
  if (years) {
    gens <- add_years(gens, years_sep, years_range_sep)
  }

  if (as_factor) {
    fct_lvls <- unique(gens[order(yob)])
    gens <- factor(gens, levels = fct_lvls)
  }

  gens
}


#' Get full generation names
#' 
#' For internal use only.
#' @param gens a vector
full_generation_names <- function(gens) {
  # Super clunky base-R version of what case_when could do more elegantly
  
  # First handle all of them besides Gen X/Y/Z
  gens[!grepl("Gen [XYZ]", gens)] <- paste(gens[!grepl("Gen [XYZ]", gens)], "Generation")
  gens[grepl("Gen [XYZ]", gens)] <- gsub("Gen ", "Generation ", gens[grepl("Gen [XYZ]", gens)])
  gens
}

#' Get shortened generation names
#' 
#' For internal use only. Mostly used within \code{add_years()} so that 
#' \code{generations()} words properly when \code{full_names} and \code{years} 
#' are both specified.
#' @param gens a vector
short_generation_names <- function(gens) {
  # Super clunky base-R version of what case_when could do more elegantly
  
  # Handle the Gen X/Y/Z ones first
  gens <- gsub("Generation ", "Gen ", gens)
  # Then just remove all " Generation"
  gens <- gsub(" Generation", "", gens)
  gens
}

#' Add years to generation name
#' 
#' For internal use only.
#' 
#' @param gens a vector
#' @param years_sep a string
#' @param years_range_sep a string
add_years <- function(gens, years_sep, years_range_sep) {
  paste0(gens,
         years_sep,
         "(",
         get_start(short_generation_names(gens)),
         years_range_sep,
         get_end(short_generation_names(gens)),
         ")")
}