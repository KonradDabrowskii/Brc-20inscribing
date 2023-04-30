import os
import subprocess

# Set the number of times to run the command
num_runs = "<number_of_runs>"
fee_rate = "<fee_rate>"
file_name = "<file_name>"

# Create a file to store the inscriptions
inscriptions_file = "inscriptions.txt"

# Remove the previous inscriptions file if it exists
if os.path.exists(inscriptions_file):
    os.remove(inscriptions_file)

# Run the command the specified number of times
for i in range(num_runs):
    output = subprocess.check_output(['ord', 'wallet', 'inscribe', '--fee-rate', str(fee_rate), file_name]).decode("utf-8")
    print(output)

    # Extract the inscription value and save it to the file
    for line in output.splitlines():
        if line.startswith('"inscription":'):
            inscription = line.split('"')[3]
            print(f"Saving inscription: {inscription}")
            with open(inscriptions_file, "a") as f:
                f.write(f"{inscription}\n")