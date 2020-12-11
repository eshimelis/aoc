# Day 1 - Report Repair

using AOC

# Part 1: Given a list of integers, return the product of the two numbers which sum to 2020.
sum_goal = 2020
input_filepath = joinpath(@__DIR__, "input1.txt")

# parse input file
inputs = map(x->parse(Int64, x), readlines(input_filepath))

function find_pair(input::Array{Int}, sum_goal::Int)
    for i in 1:length(inputs)
        current_val = inputs[i]
        complement = sum_goal - current_val
        if complement in inputs[i:end]
            return (current_val, complement)
        end
    end
    return nothing
end

# parse input file
inputs = map(x->parse(Int64, x), readlines(input_filepath))
solution = find_pair(inputs, sum_goal);

println("Problem 1, Part 1")
println("pair: ", solution)
println("product: ", solution[1]*solution[2])

# Part 2: Given a list of integers, return the product of three numbers which sum to 2020.

sum_goal = 2020
input_filepath = joinpath(@__DIR__, "input2.txt")

function find_triplet(inputs::Array{Int}, sum_goal::Int)
    for i in 1:length(inputs)
        current_val = inputs[i]
        complement = sum_goal - current_val
        possible_pair = find_pair(inputs[i:end], complement)
        
        if !isnothing(possible_pair)
            return (current_val, possible_pair[1], possible_pair[2])
        end
    end
    return nothing
end

inputs = map(x->parse(Int64, x), readlines(input_filepath))
solution = find_triplet(inputs, sum_goal)

println("Problem 1, Part 2")
println("triplet: ", solution)
println("product: ", solution[1]*solution[2]*solution[3])
