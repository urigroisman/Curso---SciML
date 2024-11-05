struct Prisma
    largo::Real
    ancho::Real
    altura::Real

    function Prisma()
        new(1, 1, 1)
    end

    function Prisma(l::Real, a::Real, h::Real)
        if l < 0 || a < 0 || h < 0
            error("Las dimensiones del prisma no pueden ser negativas")
        elseif a < l
            error("el ancho no puede ser menor que el largo")
        else
            new(l, a, h)
        end
    end
end

# En una struct mutable, puedo:     definir los constructors afuera de la struct
#                                   puedo cambiar los valores de los campos 
# No se aconseja su uso
mutable struct Circulo
    radio::Real
end

function Circulo_const(r::Real)
    Circulo(r)
end


function volumen(p::Prisma)
    v = p.altura * p.ancho * p.largo
end

function superficie(p::Prisma)
    s1 = p.altura * p.ancho
    s2 = p.altura * p.largo
    s3 = p.ancho * p.largo

    sa = 2 * (s1 + s2 + s3)
end

function main()
    # Ahora definí un constructor = una función, el default constructor no funciona más
    # p = Prisma(1, 2, 3) da error, debo llamar Prisma().
    # Defino un segundo constructor donde paso l, a, h.  Ahora tengo 2 constructors,
    # puedo llamar a Prisma de dos formas y obtengo 2 resultados diferentes 
    p1 = Prisma()
    p2 = Prisma(1, 2, 3)

    println(p1.largo,"   ", p2.largo)
    println(p1.ancho,"   ", p2.ancho)
    println(p1.altura,"   ", p2.altura)

    println(volumen(p1),"   ", volumen(p2))
    println(superficie(p1),"   ", superficie(p2))

    c = Circulo_const(5)
    println(c.radio)
    # como el struct Circulo es mutable, desde main puedo cambiar el valor de 
    # c.radio y lo acepta.  Esto en Prisma no está permitido. Desde main no puedo 
    # cambiar los valores de los campos
    c.radio = 6
    println(c.radio)

end

main()