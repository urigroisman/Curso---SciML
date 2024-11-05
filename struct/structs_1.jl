struct Prisma
    largo
    ancho
    altura
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
    
    # Como la struct es solo el default constructor, no tiene funciones
    # definidas adentro, entonces la puedo llamar pasando valores para 
    # los 3 campos que definí
    p = Prisma(2, 3, 4)

    println(p.largo)
    println(p.ancho)
    println(p.altura)

    println(volumen(p))
    println(superficie(p))

end

main()