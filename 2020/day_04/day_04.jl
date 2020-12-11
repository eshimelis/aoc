# Day 4 - Passport Processing

using AOC
using Logging

# Part 1: Given a list of passports, determine how many are valid.

input_filepath = joinpath(@__DIR__, "input.txt")
inputs = readlines(input_filepath)

function parse_passports(inputs::Array)
    
    # initialize list of dicts
    pp = Array{Dict{String, String}}(undef, 0)
    curr_pp = Dict{String, String}()
    for (i, line) in enumerate(inputs)
        if line == ""
            push!(pp, curr_pp)
            curr_pp = Dict()
            continue
        end

        # begin parsing
        parsed_line = split(line, " ")
        for keypair in parsed_line
            parsed_keypair = split(keypair, ":")
            curr_pp[parsed_keypair[1]] = parsed_keypair[2]
        end
    end
    # don't forge to add that last passport
    push!(pp, curr_pp)
    return pp
end

function is_valid(passport::Dict{String, String})
    full = length(passport) == 8
    only_missing_cid = (length(passport) >= 7) && ("cid" ∉ keys(passport)) 
    return full || only_missing_cid
end

output = parse_passports(inputs)
solution = sum(output .|> x->is_valid(x))

println("Part 1 Solution")
println("Num valid passports: ", solution, "\n\n")

# Part 2: Count the number of valid passports that fall within valid ranges

valid_ranges = Dict("byr" => range(1920, 2002, step=1),
                    "iyr" => range(2010, 2020, step=1),
                    "eyr" => range(2020, 2030, step=1),
                    "hgt" => Dict("in" => range(59, 76, step=1), "cm" => range(150, 193, step=1)),
                    "hcl" => Dict("num" => range(0, 9, step=1), "letters" => ['a', 'b', 'c', 'd', 'e', 'f']),
                    "ecl" => Set(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]),
                    "pid" => 9)


function is_valid_thorough(passport::Dict{String, String}, allowable::Dict{String, Any})
    @debug string(passport)
    # first check basic validity
    if !is_valid(passport)
        @debug "failed basic validity"
        return false
    end

    # check birth year
    if parse(Int, passport["byr"]) ∉ allowable["byr"]
        @debug "birth year invalid"
        return false
    end

    # check issue year
    if parse(Int, passport["iyr"]) ∉ allowable["iyr"]
        @debug "issue year invalid"
        return false
    end

    # check expiration year
    if parse(Int, passport["eyr"]) ∉ allowable["eyr"]
        @debug "expiration year invalid"
        return false
    end

    # check height
    try
        units = passport["hgt"][end-1:end]
        value = parse(Int, passport["hgt"][1:end-2])
        if value ∉ allowable["hgt"][units]
            @debug "height invalid"
            return false
        end
    catch ex
        @debug "height parse invalid"
        return false
    end

    # check hair color
    if passport["hcl"][1] != '#'
        @debug "hair color not hex"
        return false
    end
    try parse(Int, passport["hcl"][2:end], base=16)
    catch ex
        @debug "hair color invalid hex"
        return false
    end

    # check eye color
    if passport["ecl"] ∉ allowable["ecl"]
        @debug "eye color invalid"
        return false
    end

    # check passport id
    if length(passport["pid"]) != allowable["pid"]
        @debug "passport id invalid length"
        return false
    end

    # passess all checks
    @debug "passport valid"
    return true
end


# logger = SimpleLogger(stdout, Logging.Debug)
# global_logger(logger)

input_filepath = joinpath(@__DIR__, "input.txt")
inputs = readlines(input_filepath)
outputs = parse_passports(inputs)

solution = sum(outputs .|> x-> (is_valid_thorough(x, valid_ranges)))

println("Part 2 Solution")
println("Num valid passports: ", solution)
