#' Reset underlying generational data
#' 
#' Changes to the underlying dataset can be made with \code{rename_generation}
#' or \code{redefine_generation}. This function undoes all these changes and 
#' reverts the data back to its out-of-the-box names and definitions.
#' 
#' @seealso \code{\link{rename_generation}}, \code{\link{redefine_generation}}
#' 
#' @examples 
#' reset_generations()
#' 
#' @export
reset_generations <- function() {
  .gen_df <<- assign(".gen_df", generations::gen_df, envir = globalenv())
}




#' Rename a generation
#' 
#' Not all people refer to generations the same way. The names I have chosen 
#' come from Howe & Strauss' book, though I have taken some liberty with the 
#' most recent four generations. This family of functions lets you rename
#' a generation to fit your personal tastes.
#' 
#' The main function is \code{rename_generation}. All others are shortcuts for
#' some of the more common changes I expect people to make.
#' 
#' The changes here modify the underlying data and will be reflected in any
#' subsequent reference to the generational data. You can view what the current 
#' dataset is with \code{show_generations}. Any change you make can be reset using 
#' \code{reset_generations}.
#' 
#' @param old_name a string, exactly matching a generation's name
#' @param new_name a string, representing what you want that generation to be 
#' called
#' 
#' @examples 
#' rename_generation("Gen Z", "Zoomer")
#' rename_generation("Boomer", "Baby Boom")
#' show_generations()
#' 
#' use_gen_z()
#' use_zoomer()
#' use_gen_y()
#' use_millennial()
#' use_13th()
#' use_gen_x()
#' use_boomer()
#' use_baby_boom()

#' @export
rename_generation <- function(old_name, new_name) {
  .gen_df[.gen_df$name == old_name,]$name <<- new_name
  message(old_name, " has been renamed ", new_name)
}

#' @rdname rename_generation
#' @export
use_zoomer <- function() {
  rename_generation("Gen Z", "Zoomer")
}

#' @rdname rename_generation
#' @export
use_gen_z <- function() {
  rename_generation("Zoomer", "Gen Z")
}

#' @rdname rename_generation
#' @export
use_gen_y <- function() {
  rename_generation("Millennial", "Gen Y")
}

#' @rdname rename_generation
#' @export
use_millennial <- function() {
  rename_generation("Gen Y", "Millennial")
}

#' @rdname rename_generation
#' @export
use_13th <- function() {
  rename_generation("Gen X", "13th")
}

#' @rdname rename_generation
#' @export
use_gen_x <- function() {
  rename_generation("13th", "Gen X")
}

#' @rdname rename_generation
#' @export
use_baby_boom <- function() {
  rename_generation("Boomer", "Baby Boom")
}

#' @rdname rename_generation
#' @export
use_boomer <- function() {
  rename_generation("Baby Boom", "Boomer")
}



#' Redefine when a generation starts and ends
#' 
#' Not all people agree on when a generation started and ended. This is especially 
#' true with the most recent few generations. The years I have chosen 
#' come from Howe & Strauss' book. This function lets you redefine the start
#' and end years of a generation to fit your personal tastes.
#' 
#' The changes here modify the underlying data and will be reflected in any
#' subsequent reference to the generational data. You can view what the current 
#' dataset is with \code{show_generations}. Any change you make can be reset using 
#' \code{reset_generations}.
#' 
#' @param generation a string, exactly matching a generation's name
#' @param start an integer, representing the year you want \code{generation} to 
#' start at
#' @param end an integer, representing thet year you want \code{generation} to 
#' end at.
#' 
#' @examples 
#' redefine_generation("Millennial", 1980, 1997)
#' show_generations()
#' @export
redefine_generation <- function(generation, start, end) {
  
  # Fix this generation
  .gen_df[.gen_df$name == generation,]$start <<- start
  .gen_df[.gen_df$name == generation,]$end <<- end

  # Fix previous generation
  if (!is.na(get_prev_gen(generation))) {
    .gen_df[.gen_df$name == get_prev_gen(generation),]$end <<- start - 1
  }

  # Fix following generation
  if (!is.na(get_next_gen(generation))) {
    .gen_df[.gen_df$name == get_next_gen(generation),]$start <<- end + 1
  }

  message(get_prev_gen(generation), " is now from ",
          get_start(get_prev_gen(generation)), " to ",
          get_end(get_prev_gen(generation)))
  message(generation, " is now from ", start, " to ", end)
  message(get_next_gen(generation), " is now from ",
          get_start(get_next_gen(generation)), " to ",
          get_end(get_next_gen(generation)))
}
