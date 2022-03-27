local default = {
  override = {
    css = {
      icon = "",
      color = "#ee7744",
      name = "css",
    },
    deb = {
      icon = "",
      color = "#ff3300",
      name = "deb",
    },
    Dockerfile = {
      icon = "",
      color = "#384d54",
      name = "Dockerfile",
    },
    html = {
      icon = "",
      color = "#e34c26",
      name = "html",
    },
    lock = {
      icon = "",
      color = "#ff8833",
      name = "lock",
    },
    mp3 = {
      icon = "",
      color = "#ff8888",
      name = "mp3",
    },
    mp4 = {
      icon = "",
      color = "#ff1111",
      name = "mp4",
    },
    out = {
      icon = "",
      color = "#ee6611",
      name = "out",
    },
    py = {
      icon = "",
      color = "#ee7733",
      name = "py",
    },
    ["robots.txt"] = {
      icon = "ﮧ",
      color = "#ffbbaa",
      name = "robots",
    },
    xz = {
      icon = "",
      color = "#ff11cc",
      name = "xz",
    },
    zip = {
      icon = "",
      color = "#ff11cc",
      name = "zip",
    },
  },
}

require("nvim-web-devicons").setup(default)
