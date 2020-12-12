# Day X: 

using AOC
using Logging

LOG_LEVEL = Logging.Info
logger = ConsoleLogger(stdout, LOG_LEVEL)
global_logger(logger)

# Part 1 -

function solve(input::Array)
    return nothing
end

inputs = readlines(joinpath(@__DIR__, "test.txt"))
output = solve(inputs)
solution = output
println("Part 1 Solution")
println("   : ", solution, "\n")

# ===================================================================

# Part 2 -

function solve(input::Array)
    return nothing
end

inputs = readlines(joinpath(@__DIR__, "test.txt"))
output = solve(inputs)
solution = output
println("Part 2 Solution")
println("   : ", solution)

