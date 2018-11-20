# WhatsAppVisualizeR

WhatsAppVisualizeR is a R Package for importing, cleaning and analyzing WhatsApp chat data.

Improvements and new features will be added on a regular basis, please [contact me](mailto:shanasabri@gmail.com) with any questions or concerns.


## Installation

Use [devtools](https://github.com/r-lib/devtools) to install WhatsAppVisualizeR directly from GitHub.

```R
# if(!require(devtools)) {install.packages(devtools)}
devtools::install_github("ShanSabri/WhatsAppVisualizeR")

```

## Usage

Load and import chat data
```R
library(WhatsAppVisualizeR)
chat <- import(paste(getwd(), "example/chat.txt", sep="/"), 
               clean = TRUE, 
               omit_image_messages = TRUE)
```


Chat duration
```R
chat_timespan(chat)
```


Plot chat activity based on number of sent messages
```R
messages_per_day(chat, by_user = FALSE)
messages_per_day(chat, by_user = TRUE) %>% # stratified by user
  ggplot(., aes(DATE, n)) +
  geom_col(aes(fill = USER), position = "stack") +
  scale_x_date() +
  labs(y = "Number of sent messages", fill = "") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8)) 
```
![messages_per_day_by_user](examples/messages_per_day_by_user.png)


Export chat data
```R
export(chat, 
       out = paste(getwd(), "example/chat_clean.txt.gz", sep="/"), 
       compress = TRUE)
```


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[GPL-3.0](https://choosealicense.com/licenses/gpl-3.0/)
