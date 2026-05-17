
# # Wczytanie potrzebych pakietów

library(mice)

# # Przykład 1 z zajęć

# Przykładowe dane 

set.seed(2025)
n_rows <- 20
df_example <- data.frame(
  A = seq(1:n_rows)*2, 
  B = 5 + seq(1:n_rows)*2 + 10*rnorm(n_rows), 
  C = 2+sqrt(seq(1:n_rows)) + rnorm(n_rows)
)
df_example_miss <- df_example
df_example_miss$A[c(2,5, 13)] <- NA
df_example_miss$B[c(1,2,8,20)] <- NA
df_example_miss$C[c(9,10,14:18)] <- NA
df_example_miss


# Imputacja z wykorzystaniem metody wielokrotnej imputacji

df_example_imp <- mice(df_example_miss, m=1, seed = 2025)


# Informacja dotycząca metody i zależności w danych

df_example_imp


# Pełny zbiór danych

complete(df_example_imp)


# Podsumowanie średnich

colMeans(df_example) ## bez braków
colMeans(df_example_miss, na.rm=T) ## z brakami
colMeans(complete(df_example_imp)) ## po imputacji


# Zmiany:

# - zwiększamy liczbę zbiorów
# - określamy inną metodę
# - okreslamy zależnosci w danych (B i C zależne tylko od A)

pred_mat <- df_example_imp$predictorMatrix
pred_mat["C", "B"] <- 0
pred_mat["B", "C"] <- 0
pred_mat




df_example_imp <- mice(data = df_example_miss, 
                       m=4, 
                       method = "rf", 
                       predictorMatrix = pred_mat, 
                       seed = 2025)



df_example_imp


complete(df_example_imp, 1)
complete(df_example_imp, 3)


sapply(complete(df_example_imp, "all"), colMeans)

sapply(complete(df_example_imp, "all"), colMeans) |> 
  apply(MARGIN = 1, FUN = mean)


# Bez braków
colMeans(df_example) ## bez braków


# Regresja

lm_results <- with(df_example_imp, lm(C ~ A))
str(lm_results,1)


pool(lm_results)


summary(pool(lm_results))


coef(summary(lm(C~A, df_example)))
coef(summary(lm(C~A, df_example_miss)))



# # Przyklad użycia pakietu `MIDAS`

# adult <- read.csv("https://raw.githubusercontent.com/MIDASverse/MIDASpy/master/Examples/adult_data.csv",row.names = 1)[1:1000,]


# set.seed(89)
# adult <- add_missingness(adult, prop = 0.1)


# adult_cat <- c('workclass','marital_status','relationship','race','education','occupation','native_country')
# adult_bin <- c('sex','class_labels')

# # Apply rMIDAS preprocessing steps
# adult_conv <- convert(adult, 
#                       bin_cols = adult_bin, 
#                       cat_cols = adult_cat,
#                       minmax_scale = TRUE)


# adult_train <- train(adult_conv,
#                        training_epochs = 20,
#                        layer_structure = c(128,128),
#                        input_drop = 0.75,
#                        seed = 89)


# adult_complete <- complete(adult_train, m = 10)


# adult_model <- combine("class_labels ~ hours_per_week + sex", 
#                     adult_complete,
#                     family = stats::binomial)

# adult_model


# # Ćwiczenie na zajęcia

# 1. Proszę wczytać zbiór danych na potrzeby projektu.
# 2. Proszę zaimputować dane dla wybranych zmiennych wykorzystując metodę `mi`.



