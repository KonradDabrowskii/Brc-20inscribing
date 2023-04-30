#!/bin/bash

# Set the number of times to run the command
NUM_RUNS=10
FEE_RATE=50
FILE_NAME="input_file.txt"

# Create a file to store the inscriptions
INSCRIPTIONS_FILE="inscriptions.txt"

# Remove the previous inscriptions file if it exists
if [ -f $INSCRIPTIONS_FILE ]; then
  rm $INSCRIPTIONS_FILE
fi

# Run the command the specified number of times
for i in $(seq 1 $NUM_RUNS)
do
  OUTPUT=$(ord wallet inscribe --fee-rate $FEE_RATE $FILE_NAME)
  echo "$OUTPUT"

  # Extract the inscription value and save it to the file
  INSCRIPTION=$(echo "$OUTPUT" | grep "inscription" | cut -d '"' -f 4)
  echo "Saving inscription: $INSCRIPTION"
  echo $INSCRIPTION >> $INSCRIPTIONS_FILE
done