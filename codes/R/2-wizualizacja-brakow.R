
# # Wczytanie potrzebych pakietów



library(VIM)
library(naniar)
library(panelView)
library(ggplot2)
library(data.table)
library(tidyverse)


# # Przykład 1: dane przekrojowe

# Wczytujemy zbiór danych `data2-cross_sectional.csv`

df_cross <- read.csv("data/data2-cross_sectional.csv")
head(df_cross)


# Proste podsumowanie

summary(df_cross)


# Wizualizacja z pakietem `VIM`

vim_result <- aggr(x = df_cross)


summary(vim_result)


# Wizualizacja z pakietem `naniar`.

vis_miss(df_cross)

vis_miss(df_cross, cluster = T, sort_miss = T)

gg_miss_var(df_cross)

gg_miss_upset(df_cross)


ggplot(data=df_cross, aes(x = x1, y)) + geom_point()


ggplot(data=df_cross, aes(x = x1, y)) + geom_miss_point()



# # Przykład 2: dane panelowe

# Wczytujemy dane w dwóch formatach: `data/data2-panel_long.csv`, `data/data2-panel_wide.csv`


df_long <- read.csv("data/data2-panel_long.csv")
head(df_long)


df_wide <- read.csv("data/data2-panel_wide.csv")
head(df_wide)


VIM::aggr(df_wide)


# Przykład przejścia z danych long na wide (z `data.table`)

df_long |>
  subset(select=c(unit_id, year, y)) |>
  setDT() |> 
  dcast(unit_id ~ year, value.var = "y") |>
  VIM::aggr(plot = F)  |>
  summary()


# Przykład przejścia z danych long na wide (z `tidyverse`)

df_long |>
  select(unit_id, year, y) |>
  pivot_wider(names_from = year, values_from = y) |>
  VIM::aggr(plot = F) |>
  summary()


panelview(data = df_long, formula = y ~ 1, index = c("unit_id", "year"), type = "missing")


panelview(data = df_long, formula = x2 ~ 1, index = c("unit_id", "year"), type = "missing")

panelview(data = df_long, formula = 1 ~ y + x1 + x2, index = c("unit_id", "year"), type = "missing")



