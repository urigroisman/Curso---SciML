abstract type  Forma{T} end

# Esta forma de definir un struct admite que a y b sean Float64
struct Elipse
    a::Float64
    b::Float64
end

# Existe la posibilidad que los tipos de los campos sean paramétricos
struct Rectangulo{T1, T2} <: Forma{T1}
    long::T1
    anch::T2
end

struct Cuadrado{T} <: Forma{T}
    lado::T
end


function area(f::Forma)

    if isa(f, Rectangulo)
        return f.long * f.anch
    else
        return f.lado^2
    end

end


function main()

    r = Rectangulo{Float64, Int64}(5.0, 4)
    c = Cuadrado{Float32}(5.0f0)

    println(area(r))
    println(area(c))

end


main()