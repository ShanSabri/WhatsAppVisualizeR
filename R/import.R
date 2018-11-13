#' Import WhatsApp chat data
#'
#' @param x filename of chat data
#'
#' @return raw data.frame with chat data
#' @export
#'
#' @importFrom utils read.csv
#' @importFrom readr read_lines locale
#' @importFrom stringr str_split_fixed str_trim
#'
#' @examples
read_chat <- function(x) {
  chat <- readr::read_lines(x, locale = readr::locale(encoding = "UTF-8"))
  n_messages <- length(chat)
  chat_df <- do.call(rbind.data.frame, lapply(seq(1, n_messages, by = 1), function(l) {
    if (l > 1) {
      l <- as.character(chat[l])
      # date <- lubridate::mdy(stringr::str_split_fixed(l, "\\[|, ", n=3)[2])
      # time <- lubridate::hms(stringr::str_split_fixed(l, "\\]|, ", n=3)[2])
      date <- stringr::str_split_fixed(l, "\\[|, ", n = 3)[2]
      time <- stringr::str_split_fixed(l, "\\]|, ", n = 3)[2]
      usr <- stringr::str_split_fixed(l, "] |:", n = Inf)[4]
      msg <- stringr::str_trim(stringr::str_split_fixed(l, ": ", n = Inf)[2])
      data.frame(DATE = date, TIME = time, USER = usr, MESSAGE = msg)
    } else {
      NULL # remove group init message
    }
  }))
}



#' Helper function to filter for omitted images
#'
#' @param x WhatsApp chat data
#' @param omit boolean to whether to remove "omitted images" messages
#'
#' @return \code{data.frame} with filtered or non-filtered WhatsApp chat data
#' @export
#'
#' @importFrom dplyr filter
#'
#' @examples
omit_image_msgs <- function(x, omit = TRUE) {
  if (omit == TRUE) {
    return(dplyr::filter(x, !grepl("image omitted", MESSAGE)))
  } else {
    return(x)
  }
}


#' Clean up WhatsApp chat data
#'
#' @param x \code{data.frame} or \code{matrix} with WhatsApp chat data
#' @param omit_flag should we omit "image omitted" messages from media
#'
#' @return \code{tibble} of pre-processed WhatsApp chat data
#' @export
#'
#' @import dplyr
#' @importFrom dplyr filter mutate mutate_if
#' @importFrom tibble as.tibble
#'
#' @examples
clean_chat <- function(x, omit_flag = TRUE) {
  return(x %>%
    tibble::as.tibble() %>%
    dplyr::mutate_if(is.factor, as.character) %>%
    dplyr::filter(., !grepl("changed|added|removed|created", USER)) %>%
    dplyr::filter(., !is.na(MESSAGE) | !is.na(USER)) %>%
    dplyr::mutate(., NCHAR = nchar(as.character(MESSAGE), type = "chars")) %>%
    droplevels.data.frame() %>%
    omit_image_msgs(omit = omit_flag))
}


#' Import WhatsApp chat data
#'
#' @param x filename to WhatsApp exported chat data
#' @param clean boolean to clean and preprocess the WhatsApp chat data
#' @param omit_image_messages boolean indicating whether to remove "omitted images" messages
#'
#' @return a \code{tibble} of pre-processed WhatsApp chat data
#' @export
#'
#' @import dplyr
#'
#' @examples
import <- function(x, clean = TRUE, omit_image_messages = TRUE) {
  if (clean == TRUE) {
    x %>% read_chat(.) %>% clean_chat(., omit_flag = omit_image_messages)
  } else {
    x %>% read_chat(.)
  }
}
