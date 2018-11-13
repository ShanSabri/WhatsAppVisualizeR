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

```R
# LOAD LIBRARY
library(WhatsAppVisualizeR)


# IMPORT WHATSAPP CHAT DATA
chat <- import(paste(getwd(), "test/data/chat.txt", sep="/"), 
               clean = TRUE, 
               omit_image_messages = TRUE)
chat


# EXPORT CLEANED WHATSAPP CHAT DATA
export(chat, 
       out = paste(getwd(), "test/data/chat_clean.txt.gz", sep="/"), 
       compress = TRUE)

```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[GPL-3.0](https://choosealicense.com/licenses/gpl-3.0/)
