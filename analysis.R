# CLEAN ENV
rm(list=ls(all=TRUE))
options(warn = -1)


# INSTALL AND LOAD LIB
# if(!require(devtools)) {install.packages(devtools)}
devtools::install_github("ShanSabri/WhatsAppVisualizeR")
library(WhatsAppVisualizeR)


# IMPORT CHAT DATA
chat <- WhatsAppVisualizeR::import(paste(getwd(), "test/data/chat.txt", sep="/"), clean = TRUE, omit_image_messages = TRUE)
chat


# EXPORT CHAT DATA
WhatsAppVisualizeR::export(chat, out = paste(getwd(), "test/data/chat_clean.txt.gz", sep="/"), compress = TRUE)
