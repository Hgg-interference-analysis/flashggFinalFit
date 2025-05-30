import os
import re
import math

years = ["2016preVFP", "2016postVFP", "2017", "2018"]
#years = ["2016postVFP", "2017", "2018"]
values = []

for year in years:
    file_path = f"./results/gg_m125_{year}.txt"
    if not os.path.exists(file_path):
        print(f"Missing file: {file_path}")
        continue

    with open(file_path) as f:
        for line in f:
            if "Total cross-section" in line:
                # Extract value using regex
                match = re.search(r"= ([\d\.eE+-]+)", line)
                if match:
                    value = float(match.group(1))
                    values.append(value)
                    print(f"{year}: {value}")
                    
N = len(values)
avg = sum(values)/N
sum_vals_squared = sum([v**2 for v in values])/N
err = math.sqrt(sum_vals_squared - (avg)**2)

print(f"\nAverage cross-section: {avg}")
print(f"Error in average: {err}")
