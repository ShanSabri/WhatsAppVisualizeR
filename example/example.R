# CLEAN ENV
rm(list = ls(all = TRUE))
options(warn = -1)


# INSTALL AND LOAD LIB
# if(!require(devtools)) {install.packages(devtools)}
# devtools::install_github("ShanSabri/WhatsAppVisualizeR")
library(WhatsAppVisualizeR)
library(tidyverse)
library(ggplot2)
theme_set(theme_bw(base_size = 14) + theme(panel.grid = element_blank()))


# IMPORT CHAT DATA
chat <- import(paste(getwd(), "example/chat.txt", sep = "/"), clean = TRUE, omit_image_messages = TRUE)
chat


# CHAT DURATION
chat_timespan(chat)


# # MOST ACTIVE DAY
messages_per_day(chat, by_user = FALSE)
messages_per_day(chat, by_user = TRUE) %>% # stratified by user
  ggplot(., aes(DATE, n)) +
  geom_col(aes(fill = USER), position = "stack") +
  scale_x_date() +
  labs(y = "Number of sent messages", fill = "") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8)) +
  ggsave(paste(getwd(), "example", "messages_per_day_by_user.png", sep = "/"), height = 5, width = 10)


# EXPORT CHAT DATA
export(chat, out = paste(getwd(), "example/chat_clean.txt.gz", sep = "/"), compress = TRUE)
