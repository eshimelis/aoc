# Day 12: Rain Risk 

using AOC
using Match
using DataStructures
using Logging

LOG_LEVEL= Logging.Debug
logger = ConsoleLogger(stdout, LOG_LEVEL, right_justify=true)
global_logger(logger)

# Part 1 - Navigate a ship and compute the Manhattan distance.

DIRECTIONS = ('N', 'E', 'S', 'W')
DIR_VEC = Dict('N' => Int[1, 0],
               'S' => Int[-1, 0],
               'E' => Int[0, 1],
               'W' => Int[0, -1])

function navigate(actions::Array)
    # initial state
    state = Int[0, 0]
    direction_idx = 2

    for action in actions
        # do something
        act = action[1]
        val = parse(Int64, action[2:end])

        debug_init_state = "initial state: ", state, DIRECTIONS[direction_idx]
        debug_action =  "action: ", action

        @match act begin
            'N'         => begin state += val.*DIR_VEC[act] end
            'S'         => begin state += val.*DIR_VEC[act] end
            'E'         => begin state += val.*DIR_VEC[act] end
            'W'         => begin state += val.*DIR_VEC[act] end
            'L'         => begin direction_idx = mod1(direction_idx - Int(val/90), 4) end
            'R'         => begin direction_idx = mod1(direction_idx + Int(val/90), 4) end
            'F'         => begin state += val.*DIR_VEC[DIRECTIONS[direction_idx]] end
            _           => nothing
        end
        debug_final_state = "final state: ", state, DIRECTIONS[direction_idx]
        @debug debug_init_state, debug_action, debug_final_state
    end

    return state, DIRECTIONS[direction_idx]
end

inputs = readlines(joinpath(@__DIR__, "input.txt"))
output = navigate(inputs)
solution = sum(abs.(output[1]))
println("Part 2 Solution")
println("Final Manhattan displacement: ", solution, "\n")

# ===================================================================

# Part 2 - Find the waypoint of the ship

# define 90 deg rotation matrix (positive clockwise)
R_90 = [0 -1; 1 0]

function navigate_waypoint(actions::Array)
    # initial state
    wp_state = Int[1, 10]
    ship_state = Int[0, 0]

    for action in actions
        # do something
        act = action[1]
        val = parse(Int64, action[2:end])
        
        debug_init_state = "initial state: ", ship_state, wp_state
        debug_action =  "action: ", action

        @match act begin
            'N'         => begin wp_state += val.*DIR_VEC[act] end
            'S'         => begin wp_state += val.*DIR_VEC[act] end
            'E'         => begin wp_state += val.*DIR_VEC[act] end
            'W'         => begin wp_state += val.*DIR_VEC[act] end
            'L'         => begin for i in 1:(val/90) begin wp_state = R' * wp_state end end end
            'R'         => begin for i in 1:(val/90) begin wp_state = R * wp_state end end end
            'F'         => begin ship_state += val.*wp_state end
            _           => nothing
        end
        debug_final_state = "final state: ", ship_state, wp_state
        @debug debug_init_state, debug_action, debug_final_state
    end
    return ship_state, wp_state
end

inputs = readlines(joinpath(@__DIR__, "input.txt"))
output = navigate_waypoint(inputs)
solution = sum(abs.(output[1]))
println("Part 2 Solution")
println("Manhattan displacement : ", solution)

