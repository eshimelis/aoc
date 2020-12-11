# Day 7 - Handy Haversacks

using AOC

# Part 1 - Given a list of bag enclosures, determine the total bags enclosing a gold bag.

# Parse instructions into dict of dicts
function parse_inputs(input::Array{String})

    instructions = Dict{String, Dict{String, Int}}()

    for line in inputs
        line = line[1:end-1]
        outside, inside = split(line, " contain ")
       
        # remove 'bags'
        outside = outside[1:end-5]
        inside = split(inside, ", ")

        # initialize dictionary
        if !haskey(instructions, outside)
            instructions[outside] = Dict{String, Int}()
        end

        for bag in inside
            bag_split = split(bag, " ")
            bag_color = bag_split[2] * " " * bag_split[3]
            
            try
                instructions[outside][bag_color] = parse(Int64, bag_split[1])
            catch ex
                continue
            end
        end
    end
   return instructions
end

# Count total number of bags that eventually enclose a bag color
function num_enclosed(bag_type::String, inst::Dict)
    valid_bags = Array{String}(undef, 0)
    for bag in keys(inst)
        if encloses(bag, bag_type, inst)
            push!(valid_bags, bag)
        end
    end
    return valid_bags
end

# Check if outer bag eventually can enclose inner bag, given set of rules
function encloses(outer::String, inner::String, bag_rules::Dict)
    inner_bags = collect(keys(bag_rules[outer]))
    if inner in inner_bags
        return true
    else
        return any(map(x->encloses(x, inner, bag_rules), collect(keys(bag_rules[outer]))))
    end
end

inputs = readlines(joinpath(@__DIR__, "input.txt"))
inst = parse_inputs(inputs)
solution = num_enclosed("shiny gold", inst)

println("Part 1 Solution")
println("Total number of bags enclosing 'shiny gold': ", length(solution), "\n")

# Part 2: Count the total number of nested bags in a shiny gold bag

function count_nested_bags(bag_type::String, inst::Dict)
    # base case
    if length(inst[bag_type]) == 0
        return 0
    else
        inner_bags = collect(keys(inst[bag_type]))
        return sum(map(x->(inst[bag_type][x] + count_nested_bags(x, inst)*inst[bag_type][x]), inner_bags))
    end
end

inputs = readlines(joinpath(@__DIR__, "input.txt"))
inst = parse_inputs(inputs)
solution = count_nested_bags("shiny gold", inst)

println("Part 2 Solution")
println("Bags enclosed by 'shiny gold': ", solution)
