## Day 2 - 1202 Program Alarm

op_code = [1,12,2,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,13,19,1,9,19,23,1,6,23,27,2,27,9,31,2,6,31,35,1,5,35,39,1,10,39,43,1,43,13,47,1,47,9,51,1,51,9,55,1,55,9,59,2,9,59,63,2,9,63,67,1,5,67,71,2,13,71,75,1,6,75,79,1,10,79,83,2,6,83,87,1,87,5,91,1,91,9,95,1,95,10,99,2,9,99,103,1,5,103,107,1,5,107,111,2,111,10,115,1,6,115,119,2,10,119,123,1,6,123,127,1,127,5,131,2,9,131,135,1,5,135,139,1,139,10,143,1,143,2,147,1,147,5,0,99,2,0,14,0]

function intcode(opcode::Array)
    index = 1
    while opcode[index] != 99
        compute_operation!(opcode, index)
        index += 4
    end
    return opcode
end


function compute_operation!(opcode, index)
    operation = opcode[index]

    # adjustment for julia's 1-indexing
    ind_1 = opcode[index+1] + 1
    ind_2 = opcode[index+2] + 1
    ind_result = opcode[index+3] + 1

    if operation == 1
        opcode[ind_result] = opcode[ind_1] + opcode[ind_2]
    elseif operation == 2
        opcode[ind_result] = opcode[ind_1] * opcode[ind_2]
    end
end

function iterative_find_noun_verb(opcode, desired_result)

    for noun_guess in 0:99
        for verb_guess in 0:99
            println("trying ", (noun_guess, verb_guess))
            temp_opcode_copy = copy(opcode)
            temp_opcode_copy[2] = noun_guess
            temp_opcode_copy[3] = verb_guess

            result = intcode(temp_opcode_copy)

            if result[1] == desired_result
                return (noun_guess, verb_guess)
            end

        end
    end
end

part_1_solution = intcode(copy(op_code))[1]
part_2_solution = iterative_find_noun_verb(copy(op_code), 19690720)

println("\npart 1: ", part_1_solution, "\n", "part 2: ", part_2_solution)