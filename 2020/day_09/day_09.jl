# Day 9 - Encoding Error

using AOC

# Part 1: Find where the cipher breaks

function xmas_cipher(input::Array, len::Int)
    preamble = input[1:len]
    idx = len+1

    while idx != length(input) + 1
        curr_val = input[idx]
        if !sum_possible(curr_val, preamble)
            return input[idx]
        end
        idx += 1
        preamble = input[idx-len:idx-1]
    end
end

function sum_possible(val::Int, arr::Array)
    for (i, a) in enumerate(arr)
        if val-a in arr[i:end]
            return true
        end
    end
    return false
end


inputs = map(x->parse(Int64, x), readlines(joinpath(@__DIR__, "input.txt")))
solution = xmas_cipher(inputs, 25)

println("Part 1 Solution")
println("Invalid val: ", solution, "\n")


# Part 2: Find a contiguous set of numbers which sum to the invalid value

function find_contiguous(inputs::Array, invalid_num::Int)
    idx = 1
    temp_idx = idx
    solution = Array{Int}(undef, 0)

    # let's iterate
    while idx != length(inputs)+1
        # println(idx)
        # println(solution)
        # println()

        push!(solution, inputs[temp_idx])

        if sum(solution) == invalid_num
            return solution
        elseif sum(solution) > invalid_num
            solution = Array{Int}(undef, 0)
            idx += 1
            temp_idx = idx
        end
        temp_idx += 1
    end
end

inputs = map(x->parse(Int64, x), readlines(joinpath(@__DIR__, "input.txt")))
invalid_num = xmas_cipher(inputs, 25)
solution = find_contiguous(inputs, invalid_num)

println("Part 2 Solution")
println("Contiguous set: ", solution)
println("Max/Min sum: ", max(solution...) + min(solution...))
