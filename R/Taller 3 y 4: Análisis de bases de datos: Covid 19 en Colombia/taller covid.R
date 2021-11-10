# https://www.datos.gov.co/Salud-y-Protecci-n-Social/Casos-positivos-de-COVID-19-en-Colombia/gt2j-8ykr

# INTALAR Y CARGAR PAQUETES -----------------------------------------------
install.packages(c("readr", "dplyr", "tidyr", "stringr", "ggplot"))

library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)
library(stringr)

# IMPORTAR LA BASE DE DATOS -----------------------------------------------
url <- "https://raw.githubusercontent.com/colectivafemcen/Programando-Diversidades/main/R/Taller%203%20y%204%3A%20An%C3%A1lisis%20de%20bases%20de%20datos%3A%20Covid%2019%20en%20Colombia/COVID19_OCTUBRE.csv"
datacolombia <- read_csv(url)
#datacolombia <- read_csv("COVID19_OCTUBRE.csv")#, locale = locale(encoding = "LATIN1"))



# EXPLORACIÓN INCIAL DE LA BASE DE DATOS ----------------------------------
dim(datacolombia) # Para conocer la dimensión de la base de datos
glimpse(datacolombia) # Para explorar las variables
head(datacolombia) # Seis primeras observaciones de la base de datos
tail(datacolombia) # Últimas seis observaciones de la base de datos
colnames(datacolombia) # Nombre de las columnas

# Quitar espacios de nombres de columnas
colnames(datacolombia) <- str_remove_all(colnames(datacolombia), " ")
# Poner todos los nombres en minúsculas
colnames(datacolombia) <- str_to_lower(colnames(datacolombia))

# Separar fecha y hora
datacolombia <- separate(datacolombia, fechareporteweb, c("fecha_reporte", "hora_reporte"), sep = " ", remove = FALSE)
datacolombia$fecha_reporte <- as.Date(datacolombia$fechareporteweb, format = "%d/%m/%Y")

# ver fecha minima y fecha maxima
min(datacolombia$fecha_reporte)
max(datacolombia$fecha_reporte)

# Conteo de faltantes
sum(is.na(datacolombia)) # Contar cuantos na hay en la base de datos
sum(is.na(datacolombia$fechademuerte)) # Na por columna



# ANÁLISIS DE VARIABLES NUMÉRICAS -----------------------------------------

# Variable Unidad de medida de edad
unique(datacolombia$unidaddemedidadeedad)
table(datacolombia$unidaddemedidadeedad)

# Variable edad
# filtrar la base de datos para solo tener registros con unidaddemedidadeedad = 1
datos_filtro <- filter(datacolombia, unidaddemedidadeedad == 1)

# Resumen de la variable edad
summary(datos_filtro$edad)

# Histograma Edad
hist(datos_filtro$edad, main = "Histograma variable edad", xlab = "Edad", ylab = "Frecuencia")

# Crear nueva variable que asigne un intervalo de edad a cada registro
datos_filtro <- mutate(datos_filtro, 
                       intervaloedad = case_when(between(Edad, 1, 9) ~ "1-9",
                                                 between(Edad, 10, 19) ~ "10-19",
                                                 between(Edad, 20, 29) ~ "20-29",
                                                 between(Edad, 30, 39) ~ "30-39",
                                                 between(Edad, 40, 49) ~ "40-49",
                                                 between(Edad, 50, 59) ~ "50-59",
                                                 between(Edad, 60, 69) ~ "60-69",
                                                 between(Edad, 70, 79) ~ "70-79",
                                                 between(Edad, 80, 89) ~ "80-89",
                                                 between(Edad, 90, 99) ~ "90-99",
                                                 between(Edad, 100, 109) ~ "100-109",
                                                 between(Edad, 110, 119) ~ "110-119"))




# ANÁLISIS DE VARIABLES CATEGÓRICAS ---------------------------------------

# Variable nombrededepartamento
# Lista de todos los departamentos con casos registrados
unique(datos_filtro$nombredepartamento)
# Número de casos registrados en cada departamento
table(datos_filtro$nombredepartamento)


# Variable nombremunicipio
# Lista de todos los municipios con casos registrados
unique(datacolombia$nombremunicipio)
length(unique(datacolombia$nombremunicipio))
table(datacolombia$nombremunicipio)

