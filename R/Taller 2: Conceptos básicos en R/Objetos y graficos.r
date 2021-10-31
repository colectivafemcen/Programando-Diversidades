#Crear una variable
X<-1
#imprimir
print(X)
X

#Realizar operaciones
y <- X+2 *4

X+y

#VECTOR
#vector que va 1 a 10
vector <- 1:10
vector

#operacion:
vector *2

class(vector)

#crear vectr con problemas de clase
p <- c(1, "perro", FALSE, 1.5)
p

class(p) #funcion para conocer el tipo o clase de elementos de un objeto

#transformar verctor a numerico
as.numeric(p)

#vectores de sucesiones:
seq(2,10,2) #secuencia
rep(1,4) #replicas

#crear vectores c()
v<-c(8,6,5)

#MATRICES
matrix(1:3, nrow=2, ncol=3)

#
D <- matrix(5:8,3,4)
D
#Extraer la col 3
D[,3]
#extraer elemento fila 1 y col 2
D[1,2]

#eliminar:
Z<-D[3,-1]

#producto matricial A %*% B
A <- matrix(5:8, 3,4)
B <- matrix(6:9, 4,2)
A %*% B

#Otras operaciones matriciales:
#Producto elemento A*B
#Traspuesta t(A), t(B)
#det(A)
#Extraer  la diagonal diag(A)

#LISTA
list()
#lista lt tres elementos: nombre, no.estudiantes, edades.es
lt <- list(nombre= "nombest", no.est=4,edad.es=c(18,17,18,20))
str(lt)#despliega la información de la lista
help("str") #funcion de ayuda para conocer los argumentos y usos de una función especifica.

#extaer los elementos:
lt$edad.es[3] #Extraer edad del 3 estudiante 

#DataFrame
#se crean a partir de la fucnión data.frame()

#Factores
#se crean a partir de la función factor()

##GRAFICOS
#Histograma
#Vector con información base
distancia <- c(241.1, 284.4, 220.2, 272.4, 271.1, 268.3,
               291.6, 241.6, 286.1, 285.9, 259.6, 299.6,
               253.1, 239.6, 277.8, 263.8, 267.2, 272.6,
               283.4, 234.5, 260.4, 264.2, 295.1, 276.4,
               263.1, 251.4, 264.0, 269.2, 281.0, 283.2)

par(mfrow=c(1,2))#Linea de codigo para generar visualización.

#crear histograma frecuencias
hist(distancia, main = "Histograma de frecuencias", ylab="Frecuencias")

#crear histograma densidad
hist(distancia,prob=TRUE, main = "Histograma de densidades", ylab="Densidad")

par(mfrow=c(1,1))

#Histograma con función grid()
hist(distancia,prob=TRUE, main = "Histograma de densidad con Grid", ylab="Densidad")
grid(nx=NA,ny=NULL, lty=2, col="gray",lwd=1)
hist(distancia,prob=TRUE, main = "Histograma de densidad con Grid", add=TRUE,col="white")

hist(distancia, main = "Histograma de frecuencias", ylab="Frecuencias", col="blue")

#Histograma con curva normal:
dnorm()
lines()
hist(distancia,prob=TRUE, main = "Hist curva normal",ylab="densidad")
x <- seq(min(distancia),max(distancia), length=40)
f <- dnorm(x,mean=mean(distancia), sd=sd(distancia))
lines(x, f, col="red", lwd=2)


#Explorar paquete ggplot2 


#BOXPLOTS:
#Vector de información:
x <- c(8, 5, 14, -9, 19, 12, 3, 9, 7, 4,
       4, 6, 8, 12, -8, 2, 0, -1, 5, 3)
#crear boxplot
boxplot(x, horizontal = TRUE)

#Diagrama de cajas y bigotes por grupos
#Base de datos contenida en R
head(chickwts)

par(mfrow=c(1,2))
boxplot(chickwts$weight ~ chickwts$feed )
boxplot(weight ~ feed, data=chickwts)

#Grafico de dispersion:
#Se crea a partir de la función plot()
#Cración de variable como base para el grafico:
set.seed(12)

n <- 100
x <- runif(n)
eps <- rnorm(n, 0, 0.25)

y <- 2 + 3 * x^2 + eps	

#Creación del grafico
par(mfrow=c(1,1))
plot(x,y, pch= 19,col="black" )
plot(y ~ x,pch= 19,col="black" ) #codigos equivalentes

#Datos Nube de puntos en R con colores por grupo
grupo <- as.factor(ifelse(x < 0.5, "Grupo 1", "Grupo 2"))
plot(x, y , pch= as.numeric(grupo),col=grupo)
