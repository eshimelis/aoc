# Day 13: Shuttle Search

using AOC
using Logging

LOG_LEVEL = Logging.Debug
logger = ConsoleLogger(stdout, LOG_LEVEL)
global_logger(logger)

# Part 1 - Fine the earlier bus you can take to the airport.

function find_soonest_bus(input::Array)
    # parse inputs
    arrival = parse(Int64, input[1])
    busses = map(x->parse(Int64, x), filter(x->x!="x", split(input[2], ',')))

    best_bus = busses[1]
    best_time = Inf

    # find closest arrival times for each bus
    for bus_id in busses
        scale = div(arrival, bus_id, RoundUp)
        next_time = bus_id*scale

        if next_time < best_time
            best_time = next_time
            best_bus = bus_id
        end
    end

    return best_bus, best_time-arrival

end

inputs = readlines(joinpath(@__DIR__, "input.txt"))
output = find_soonest_bus(inputs)
solution = output
println("Part 1 Solution")
println("Best bus and wait time: ", solution)
println("Product of bus ID and wait time: ", prod(solution), "\n")

# ===================================================================

# Part 2 - Find the time stamps that the busses arrive in the order listed
# Note: Got stuck on this one, had to look online for a hint: Chinese Remainder Theorem 
#   - Consulted: https://crypto.stanford.edu/pbc/notes/numbertheory/crt.html
#       - Assumes the modulos are pairwise coprime

function cr(m, a)   
    M = prod(m)
    b = M ./ m
    return mod(sum(ai * invmod(M ÷ mi, mi) * (M ÷ mi) for (mi, ai) in zip(m, a)), M)
end
function chineseremainder(n::Array, a::Array)
    Π = prod(n)
    mod(sum(ai * invmod(Π ÷ ni, ni) * (Π ÷ ni) for (ni, ai) in zip(n, a)), Π)
end
# https://rosettacode.org/wiki/Chinese_remainder_theorem#Julia
function find_ordered_timestamp(input::Array)
    busses = map(x->parse(Int64, x), map(x-> x=="x" ? "0" : x, split(input[2], ',')))
    a = [] # remainders
    m = [] # mod

    # collect modulos and factors
    for (idx, bus_id) in enumerate(busses)
        if bus_id != 0
            push!(a, idx-1)
            push!(m, bus_id)
        end
    end
    @debug a .- 1
    @debug m
    return chineseremainder(m, a)
end

inputs = readlines(joinpath(@__DIR__, "input.txt"))
output = find_ordered_timestamp(inputs)
solution = output
println("Part 2 Solution")
println("   : ", solution)

