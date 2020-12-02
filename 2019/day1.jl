## Day 1 - The Tyranny of the Rocket Equation

space_ship_modules = [102111, 81442, 104967, 146349, 97956, 148336, 55752, 110518, 136080, 79361, 101709, 71796, 72543, 88058, 87187, 67778, 75471, 135632, 101309, 67060, 87048, 64775, 52160, 119184, 55284, 83289, 94809, 78017, 117854, 76469, 94504, 92372, 133595, 107269, 57182, 85578, 83777, 91167, 86119, 114263, 60369, 72562, 69544, 92699, 135045, 147230, 83105, 143488, 56494, 63019, 112366, 128119, 58293, 132542, 93266, 76032, 111651, 127490, 107633, 61260, 120876, 116254, 101151, 128722, 111623, 103470, 53224, 93922, 87624, 131864, 82431, 90465, 148373, 90119, 123744, 118713, 143700, 113581, 140687, 119516, 149497, 72281, 108641, 111605, 148274, 69326, 116571, 56540, 87595, 55068, 120602, 56557, 125534, 133162, 51828, 117883, 94637, 54577, 135114, 83866]

compute_fuel(mass::Number) = Int(floor(mass/3) - 2);

function fuel_required(mass::Number)
    fuel_needed = compute_fuel(mass)
    if fuel_needed <= 0
        return 0
    else
        return fuel_needed + fuel_required(fuel_needed)
    end
end

part_1_solution = sum(map(compute_fuel, space_ship_modules))
part_2_solution = sum(map(fuel_required, space_ship_modules))

println("part1: ", part_1_solution, "\n", "part2: ", part_2_solution)