#=
Los paquetes FiniteDiff y ForwardDiff están agregados en el environment Demo1, cada vez que entro a Julia
tengo que ir a ] y activate Demo1.  Pero también puedo...  @__DIR__ al inicio del script y boom  El macro sabe 
el directorio donde se encuentra el archivo test.jl.  cd nos lleva a ese directorio y activamos el environment
=#
cd(@__DIR__)
using Pkg
Pkg.activate(".")

using FiniteDiff, ForwardDiff

f(x) = 2x^2 + x
ForwardDiff.derivative(f, 2.0)
FiniteDiff.finite_difference_derivative(f, 2.0)


#=
Supongamos que quiero que ese archivo sea un paquete, un módulo programado de forma general para 
ser usado por otros programas
=> creamos un paquete package Demo1
=#

using PkgTemplates
t = Template(user="UriGroisman")
t("Demo1")


#=
Voy al directorio .julia/dev/ y voy a encontrar todos los paquetes que creé, por ahora solo Demo1
Entro a ese directorio y están src y test.  en src está el archivo Demo1.jl que ya tiene la estructura de 
módulo.

En el ] hago dev Demo1 y agrega mi paquete al environment.
El paquete Demo1 está vivo y puede ser usado por cualquiera, pero por ahora no hace nada

Voy a copiar el contenido de test.jl en el paquete generalizándolo un poco
=#

#= 
estoy en un environment que se llama Demo1 que tiene los paquetes que necesito,
el módulo Demo1 usa los paquetes ForwardDiff y FiniteDiff asi que desde el ] hago:

1.- activate Demo1 y activa el Demo1 que esta en .julia
2.- add los paquetes que necesita