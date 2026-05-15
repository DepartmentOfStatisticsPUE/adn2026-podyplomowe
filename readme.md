# Repozytorium na potrzeby zajęć z przedmitu "Analiza danych niekompletnych"

## Podstawowe informacje

+ [Slajdy](https://www.overleaf.com/read/cnrspnsgtjpr#3639e7)

## Organizacja kodów

Wszystkie materiały kodowe znajdują się w folderze [`codes/`](codes/) i są podzielone na dwa podfoldery:

+ [`codes/qmd/`](codes/qmd/) -- notatniki Quarto (`.qmd`) oraz wyrenderowane wersje HTML (`.html`)
+ [`codes/R/`](codes/R/) -- skrypty `.R` wygenerowane z notatników

Wszystkie kody są napisane w języku R.

## Materiały na zajęcia

### 1. Problematyka braków danych

  + przydatne procedury R: `rnorm`, `plogis`, `density`, ...
  + [kody do generowania braków danych](https://htmlpreview.github.io/?https://raw.githubusercontent.com/DepartmentOfStatisticsPUE/adn-2026/refs/heads/main/codes/qmd/0-kody-do-slajdow.html)

### 2. Kodowanie braków danych w pakietach statystycznych

  + R: `NA`, `NA_integer_`, `NA_character_`, `is.na`, `Inf`, `NaN`
  + Notatnik: [qmd](codes/qmd/1-problematyka-brakow-danych.qmd) -- [R](codes/R/1-problematyka-brakow-danych.R)
  + Zbiory danych na potrzeby zajęć:
    + `csv`
    + `sav` -- [Bilans Kapitału Ludzkiego](https://www.parp.gov.pl/component/site/site/bilans-kapitalu-ludzkiego) -- [zbiór](), [kwestionariusz](https://www.parp.gov.pl/images/publications/BKL/Kwestionariusz_z_badania_ludnoci_BKL_edycja_2021_1.docx)

### 3. Metody wizualizacji braków danych

  + narzędzia R: `VIM`, `naniar`, `panelView`
  + Zbiory danych na zajęcia: [dane przekrojowe](data/data2-cross_sectional.csv), [dane panelowe (long)](data/data2-panel_long.csv), [dane panelowe (wide)](data/data2-panel_wide.csv)
  + Zbiór danych na ćwiczenia [data2-zajecia-przyklad1.csv](data/data2-zajecia-przyklad1.csv)
  + Notatnik: [qmd](codes/qmd/2-wizualizacja-brakow.qmd) -- [R](codes/R/2-wizualizacja-brakow.R) -- [HTML](https://htmlpreview.github.io/?https://raw.githubusercontent.com/DepartmentOfStatisticsPUE/adn-2026/refs/heads/main/codes/qmd/2-wizualizacja-brakow.html)

### 4. Imputacja danych

+ Imputacja dedukcyjna:
    + R: `zoo::na.locf`, `tidyr::fill`, `data.table::nafill`, `deductive`, `validate`
    + Zbiór danych na ćwiczenia [data3-zajecia-przyklad1.csv](data/data3-przyklad-imputacji.csv)
    + Notatnik: [qmd](codes/qmd/3-imputacja-dedukcyjna.qmd) -- [R](codes/R/3-imputacja-dedukcyjna.R) -- [HTML](https://htmlpreview.github.io/?https://raw.githubusercontent.com/DepartmentOfStatisticsPUE/adn-2026/refs/heads/main/codes/qmd/3-imputacja-dedukcyjna.html)

+ Imputacja metodą najbliższego sąsiada:
    + R: `simputation`, `VIM`
    + Zbiór danych na ćwiczenia [data4-czytelnictwo.csv](data/data4-czytelnictwo.csv)
    + Notatnik: [qmd](codes/qmd/4-imputacja-nn.qmd) -- [R](codes/R/4-imputacja-nn.R) -- [HTML](https://htmlpreview.github.io/?https://raw.githubusercontent.com/DepartmentOfStatisticsPUE/adn-2026/refs/heads/main/codes/qmd/4-imputacja-nn.html)

+ Imputacja metodą predykcyjnego dopasowania średnich (ang. *predictive mean matching*)
  + R: `simputation`, `FNN`
  + Zbiór danych na ćwiczenia [data4-czytelnictwo.csv](data/data4-czytelnictwo.csv)
  + Notatnik: [qmd](codes/qmd/5-imputacja-pmm.qmd) -- [R](codes/R/5-imputacja-pmm.R) -- [HTML](https://htmlpreview.github.io/?https://raw.githubusercontent.com/DepartmentOfStatisticsPUE/adn-2026/refs/heads/main/codes/qmd/5-imputacja-pmm.html)

+ Imputacja wielokrotna
  + R: [`mice`](https://github.com/amices/mice), [`rMIDAS`](https://cran.r-project.org/web/packages/rMIDAS/index.html)
  + Notatnik: [qmd](codes/qmd/6-imputacja-mi.qmd) -- [R](codes/R/6-imputacja-mi.R)

+ Imputacja regresyjna
  + R: `simputation`, `naniar`
  + Notatnik: [qmd](codes/qmd/7-imputacja-reg.qmd) -- [R](codes/R/7-imputacja-reg.R)

### 5. Case study

+ Opis i kod: [qmd](codes/qmd/8-case-study.qmd) -- [R](codes/R/8-case-study.R)
+ [zbior](./data/gospodarstwa-zajecia.xlsx)

### 6. Kalibracja

+ Wstęp do kalibracji
  + R: `survey`, `sampling`, `laeken`
  + Notatnik: [qmd](codes/qmd/9-kalibracja-wstep.qmd) -- [R](codes/R/9-kalibracja-wstep.R) -- [HTML](https://htmlpreview.github.io/?https://raw.githubusercontent.com/DepartmentOfStatisticsPUE/adn-2026/refs/heads/main/codes/qmd/9-kalibracja-wstep.html)
  + Dane na zajęcia [data5-kalibracja.csv](data/data5-kalibracja.csv)

+ Kalibracja (bardziej zaawansowana)
  + R: `survey`
  + Notatnik: [qmd](codes/qmd/10-kalibracja-case-study.qmd) -- [R](codes/R/10-kalibracja-case-study.R)
  + Dane na zajęcia [gospodarstwa-zajecia.xlsx](data/gospodarstwa-zajecia.xlsx)


### 7. Ważenie przez odwrotność prawdopodobieństwa odpowiedzi

+ PSW
  + R: `stats`, `glmnet`
  + Notatnik: [qmd](codes/qmd/11-propensity-score.qmd) -- [R](codes/R/11-propensity-score.R)
  + Dane na zajęcia [gospodarstwa-zajecia.xlsx](data/gospodarstwa-zajecia.xlsx)


### 8. Estymacja wariancji

+ R: `boot`
+ Dane na zajęcia [gospodarstwa-zajecia.xlsx](data/gospodarstwa-zajecia.xlsx)

### 9. Case study

+ [dane z Badania Kapitału Ludzkiego](https://www.parp.gov.pl/images/publications/BKL/nowy-uklad/Baza_danych_z_badania_ludnoci_BKL_edycja_2021_SAV-SPSS.sav)
+ Notatnik: [qmd](codes/qmd/12-case-study-podsumowanie.qmd) -- [R](codes/R/12-case-study-podsumowanie.R)
+ zadania do wykonania: slajdy do zajęć na Overleaf.
