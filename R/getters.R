#' Show generational data
#' 
#' Displays the generation names, start years, and end years.
#' @examples 
#' show_generations()
#' @export
show_generations <- function() {
  .gen_df[order(-.gen_df$start),c("name", "start", "end")]
}

#' Get a generation's start or end year
#' 
#' @param generation a string, exactly matching a generation's name
#' 
#' @examples 
#' get_start("Millennial")
#' get_start(c("Millennial", "Lost"))
#' get_end("Millennial")
#' get_end(c("Millennial", "Lost"))
#' @export
get_start <- function(generation) {
  indices <- match(generation, .gen_df$name)
  .gen_df$start[indices]
}

#' @rdname get_start
#' @export
get_end <- function(generation) {
  indices <- match(generation, .gen_df$name)
  .gen_df$end[indices]
}





#' Get the previous generation
#'
#' Given a generation's name, find what the previous or next generation is.
#' @param gen a string, exactly matching a generation's name
#' @return a string. If the generation is out of range (such as the generation
#' after Gen Z, it returns \code{NA}.)
#' @examples
#' get_prev_gen("Millennial")
#' get_prev_gen("Aurthurian")
#' get_next_gen("Silent")
#' get_next_gen("Gen Z")
#' @export
get_prev_gen <- function(gen) {
  prev_gen_rank <- match(gen, .gen_df$name) + 1
  if (prev_gen_rank > 0 & prev_gen_rank <= length(.gen_df$name)) {
    .gen_df$name[prev_gen_rank]
  } else {
    NA
  }
}


#' @rdname get_prev_gen
#' @export
get_next_gen <- function(gen) {
  next_gen_rank <- match(gen, .gen_df$name) - 1
  if (next_gen_rank > 0 & next_gen_rank <= length(.gen_df$name)) {
    .gen_df$name[next_gen_rank]
  } else {
    NA
  }
}
