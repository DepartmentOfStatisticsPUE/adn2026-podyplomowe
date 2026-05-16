
# # Braki danych w pakietach statystycznych

# ## Kodowanie braków danych

x1 <- c(1,2,3,NA)
summary(x1)


table(x1)


table(x1, useNA = "ifany")


mean(x1)


mean(x1, na.rm = T)


na.omit(x1)


x2 <- c(1,2,3, NA, NaN)


summary(x2)


mean(x2, na.rm=T)


table(x2)
table(x2, useNA = "ifany")


na.omit(x2)



# ## Praca z brakami danych

# ### Dane wczytywane z plików


dane <- read.csv("data/plik-przyklad.csv")
head(dane)


tail(dane)


# Plik zawiera różne sposoby kodowania braków danych? Jakie? Jak to ustawić (hint `na.strings`)

# Co z korelacją? Jak wyznaczyć korelację między np. wiekiem, wzrostem i oceną gdy występują braki danych?

# with(dane, cor(wzrost, ocena))


# ### Dane ankietowe

# W tym miejscu omówiony zostanie zbiór danych z Badania Kapitału Ludzkiego.


library(haven)


doc <- read_spss("data/Baza_danych_z_badania_ludnoci_BKL_edycja_2021_SAV-SPSS.sav")
str(doc$m9_1,2)


table(doc$m9_1)
table(doc$m9_1, useNA = "ifany")


doc <- read_spss("data/Baza_danych_z_badania_ludnoci_BKL_edycja_2021_SAV-SPSS.sav", user_na = T)
str(doc$m9_1,2)


table(doc$m9_1)
table(doc$m9_1, useNA = "ifany")




