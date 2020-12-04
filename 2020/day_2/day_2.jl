# Day 2 - Password Philosophy

using AOC

# Part 1: Given a list of 'passwords', determine how many of them are valid.
#   - Passwords will be in the form: `1-3 a: abcde`, where `1-3` is the range of number of times that `a` must appear in `abcde`.

input_filepath = joinpath(@__DIR__, "input.txt")

function is_valid_count(password::String)
    # break up the password
    pw = split(password, ' ')
   
    valid_range = split(pw[1], '-') .|> x->parse(Int64, x)
    valid_range = range(valid_range[1], valid_range[2], step=1)
    letter = pw[2][1]
    candidate_password = pw[3]
   
    total_count = count(x->x==letter, candidate_password)

    return total_count in valid_range
end

println("Day 2, Part 1")
inputs = readlines(input_filepath)
solution = count(x->is_valid_count(x), inputs)
print("Number of valid passwords: ", solution, " / ", length(inputs))


# Part 2: Similar to above, except the range describes positions that must contain only one occurence of the desired letter.

input_filepath = joinpath(@__DIR__, "input1.txt")
inputs = readlines(input_filepath)

function is_valid_pos(password::String)
    # break up the password
    pw = split(password, ' ')

    indices = split(pw[1], '-') .|> x->parse(Int64, x)
    letter = pw[2][1]
    candidate_password=pw[3]

    return (candidate_password[indices[1]] == letter) ⊻ (candidate_password[indices[2]] == letter)
end

println("Day 2, Part 2")
solution = count(x->is_valid_pos(x), inputs)
println("Number of valid passwords: ", solution, " / ", length(inputs))

