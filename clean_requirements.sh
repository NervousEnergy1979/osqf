#!/bin/bash

# Define the input (and output) file
input_file="requirements.txt"
temp_file="requirements_temp.txt"

# Check if the input file exists
if [[ ! -f "$input_file" ]]; then
  echo "Input file $input_file does not exist."
  exit 1
fi

# Process the input file and remove text and preceding whitespace before ';' on each line, saving to a temporary file
while IFS= read -r line; do
  # Remove text after ';' and preceding whitespace if it exists
  cleaned_line=$(echo "$line" | sed 's/[[:space:]]*;.*//')

  # Check if the line contains 'gitlab' and process it
  if [[ "$cleaned_line" == *gitlab* ]]; then
    # Replace everything after the last '@' with 'main'
    cleaned_line=$(echo "$cleaned_line" | sed 's/\(.*@\).*/\1main/')
  fi

  # Write the cleaned line to the temporary file
  echo "$cleaned_line" >> "$temp_file"
done < "$input_file"

# Move the temporary file to overwrite the original file
mv "$temp_file" "$input_file"

echo "Processed requirements saved to $input_file."
