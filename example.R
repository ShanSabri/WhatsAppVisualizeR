# CLEAN ENV
rm(list=ls(all=TRUE))
options(warn = -1)


# INSTALL AND LOAD LIB
# if(!require(devtools)) {install.packages(devtools)}
# devtools::install_github("ShanSabri/WhatsAppVisualizeR")
library(WhatsAppVisualizeR)


# IMPORT CHAT DATA
chat <- import(paste(getwd(), "test/chat.txt", sep="/"), clean = TRUE, omit_image_messages = TRUE)
chat


# CHAT DURATION
chat_timespan(chat)


# # MOST ACTIVE DAY
messages_per_day(chat, by_user = FALSE)
messages_per_day(chat, by_user = TRUE) # stratified by user


# EXPORT CHAT DATA
export(chat, out = paste(getwd(), "test/chat_clean.txt.gz", sep="/"), compress = TRUE)
