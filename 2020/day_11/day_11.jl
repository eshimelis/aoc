# Day 11 - Seating System

using AOC
import Base: +, zero

# Part 1: Find number of occupied seats on the ferry, CGoL style.

+(b::Bool, n::Nothing) = b
+(n::Nothing, b::Bool) = b
+(i::Number, n::Nothing) = i
+(n1::Nothing, n2::Nothing) = 0
zero(n::Union{Nothing, Bool}) = 0

is_seat_occupied(chr::Char) = chr=='.' ? nothing : chr!='L'

function parse_input(inputs::Array)
    # seat out dimenions
    N = length(inputs)
    M = length(inputs[1])

    occupied = Array{Union{Bool, Nothing}}(undef, N, M)
    for (idx, row) in enumerate(inputs)
        r = map(x->is_seat_occupied(x), collect(row))
        occupied[idx, :] = r
    end
    return occupied
end


function get_neighbors_adjacent(occupied::Array, row::Int, col::Int)
    neighbors = Array{Union{Bool, Nothing}}(undef, 0)
    
    for r_shift in [-1, 0, 1]
        for c_shift in [-1, 0, 1]
            idx = (row + r_shift, col + c_shift)
            if idx != (row, col)
                try
                    push!(neighbors, occupied[idx...] == true)
                catch ex
                    continue
                end
            end
        end
    end
    return neighbors
end

function render(seats::Array{Union{Bool, Nothing}})
    N, M = size(occupied)
    for i in 1:N
        for j in 1:M
            if isnothing(seats[i, j])
                print('.')
            else
                seats[i, j] ? print('#') : print('L')
            end
        end
        println()
    end
end

function update_seats(occupied::Array{Union{Bool, Nothing}}, neighbor_fn::Function, max_neighbors::Int)
    N, M = size(occupied)
    stable = true  # stability check
    out = copy(occupied)

    for i in 1:N
        for j in 1:M
            if isnothing(occupied[i, j]) # skip non-seats
                continue
            else
                neighbors = neighbor_fn(occupied, i, j)
            end

            # process seat changes
            if occupied[i, j] && sum(neighbors) > max_neighbors
                out[i, j] = false 
                stable = false
            elseif !occupied[i, j] && sum(neighbors) == 0
                out[i,j] = true
                stable = false
            end
        end
    end
    return (out, stable)
end

function find_stable_seating(occupied::Array{Union{Bool, Nothing}}, neighbor_fn::Function, max_neighbors::Int)
    stable = false
    while !stable
        occupied, stable = update_seats(occupied, neighbor_fn, max_neighbors)
    end
    return occupied
end

max_neighbors = 3
inputs = readlines(joinpath(@__DIR__, "input.txt"))
occupied = parse_input(inputs)
solution = find_stable_seating(occupied, get_neighbors_adjacent, max_neighbors)

println("Part 1 Solution")
println("Steady-state seats: ", sum(solution), "\n")


# Part 2 - More complex seating

function get_neighbors_direction(occupied::Array, row::Int, col::Int)
    neighbors = Array{Union{Bool, Nothing}}(undef, 0)

    for r_shift in [-1, 0, 1]
        for c_shift in [-1, 0, 1]
            neighbor_found = false
            scale = 1
            while !neighbor_found
                idx = (row + scale*r_shift, col + scale*c_shift)
                if idx != (row, col)
                    try
                        neighbor_occupied = occupied[idx...]
                        if isnothing(neighbor_occupied)
                            scale += 1
                        else
                            push!(neighbors, neighbor_occupied)
                            neighbor_found = true
                        end
                    catch ex  # index out of bounds
                        neighbor_found = true
                    end
                else 
                    neighbor_found = true
                end
            end
        end
    end
    return neighbors
end


max_neighbors = 4
inputs = readlines(joinpath(@__DIR__, "input.txt"))
occupied = parse_input(inputs)
solution = find_stable_seating(occupied, get_neighbors_direction, max_neighbors)

println("Part 2 Solution")
println("Stead-state seats: ", sum(solution))
