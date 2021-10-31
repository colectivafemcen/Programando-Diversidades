#Datos Histograma
distancia <- c(241.1, 284.4, 220.2, 272.4, 271.1, 268.3,
               291.6, 241.6, 286.1, 285.9, 259.6, 299.6,
               253.1, 239.6, 277.8, 263.8, 267.2, 272.6,
               283.4, 234.5, 260.4, 264.2, 295.1, 276.4,
               263.1, 251.4, 264.0, 269.2, 281.0, 283.2)
			   
#Histograma y Boxplot:
hist(distancia, probability = TRUE, ylab = "", main = "",
     col = rgb(1, 0, 0, alpha = 0.5), axes = FALSE)
axis(1) # Añade el eje horizontal
par(new = TRUE)
boxplot(distancia, horizontal = TRUE, axes = FALSE,
        lwd = 2, col = rgb(0, 0, 0, alpha = 0.2))
		
		
#Datos Boxplot desde un Vector:
x <- c(8, 5, 14, -9, 19, 12, 3, 9, 7, 4,
       4, 6, 8, 12, -8, 2, 0, -1, 5, 3)
	   


#Datos Diagrama de dispersión:
set.seed(12)

n <- 100
x <- runif(n)
eps <- rnorm(n, 0, 0.25)

y <- 2 + 3 * x^2 + eps	   

#Nube de puntos en R con colores por grupo
grupo <- as.factor(ifelse(x < 0.5, "Grupo 1", "Grupo 2"))