
# # Wczytanie potrzebnych pakietów

library(lubridate)   ## praca z datami
library(dplyr)       ## left_join, mutate
library(ggplot2)
library(imputeTS)    ## wizualizacja i imputacja braków w szeregach
library(tsibble)     ## tidy szeregi czasowe (Hyndman, Wang)
library(forecast)    ## STL + interpolacja sezonowa (Hyndman)


# # Dane

df <- read.csv("../../data/data8-szereg-czasowy.csv")
df$date <- ymd(df$date)
head(df)
nrow(df)
sum(is.na(df$sprzedaz))


# # Pipeline A: lubridate + imputeTS

# ## A1. Wykrywanie brakujących dat (lubridate)

pelny_kalendarz <- seq.Date(min(df$date), max(df$date), by = "day")
length(pelny_kalendarz)
brakujace_daty <- as.Date(setdiff(pelny_kalendarz, df$date),
                          origin = "1970-01-01")
brakujace_daty


df_pelny <- data.frame(date = pelny_kalendarz) |>
  left_join(df, by = "date") |>
  mutate(dzien_tyg = wday(date, label = TRUE, week_start = 1, abbr = TRUE),
         weekend   = dzien_tyg %in% c("So", "N"))
head(df_pelny)
nrow(df_pelny)
sum(is.na(df_pelny$sprzedaz))


# ## A2. Wizualizacja braków (imputeTS)

ggplot_na_distribution(df_pelny$sprzedaz)
ggplot_na_gapsize(df_pelny$sprzedaz)
statsNA(df_pelny$sprzedaz)


# ## A3. Imputacja kilkoma metodami (imputeTS)

y <- df_pelny$sprzedaz
y_locf   <- na_locf(y)
y_lin    <- na_interpolation(y, option = "linear")
y_spline <- na_interpolation(y, option = "spline")
y_ma     <- na_ma(y, k = 3, weighting = "exponential")

# UWAGA: dla na_kalman trzeba podać obiekt `ts` z frequency = 7,
# żeby StructTS dopasował BSM (z sezonowością tygodniową).
# Na zwykłym wektorze StructTS schodzi do lokalnego modelu poziomu -> płaska imputacja.
y_kalman_naiwny <- na_kalman(y, model = "StructTS")                        # bez sezonu
y_kalman        <- as.numeric(na_kalman(ts(y, frequency = 7), "StructTS")) # z sezonem

ggplot_na_imputations(y, y_ma)

df_porownanie <- data.frame(
  date   = rep(df_pelny$date, 6),
  metoda = rep(c("LOCF", "Liniowa", "Spline", "MA(3) wykł.",
                 "Kalman (wektor, bez sezonu)", "Kalman (ts freq=7, BSM)"),
               each = nrow(df_pelny)),
  wart   = c(y_locf, y_lin, y_spline, y_ma, y_kalman_naiwny, y_kalman),
  imputowane = rep(is.na(y), 6)
)

ggplot(df_porownanie, aes(x = date, y = wart, colour = imputowane)) +
  geom_point(size = 0.8) +
  facet_wrap(~ metoda, ncol = 1) +
  scale_colour_manual(values = c("grey40", "red")) +
  theme(legend.position = "bottom") +
  labs(x = NULL, y = "sprzedaz", colour = "imputowane?")


# # Pipeline B: tsibble::fill_gaps + forecast::na.interp (Hyndman)

# ## B1. Wykrywanie luk (tsibble)

ts_df <- as_tsibble(df, index = date)
has_gaps(ts_df)
count_gaps(ts_df)

ts_pelny <- ts_df |>
  fill_gaps()
nrow(ts_pelny)
sum(is.na(ts_pelny$sprzedaz))


# ## B2. Interpolacja sezonowa (forecast::na.interp)

y_ts     <- ts(ts_pelny$sprzedaz, frequency = 7)
y_interp <- as.numeric(na.interp(y_ts))


# ## B3. Porównanie pipeline'ów

df_AB <- data.frame(
  date   = rep(df_pelny$date, 2),
  metoda = rep(c("imputeTS::na_kalman", "forecast::na.interp"),
               each = nrow(df_pelny)),
  wart   = c(y_kalman, y_interp),
  imputowane = rep(is.na(y), 2)
)

ggplot(df_AB, aes(x = date, y = wart, colour = imputowane)) +
  geom_line(aes(group = metoda), colour = "grey70") +
  geom_point(size = 0.8) +
  facet_wrap(~ metoda, ncol = 1) +
  scale_colour_manual(values = c("grey20", "red")) +
  theme(legend.position = "bottom") +
  labs(x = NULL, y = "sprzedaz", colour = "imputowane?")


# # Inne pakiety warte uwagi:
#   padr, DTSg, zoo, xts, DTWBI, DTWUMI, tsrobprep,
#   brokenstick, swgee, cold, prophet, stlplus.
