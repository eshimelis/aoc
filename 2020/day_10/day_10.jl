# Day 10 - Adapter Array

using AOC
using DataStructures

# Part 1: Count the distribution of joltage ranges using all your adapters?

function jolt_differences(input::Array)
    input = sort(input)
    final_jolt = max(input...) + 3  # device's highest jolt level plus 3
    curr_jolt = 0

    # keep track of differences
    jolt_diff = Array{Int}(undef, 0)

    # populate diff array
    for out_jolt in input
        push!(jolt_diff, out_jolt - curr_jolt)
        curr_jolt = out_jolt
    end

    # don't forget that last jump!
    push!(jolt_diff, final_jolt - curr_jolt)
    return jolt_diff

end

inputs = map(x->parse(Int64, x), readlines(joinpath(@__DIR__, "input.txt")))

jolt_dist = jolt_differences(inputs)

one_diffs = count(x->x==1, jolt_dist)
three_diffs = count(x->x==3, jolt_dist)

println("Part 1 Solution")
println("Three diffs: ", three_diffs, ", One diffs: ", one_diffs)
println("Product of 3/1 differences: ", one_diffs*three_diffs, "\n")


# Part 2: Compute the total ways of connecting joltage adapters to charge your device!

in_reach(a, b) = (b-a <= 3) && (b-a > 0)

function count_combinations_dynamic(jolt::Int, input::Array)
    
    # add start and goal to input array
    start = 0
    goal = max(input...) + 3 
    push!(input, start, goal) 
    
    # sort input in reverse order
    input = reverse(sort(input))

    # keep track of answers
    paths = Dict{Int, Int}()
    paths[goal] = 1  # base case

    for adapter in input[2:end]
        reachable = filter(x->in_reach(adapter, x), input)
        
        # initialize number of paths
        paths[adapter] = 0

        # accumulate backwards
        for next_adapter in reachable 
            paths[adapter] += paths[next_adapter]
        end
    end
    return paths
end

inputs = map(x->parse(Int64, x), readlines(joinpath(@__DIR__, "input.txt")))
solution = count_combinations_dynamic(0, inputs)
println("Part 2 Solution")
println("Total paths from 0 to device joltage: ", solution[0])

