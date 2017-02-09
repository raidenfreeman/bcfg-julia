#
# Solves Ae x = be
# using GC and Diagonal Scaling.
# tol is the tolerance.
#
#
function DSCG(Ae::SparseMatrixCSC{Float64,Int64},be::Array{Float64},tol::Float64)

    # Number of equations
    const n = size(be,1)

    # Diagonal Scaling
    const d = diag(Ae)
    const P = sqrt(d)
    const Pi = 1./P

    # Changes b
    const b = Pi.*be

    # Changes A
    const AUX = spdiagm(Pi)
    const A = AUX*Ae*AUX

    # First iteration: Simple Gradient Method
    const r0 = zeros(n)
    const d1 = zeros(n)
    @inbounds for i=1:n
        r0[i] =  -b[i]
        d1[i] = -r0[i]
    end
    const up = dot(r0,r0)
    const ad1 = A*r0
    const down = dot(r0,ad1)
    const alpha = up/down
    const x =  d1*alpha

    # Next residue
    const r1 = zeros(n)
    @inbounds for i=1:n
        r1[i] = r0[i] - alpha*ad1[i]
    end

    # GC iterations
    for k = 2:n

        # Deflection
        const tc = dot(r1,r1)
        const tb = dot(r0,r0)
        const bet = tc/tb

        # Direction
        @inbounds for i=1:n
            d1[i] = -r1[i] + bet*d1[i]
        end

        # VErify the norm
        const norma = norm(r1)
        if norma<tol
            return Pi.*x
        end #if

        ad1 = A*d1

        # Step
        tc = dot(r1,r1)
        tb = dot(d1,ad1)
        const alpha = tc/tb

        # New solution
        @inbounds for i=1:n
           x[i] = x[i] +alpha*d1[i]
        end

        # translate
        @inbounds for i=1:n
            r0[i] = r1[i]
            r1[i] = r0[i]+alpha*ad1[i]
        end

    end # k
    println("Its not possible to obtain the solution withing tolerance tol")
    return Pi.x

end
