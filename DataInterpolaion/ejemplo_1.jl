# Interpolation using different methods
using DataInterpolations, Plots

# We will use the following data to demonstrate interpolation methods.
# Dependent variable
u = [14.7, 11.51, 10.41, 14.95, 12.24, 11.22]

# Independent variable
t = [0.0, 62.25, 109.66, 162.66, 205.8, 252.3]



# For each method, we will show how to perform the fit and use the plot recipe to
# show the fitting curve.



# Linear Interpolation
# This is a linear interpolation between the ends points of the interval of input data points.
A = LinearInterpolation(u, t)

#===================================================================================================
Cuando llamo a la función LinearInterpolation se crea una:  estructura LinearInterpolation
                                                            función constructora LinearInterpolation
                                                            una variable A
A es una instancia de la estructura LinearInterpolation creada con el campo I establecido como `nothing`.
Este objeto representa una interpolación lineal incompleta ya que posteriormente se calcula el campo I
(integral acumulativa) y se crea una nueva instancia completa.

En el contexto de la función constructora, cuando se crea A, se inicializa con:

u:                  Datos dependientes (por ejemplo, valores de una variable dependiente).
t:                  Datos independientes (por ejemplo, tiempo o cualquier variable independiente).
I:                  Inicialmente establecido en nothing (aún no calculado).
p:                  Parámetros calculados por LinearParameterCache.
extrapolate:        Valor booleano que indica si se debe extrapolar más allá de los datos.
cache_parameters:   Valor booleano que indica si se deben cachear parámetros.
linear_lookup:      Valor booleano que indica si se realiza una búsqueda lineal.

Nota: En este momento, I es nothing, lo que significa que la integral acumulativa aún no se ha calculado.

Después de calcular I = cumulative_integral(A, cache_parameters), se crea una nueva instancia
de LinearInterpolation con I completo.
Ahora, esta nueva instancia contiene:

I: Integral acumulativa calculada a partir de los datos u y t.
====================================================================================================#
println("A.u = ", A.u)
println("A.t = ", A.t)
println("A.I = ", A.I)
println("A.p = ", A.p)
println("A.extrapolate = ", A.extrapolate)
println("A.iguesser = ", A.iguesser)
println("A.linear_lookup = ", A.linear_lookup)

plot(A)



# Quadratic Interpolation
# This function fits a parabola passing through the two nearest points from the
# input data point as well as the next-closest point on the right or left, depending 
# on whether the forward- or backward-lookin
A = QuadraticInterpolation(u, t, :Forward)  # same as QuadraticInterpolation(u,t,:Forward)
                                            # alternatively: A = QuadraticInterpolation(u,t,:Backward)
P1 = plot(A)
A = QuadraticInterpolation(u,t,:Backward)
P2 = plot(A)
plot(P1, P2, layout = (1, 2), size = (1000, 400))



# Lagrange Interpolation
# It fits a polynomial of degree d (=length(t)-1), and is thus a continuously differentiable function.
A = LagrangeInterpolation(u, t)


plot(A)

A = AkimaInterpolation(u, t)
plot(A)

A = ConstantInterpolation(u, t)
plot(A)

A = ConstantInterpolation(u, t, dir = :right)
plot(A)

A = QuadraticSpline(u, t)
plot(A)

A = CubicSpline(u, t)
plot(A)

A = BSplineInterpolation(u, t, 3, :ArcLen, :Average)
plot(A)

A = BSplineApprox(u, t, 3, 4, :ArcLen, :Average)
plot(A)

du = [-0.047, -0.058, 0.054, 0.012, -0.068, 0.0011]
A = CubicHermiteSpline(du, u, t)
plot(A)

A = PCHIPInterpolation(u, t)
plot(A)

ddu = [0.0, -0.00033, 0.0051, -0.0067, 0.0029, 0.0]
du = [-0.047, -0.058, 0.054, 0.012, -0.068, 0.0011]
A = QuinticHermiteSpline(ddu, du, u, t)
plot(A)

using RegularizationTools
d = 2
λ = 1e3
A = RegularizationSmooth(u, t, d; λ = λ, alg = :fixed)
û = A.û
# interpolate using the smoothed values
N = 200
titp = collect(range(minimum(t), maximum(t), length = N))
uitp = A.(titp)
lw = 1.5
scatter(t, u, label = "data")
scatter!(t, û, marker = :square, label = "smoothed data")
plot!(titp, uitp, lw = lw, label = "smoothed interpolation")



import StableRNGs: StableRNG
rng = StableRNG(318)
t = sort(10 .* rand(rng, 100))
u = sin.(t) .+ 0.5 * randn(rng, 100);

d = 4
A = RegularizationSmooth(u, t, d; alg = :gcv_svd)
û = A.û
N = 200
titp = collect(range(minimum(t), maximum(t), length = N))
uitp = A.(titp)
Am = RegularizationSmooth(u, t, titp, d; alg = :gcv_svd)
ûm = Am.û
scatter(t, u, label = "simulated data", legend = :top)
scatter!(t, û, marker = (:square, 4), label = "smoothed data")
plot!(titp, uitp, lw = lw, label = "smoothed interpolation")
plot!(titp, ûm, lw = lw, linestyle = :dash, label = "smoothed, more points")

# Curve Fits
m(t, p) = @. p[1] * sin(p[2] * t) + p[3] * cos(p[4] * t)

using Optim
A = Curvefit(u, t, m, ones(4), LBFGS())
plot(A)

A.pmin

A = Curvefit(u, t, m, zeros(4), LBFGS())
plot(A)

A.pmin