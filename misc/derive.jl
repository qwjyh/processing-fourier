function ft(f::Function, n::Integer; counts::Integer)
    ans = 0.0
    Δt = 2π / counts
    for t in LinRange(0, 2π, counts)
        ans += f(t) * exp(- im * n * t) * Δt
    end
    return ans
end

