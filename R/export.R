#' Export WhatsApp chat data to file
#'
#' @param x \code{tibble} of WhatsApp chat data
#' @param out output file
#' @param compress boolean indicting to gzip compress output file
#'
#' @return
#' @export
#'
#' @examples
export <- function(x, out = "", compress = TRUE) {
  if (compress) out <- gzfile(out)
  write.table(x, file = out, sep = "\t", col.names = NA, row.names = TRUE, quote = FALSE)
}
