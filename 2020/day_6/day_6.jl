# Day 6 - Custom Customs

using AOC
using Logging

# Part 1: Count the superset of answers from a group of people filling out customs forms

input = readlines(joinpath(@__DIR__, "input.txt"))

function parse_group_responses_unique(raw_responses::Array{String})
    grouped_responses = Array{Set}(undef, 0)
    curr_group = Set()
    
    for line in raw_responses
        if line == ""   # start new group
            push!(grouped_responses, curr_group)
            curr_group = Set()
            continue
        end
        push!(curr_group, line...)
    end 

    # don't forget to add last group
    push!(grouped_responses, curr_group)
    return grouped_responses
end

grouped_responses = parse_group_responses_unique(input)
solution = sum(length.(grouped_responses))

println("Part 1 Solution")
println("Sum of unique 'yes' counts: ", solution, "\n")

# Part 2: Count the number of answers that everyone in the group answered yes. 

input = readlines(joinpath(@__DIR__, "input.txt"))

function parse_group_responses_common(raw_responses::Array{String})
    grouped_responses = Array{Set}(undef, 0)
    curr_group = nothing

    for line in raw_responses
        if line == ""
            push!(grouped_responses, curr_group)
            curr_group = nothing
            continue
        end

        if isnothing(curr_group)
            curr_group = Set(collect(line))
        end
        curr_group = intersect(curr_group, Set(collect(line)))
    end

    push!(grouped_responses, curr_group)
    return grouped_responses
end

grouped_responses = parse_group_responses_common(input)
solution = sum(length.(grouped_responses))

println("Part 2 Solution")
println("Sum of common 'yes' counts: ", solution)



