#--------------------------------- Mi primera vez en RStudio
# Ejemplo de operaciones básicas
6 + 4
30/6

# Crear variables
x <- 6

# Operaciones con variables 
x + 4

# Crear vectores
estatura <- c(1.70, 1.50, 1.57)

# Crear vectores de valores aleatorios
peso <- rnorm(10, mean= 60, sd = 10)
peso

# Crear fuguras
hist(peso)

#------------------Leer bases de datos 
# FIJAR DIRECTORIO DE TRABAJO
# setwd("C:/Users/fhbapto/Desktop/Taller")

#-------------- Excel
install.packages("readxl")
library(readxl)
test_data <- read_excel("test_data.xlsx")
dim(test_data)

#------------- CSV
install.packages("readr")
library(readr)
test_data <- read_delim("test_data.csv", delim=";") 
dim(test_data)

#------------ Texto
library(readr)
test_data <- read_delim("test_data.txt") 
dim(test_data)

#------------------ Exportar datos RStudio y RStudioCloud
# Usando un subconjunto de datos
datos <- test_data[1:10,]

#-------------- Excel
install.packages("xlsx")
library(xlsx)
write.xlsx(x = datos, file = "datos.xlsx")

#------------- CSV
write.table(x = datos, file = "datos.csv", sep = ",", 
            row.names = FALSE, col.names = TRUE)

#------------ Texto
write.table(x = datos, file = "datos.txt", sep = ",", 
            row.names = FALSE, col.names = TRUE)


#------------------ Exportar datos Colab
# Usando un subconjunto de datos
datos <- test_data[1:10,]

#-------------- Excel
install.packages("xlsx")
library(xlsx)
write.xlsx(x = datos, file = "datos.xlsx")

#------------- CSV
write.table(x = datos, file = "datos.csv", sep = ",", 
            row.names = FALSE, col.names = TRUE)

#------------ Texto
write.table(x = datos, file = "datos.txt", sep = ",", 
            row.names = FALSE, col.names = TRUE)
