# Day 8 - Handheld Halting

using AOC

# Part 1: Fix a kid's handheld console by interpreting some instructions

function parse_instructions(inputs::Array{String})
    instructions = map(x->split(x), inputs)
    return map(x->(x[1], parse(Int, x[2])), instructions)
end

function run_program(instruction_set::Array)

    accum = 0
    visited_lines = Array{Int}(undef, 0)
    idx = 1    

    while !(idx in visited_lines)
        push!(visited_lines, idx)

        try 
            global command = instruction_set[idx][1]
            global val = instruction_set[idx][2]
        catch ex
            return (accum, true)
        end
        
        if command == "acc"
            accum += val
            idx += 1
        elseif command == "jmp"
            idx += val
        elseif command == "nop" 
            idx += 1
        end
    end

    return (accum, false)
end

inputs = readlines(joinpath(@__DIR__, "input.txt"))
inst = parse_instructions(inputs)
solution = run_program(inst)

println("Part 1 Solution")
println("Val of accumulator before infinite loop: ", solution[1], "\n")


# Part 2: Repair the instruction set to fix infinite loop

function find_fix(inst::Array)
    for (idx, line) in enumerate(inst)
        
        if line[1] == "acc"
            continue
        end

        if line[1] == "jmp"
            copy_instr = copy(inst)
            copy_instr[idx] = ("nop", line[2])
            output = run_program(copy_instr)
            if output[2]
                return output[1]
            end
        end

        if line[1] == "nop"
            copy_instr = copy(inst)
            copy_instr[idx] = ("jmp", line[2])
            output = run_program(copy_instr)
            if output[2]
                return output[1]
            end
        end
    end
end

inputs = readlines(joinpath(@__DIR__, "input.txt"))
inst = parse_instructions(inputs)
solution = find_fix(inst)

println("Part 2 Solution")
println("Value of non-infinite fix: ", solution)
