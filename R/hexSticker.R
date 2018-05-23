library(hexSticker)

# Icon made by freepik.com from www.flaticon.com

outline = "#EAEBEF"
background = "#64A709" # official Roomba green!
sticker(".\\inst\\figures\\vacuum.png",
        package = "roomba",
        h_fill = background,
        h_color = outline,
        p_size = 25,
        s_width = 0.5,
        s_height = 0.5,
        s_x = 1,
        filename = ".\\inst\\figures\\hexSticker.png")
