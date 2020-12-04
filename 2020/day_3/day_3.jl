using AOC

# Day 3, Problem 1
# Given an circular, 2-D array of `obstacles`, determine the number of collisions while traversing it at a given slope.

input_filepath = joinpath(@__DIR__, "input.txt")
inputs = readlines(input_filepath)

N = length(inputs)
M = length(inputs[1])

forest = Array{Bool}(undef, N, M)

# parse input into a boolean array for easy counting
for (i, row) in enumerate(inputs)
    for (j, col) in enumerate(row)
        forest[i, j] = (col != '.')
    end
end

function calc_intersection_ind(forest::Array{Bool, 2}, rise::Int64, run::Int64)
    collisions = 0
    height, width = size(forest)
    
    c_ind = collect(range(1, step=rise, stop=height+1))
    r_ind = collect(range(0, step=run, length=length(c_ind)-1)) .|> x->(x%width) + 1
    
    return zip(c_ind, r_ind)
end

function count_intersections(forest::Array{Bool, 2}, indices)
  count = 0 
  for coord in indices
      count += forest[coord...]
  end
  return count
end


indices = calc_intersection_ind(forest, 1, 3)
solution = count_intersections(forest, indices)

println("Day 3, Part 1")
println("Number of collisions found: ", solution)
println()


# Day 3, Part 2
# Compute `arboreal stops` for a set of different slopes.

input_filepath = joinpath(@__DIR__, "input.txt")
inputs = readlines(input_filepath)

N = length(inputs)
M = length(inputs[1])

forest = Array{Bool}(undef, N, M)

# parse input into a boolean array for easy counting
for (i, row) in enumerate(inputs)
    for (j, col) in enumerate(row)
        forest[i, j] = (col != '.')
    end
end

slopes = ((1, 1), (1, 3), (1, 5), (1, 7), (2, 1))

intersections = zeros(Int64,length(slopes))

for (idx, slope) in enumerate(slopes)
    intersections[idx] = count_intersections(forest, calc_intersection_ind(forest, slope[1], slope[2]))
end

solution = prod(intersections)

println("Day 3, Part 2")
println("Slopes: ", slopes)
println("Product of total collisions found: ", solution)

