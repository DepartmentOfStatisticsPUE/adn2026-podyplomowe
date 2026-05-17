
# # Wczytanie potrzebnych pakietów


library(readxl)
library(survey)



# # Kalibracja 

# W tym przykładie pokażę jak można wykorzystac pakiet `survey` do kalibracji uwzględniajacej różne zmienne pomocnicze i ich kombinacje.

# Wczytujemy przykładowe dane

gosp <- read_excel("data/gospodarstwa-zajecia.xlsx")
gosp <- transform(gosp, 
                  klm = as.factor(klm),
                  woj = as.factor(woj))
head(gosp)


# W dwóch zmiennych mamy braki danych ale nie chcemy zastosować imputacji.

summary(gosp[, c("dochg", "wydg")])


# **Zadanie 1**: w ilu przypadkach brak danych występuje w obydwu kolumnach?

## miejsce na rozwiązanie




# W związku z tym musimy zastosować kalibrację ale mamy pewne informacje o zmiennych pomocniczych dla wszystkich zmiennych. Na potrzeby tego ćwiczenia pokaże jak skalibrować wagi wg zmiennej klm, woj i interakcji. Zobaczymy tez jak zmieniają się wyniki

# Tworzymy zbiór danych z pełnymi odpowiedziami

gosp_resp <- gosp[complete.cases(gosp),]


# Tworzymy informacje o wartościach globalnych zmiennych pomocniczych

pop_klm <- xtabs(~klm, gosp)
pop_woj <- xtabs(~woj, gosp)
pop_klm_woj <- xtabs(~klm+woj, gosp)


# **Zadanie 2**: czy klm i woj różnicuje `dochg` i `wydg`? Jak to sprawdzić?

## miejsce na rozwiązanie



# Tworzymy obiekt svydesign

gosp_resp_svy <- svydesign(ids=~1, data=gosp_resp)


# Jeżeli nie podamy domyślnie tworzone są wagi =1

table(weights(gosp_resp_svy))


# Przeprowadzamy kalibrację wg klm:

gosp_resp_svy_klm <- calibrate(design = gosp_resp_svy, 
                               formula = list(~klm),
                               population = list(pop_klm))


# **Zadanie 3**: prosz sprawdzić rozkład wag korzystając z `weights(gosp_resp_svy_klm)`. Ile różnych wag powstało? Dlaczego tyle?

## miejsce na rozwiązanie



# Przeprowadzamy kalibrację wg woj

gosp_resp_svy_woj <- calibrate(design = gosp_resp_svy, 
                               formula = list(~woj),
                               population = list(pop_woj))


# **Zadanie 4**: prosz sprawdzić rozkład wag korzystając z `weights(gosp_resp_svy_woj)`. Jak to wygląda w porównaniu do wcześniejszego zadania?

## miejsce na rozwiązanie


# Przeprowadzamy kalibrację wg klm i woj ale bez interakcji

gosp_resp_svy_klm_woj_noint <- calibrate(design = gosp_resp_svy, 
                                         formula = list(~klm, ~woj),
                                         population = list(pop_klm, pop_woj))


# **Zadanie 5**: czy ta kalibracja odtworzy wagi w przekrojach klm x woj?



# Przeprowadzamy kalibrację wg klm i woj z interakcją 

## przy liniowej jest problem numeryczny bo są zera w pop_klm_woj
gosp_resp_svy_klm_woj_int <- calibrate(design = gosp_resp_svy, 
                                       formula = list(~klm+woj),
                                       population = list(pop_klm_woj),
                                       calfun = "raking") 


# Porównanmy oszacowania [wartości prawdziwe: `dochg=2127`, `wydg=2012.7`]

svymean(~dochg+wydg, gosp_resp_svy)


svymean(~dochg+wydg, gosp_resp_svy_klm)
svymean(~dochg+wydg, gosp_resp_svy_woj)
svymean(~dochg+wydg, gosp_resp_svy_klm_woj_noint)
svymean(~dochg+wydg, gosp_resp_svy_klm_woj_int)

