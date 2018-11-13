# CLEAN ENV
rm(list = ls())


# LOAD LIB
library(WhatsAppVisualizeR)


# IMPORT CHAT DATA
chat <- WhatsAppVisualizeR::import(paste(getwd(), "test/data/chat.txt", sep="/"), clean = TRUE, omit_image_messages = TRUE)
chat
