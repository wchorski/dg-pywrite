---
{"dg-publish":true,"tags":["linux","bash","array"],"permalink":"/developer/Linux/Bash Filter Array With Another Array/","dgPassFrontmatter":true}
---

## Single Line String to Array
filter elements from one array based on another array using associative arrays (available in Bash 4.0 and above). Associative arrays allow you to use strings as keys, making the membership test more efficient.

Here's how you can do it:

```bash
#!/bin/bash
IFS=' ' read -r -a COLOR_ARRAY <<< "red yellow blue green yellow white black"
REMOVABLE_WORDS=("yellow" "white" "black")
echo "COLOR_ARRAY Array: ${COLOR_ARRAY[*]}"

# Declare an associative array
declare -A REMOVABLE_DICT

# Populate the associative array with removable words
for word in "${REMOVABLE_WORDS[@]}"
do
  REMOVABLE_DICT["$word"]=1
done

# Initialize a new array for filtered elements
NEW_ARRAY=()

# Filter the COLOR_ARRAY based on the REMOVABLE_DICT
for element in "${COLOR_ARRAY[@]}"
do
  if [[ -z ${REMOVABLE_DICT["$element"]} ]]; then
    NEW_ARRAY+=("$element")
  fi
done

# Print the filtered array
echo "Filtered Array: ${NEW_ARRAY[*]}"

```

This script does the following:

1. Reads the initial array `VERSION_ARRAY`.
2. Initializes an associative array `REMOVABLE_DICT` and populates it with the words to be removed.
3. Initializes an empty array `NEW_ARRAY` to store the filtered elements.
4. Iterates over each element in `VERSION_ARRAY`.
5. Checks if the element is not in the `REMOVABLE_DICT`.
6. If the element is not in `REMOVABLE_DICT`, it adds the element to `NEW_ARRAY`.
7. Finally, it prints the filtered array.

Using associative arrays provides a cleaner and more efficient way to check for membership compared to using regular arrays.

## Multi-Line String to Array

Sometimes the input is a multi-line string where each line item is one element in the array. use the `readarray` to parse it correctly

```bash
#!/bin/bash
MULTILINE_STRING="hero1
hero2
badguy1
hero3
badguy2"

readarray -t original_array <<< "$MULTILINE_STRING"

# Words to remove
words_to_remove=("badguy1" "badguy2")

# Declare an associative array (dictionary) for words to remove
declare -A remove_dict
for word in "${words_to_remove[@]}"
do
  remove_dict["$word"]=1
done

# Filter the original array
filtered_array=()
for word in "${original_array[@]}"
do
  if [[ -z "${remove_dict["$word"]}" ]]
  then
    filtered_array+=("$word")
  fi
done

# Output the filtered array
echo "Filtered Array: ${filtered_array[@]}"


```