# Variable sexo
# Lista de sexo
unique(datos_filtro$sexo)
# Número de casos registrados de cada sexo
table(datos_filtro$sexo)

# Variable nombredelpaís
# Lista de todos los países de procedencia
unique(datos_filtro$nombredelpaís)


# Variable tipodecontagio
unique(datos_filtro$tipodecontagio)
# Número de casos registrados por cada tipo de contagio
table(datos_filtro$tipodecontagio)
importados <- filter(datos_filtro, tipodecontagio == "Importado")


# Variable ubicacióndelcaso
unique(datos_filtro$ubicacióndelcaso)
# Pasar todo a mayúscula
datos_filtro$ubicacióndelcaso <- str_to_upper(datos_filtro$ubicacióndelcaso)
# Número de casos por cada ubicación
table(datos_filtro$ubicacióndelcaso)

# Variable estado
unique(datos_filtro$estado)
# Pasar todo a mayúscula
datos_filtro$estado <- str_to_upper(datos_filtro$estado)
# Número de casos por estado
table(datos_filtro$estado)


# Variable recuperado
unique(datos_filtro$recuperado)
# Número de casos por categoría
table(datos_filtro$recuperado)

# Variable tipoderecuperación
unique(datos_filtro$tipoderecuperación)
# Transformar nas a N/A
datos_filtro <- mutate(datos_filtro, tipoderecuperación = case_when(is.na(tipoderecuperación) ~ "N/A",
                                                                    !is.na(tipoderecuperación) ~ tipoderecuperación))

# Número de casos por categoría
table(datos_filtro$tipoderecuperación)



# ANÁLISIS DE BASE DATOS --------------------------------------------------

# Tabla intervaloedad vs estado
table(datos_filtro$intervaloedad, datos_filtro$estado)


# Top 5 de departamentos con más casos confirmados
agrupacion <- group_by(datos_filtro, nombredepartamento)  
frecuencia_departamentos <- summarise(agrupacion, Frecuencia = n())
frecuencia_departamentos <- arrange(frecuencia_departamentos, -Frecuencia)
top_5_departamentos <- top_n(frecuencia_departamentos, 5)


# Top 5 de municipios con más casos confirmados
agrupacion <- group_by(datos_filtro, nombremunicipio)  
frecuencia_municipios <- summarise(agrupacion, Frecuencia = n())
frecuencia_municipios <- arrange(frecuencia_municipios, -Frecuencia)
top_5_municipios <- top_n(frecuencia_municipios, 5)

# GRÁFICOS ---------------------------------------------------------------

# número de casos vs dia
datos_filtro %>% 
  group_by(fecha_reporte) %>% 
  summarise(frec = n()) %>% 
  ggplot(aes(x = fecha_reporte, y = frec)) +
  geom_line(col = "purple") +
  geom_point(col = "purple") +
  theme_bw() +
  labs(title = "Gráfico número de casos por día",
  x = "Fecha", y = "Número de casos") 

# gráfico de barras para categóricas

# top 5 municipios
top_5_municipios %>% 
  ggplot(aes(x = reorder(nombremunicipio, Frecuencia), y = Frecuencia)) +
  geom_bar(stat = "identity", fill = "purple") +
  theme_bw() +
  labs(title = "Gráfico de casos top 5 municipios",
       x = "Municipios", y = "Número de casos") 


# gráfico por sexo y estado
datos_filtro %>% 
  group_by(estado, sexo) %>% 
  summarise(freq = n()) %>% 
ggplot(aes(fill=sexo, y=freq, x=estado)) + 
  geom_bar(position="dodge", stat="identity") +
  labs(title = "Gráfico de casos por estado según el género",
       x = "Estado", y = "Número de casos") 

# boxplots: edad vs estado

ggplot(data = datos_filtro, aes(x = estado, y = edad, fill = estado)) +
  geom_boxplot() + 
  theme_bw() + #Tema de fondo del gráfico
  theme(legend.position = "top", plot.title = element_text(face = "bold", 
                                                           size = 12,
                                                           hjust = 0.5), 
        plot.subtitle = element_text(size = 10, hjust = 0.5)) + 
  labs(title = "Boxplot distribución de edad por estado",y = "Edad", x = "Estado")

