.onLoad <- function(...) {
  assign(".gen_df", generations::gen_df, envir = globalenv())
}
