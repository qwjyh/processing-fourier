using GLMakie

# integration
function integrate(f::Function, range::Tuple{Real, Real}, n::Integer)
    # type check
    @assert typeof(f(range[1] + rand() * (range[2] - range[1]))) <: Real
    
    Δx = (range[2] - range[1]) / n
    sum = 0.0
    for x in LinRange(range[1], range[2], n)
        sum += Δx * f(x)
    end
    return sum
end

print(integrate(sin, (0, 2π), 1000))


function parametric_square(t::Real)
    @assert 0 ≤ t ≤ 2π
    if t < π/4
        return (1.                , t * (4/π)      )
    elseif t < 3π/4
        return ((π/2 - t) * (4/π) , 1.             )
    elseif t < 5π/4
        return (-1.               , (π - t) * (4/π))
    elseif t < 7π/4
        return ((t - 3π/2) * (4/π), -1.            )
    else
        return (1.                , (t - 2π) * (4/π))
    end
end

"""
**returns** : 2x`length(ts)` Matrix, whose 1st row are x-coords and 2nd are y-coords
"""
function parametric_line_matrix(f::Function, ts::AbstractVector{T}) where T<:Real
    @assert typeof(f(ts[1])) <: Tuple
    result = Matrix{Float64}(undef, (2, length(ts)))
    for i in eachindex(ts)
        result[:, i] .= f(ts[i])
    end
    return result
end

θs = LinRange(0, 2π, 1000)
square_coords = parametric_line_matrix(parametric_square, θs)
lines(square_coords[1, :], square_coords[2, :])
