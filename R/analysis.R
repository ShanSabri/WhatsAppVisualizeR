#' Compute the chat duration
#'
#' @param x a \code{tibble} with WhatsApp chat data
#'
#' @return  a \code{Period} class indicating the duration of the chat
#' @export
#'
#' @import lubridate
#' @importFrom lubridate mdy_hms as.period

#' @examples
chat_timespan <- function(x){
  s <- x[1,]
  e <- x[nrow(x),]
  start <- lubridate::mdy_hms(paste(s$DATE, s$TIME))
  end <- lubridate::mdy_hms(paste(e$DATE, e$TIME))
  return(lubridate::as.period(start %--% end))
}


#' Helper function to determine if query should be grouped by
#' user and/or date
#'
#' @param x a \code{tibble} of WhatsApp chat data
#' @param by_user a boolean flag to indicate if query should be grouped by user
#'
#' @return a grouped \code{tibble} of WhatsApp chat data
#' @export
#'
#' @importFrom dplyr group_by
#' @examples
to_group_by <- function(x, by_user = TRUE) {
  if (by_user == TRUE){
    x %>% dplyr::group_by(DATE, USER)
  } else {
    x %>% dplyr::group_by(DATE)
  }
}


#' Compute the number of messages sent per day
#'
#' @param x a \code{tibble} of WhatsApp chat data
#' @param by_user a boolean flag to indicate if query should be grouped by user
#'
#' @return a \code{tibble} containing the number of messages sent stratified by day
#' @export
#'
#' @importFrom dplyr transmute arrange count ungroup
#'
#' @import dplyr
#' @examples
messages_per_day <- function(x, by_user = TRUE){
  query <- x %>%
    to_group_by(by_user) %>%
    count()

  if(by_user == TRUE) query <- query %>% dplyr::arrange(desc(DATE))
  else query <- query %>% dplyr::arrange(desc(n))

  query <- query %>% ungroup %>% dplyr::mutate(DATE = as.Date(DATE, format = '%m/%d/%y'))

  return(query)
}
