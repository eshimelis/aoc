# Day 5 - Binary Boarding

using AOC
using Logging

# Define a plane full of seats parameterized by a boolean to represent occupancy
struct Plane
    seats::Array{Bool, 2}
    size::Tuple{Int, Int}
end
Plane(row::Int, col::Int) = Plane(Array{Bool, 2}(zeros(row, col)), (row, col))


# Part 1: Given a list of boarding passes, determine the highest seat ID of all the passengers.

input_filepath = joinpath(@__DIR__, "input.txt")
inputs = readlines(input_filepath)

function binary_search(sorted_array::Array{Int}, inputs::BitArray)
    @debug "searching through: ", sorted_array 
    @debug "search path: ", inputs

    # base case
    if length(sorted_array) == 1
        @debug "found: " * string(sorted_array[1])
        return sorted_array[1]
    end
    
    # no inputs left 
    if length(inputs) == 0
        throw(ArgumentError("search inputs are empty but search array is still non-singular"))
    end
    
    lower = inputs[1]
    arr_length = length(sorted_array)
    halfway = round(Int, arr_length/2, RoundNearestTiesUp)

    # recursive call
    if lower
        return binary_search(sorted_array[1:halfway], inputs[2:end])
    else
        return binary_search(sorted_array[halfway+1:end], inputs[2:end])
    end
end

function compute_seat_id(seating::String, row_size::Int, col_size::Int)
    row_num = binary_search(collect(0:row_size-1), collect(seating[1:7]) .|> x->x=='F')
    col_num = binary_search(collect(0:col_size-1), collect(seating[8:end]) .|> x->x=='L')
    return row_num*8 + col_num
end

row_size, col_size = (128, 8)
seat_ids = inputs .|> x->compute_seat_id(x, row_size, col_size)
solution = max(seat_ids...)

println("Part 1 Solution")
println("Max seat ID: ", solution, "\n")


# Part 2: Find your seat ID

inputs = readlines(joinpath(@__DIR__, "input.txt"))
row_size, col_size = (128, 8)
seat_ids = inputs .|> x->compute_seat_id(x, row_size, col_size)
all_seats = Set(collect(range(min(seat_ids...), max(seat_ids...), step=1)))
empty_seats = setdiff(all_seats, seat_ids)

println("Part 2 Solution")
println("Unclaimed seat ids: ", empty_seats)

# logger = Logging.SimpleLogger(stdout, Logging.Debug)
# global_logger(logger)

