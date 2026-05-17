
# # Wczytanie potrzebnych pakietów

library(survey)
library(sampling)



# # Rozwiązanie przykładu 1

# ## Podejście krok po kroku

# Wczytujemy dane

dane <- read.csv2("data/data5-kalibracja.csv")
head(dane)


# Dane z pliku PDF do porównania

wynik_poprawny <- c(52.275, 50.5821, 51.4286, 50.5462, 48.4301, 39.9657, 51.0054, 54.3911, 45.4675, 49.7357, 52.275, 51.4286, 45.0443, 51.0054, 51.0054, 48.8893, 52.275, 52.275, 50.5462, 51.4286)


# Wektor wag wynikających z losowania $\boldsymbol{d}$

d <- dane$Waga


# Tworzenie macierzy zmiennych pomoczniczych (macierz $\boldsymbol{X}$)

Xs <- model.matrix(~0+Przychod + Wielkosc, dane)
head(Xs)


# Wartości globalne dla zmiennych: Przychód i Wielkość (zachowuję porządek
# danych; wektor $\boldsymbol{X}$)

wartosci_globalne <- c(19000, 280, 720)


# Wartości estymowane dla Xs (wektor $\tilde{\boldsymbol{X}}$)

wartosci_est <- colSums(Xs*d)
wartosci_est


# Liczba wierszy

n_wierszy <- NROW(dane)


# 1.  Sposób pierwszy: pętla

# Tworzymy obiekt macierz (wymiary $3 \times 3$)

# $$
# \sum_{i=1}^n d_i \boldsymbol{x}_i \boldsymbol{x}_i^T
# $$

macierz_sum <- matrix(0, 3, 3)

for (i in 1:n_wierszy) {
  macierz_sum <- macierz_sum + d[i]*Xs[i,]%*% t(Xs[i, ])
}


# Korzystamy ze wzoru na wektor $w$ (ze strony 11)

w1 <- numeric(n_wierszy)
for (i in 1:n_wierszy) {
  w1[i] <- d[i] + d[i]*t(wartosci_globalne - wartosci_est) %*% solve(macierz_sum) %*% Xs[i, ]
}


# Zaokrąglam do 3 miejsc po przecinku aby porównać do slajdów.

all.equal(round(w1,3),  round(wynik_poprawny,3))



# ## Sposób 2: obliczenia macierzowe


w2 <- d + d * t(wartosci_globalne - wartosci_est) %*% solve(t(d*Xs) %*% Xs) %*% t(Xs)
w2 <- as.numeric(w2)


# Zaokrąglam do 3 miejsc po przecinku aby porównać do slajdów.

all.equal(round(w2,3),  round(wynik_poprawny,3))



# ## Sposób 3: Wykorzystanie dostępnych pakietów 


wskaznik <- calib(Xs = Xs, 
                  d=dane$Waga, 
                  method = "linear", 
                  total = wartosci_globalne)
w2 <- dane$Waga*wskaznik


# Zaokrąglam do 3 miejsc po przecinku aby porównać do slajdów.

all.equal(round(w2,3),  round(wynik_poprawny,3))

