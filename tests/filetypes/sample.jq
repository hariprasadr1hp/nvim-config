# jq example to test editor settings

# Extracting the "name" field from each object
jq '.name'

# Filtering objects where the age is greater than 30
jq 'select(.age > 30)'

# Modifying a field (increase the age by 1)
jq '.age += 1'

# Creating a new field based on existing data
jq '. | {full_name: .name, age_in_5_years: (.age + 5)}'

# Accessing nested fields
jq '.address.city'

# Filtering and mapping specific fields into a new object
jq '.[] | {name: .name, email: .email}'

# Combining multiple filters with pipes
jq '.[] | select(.is_active == true) | .name'

# Converting an array of objects into an array of values
jq 'map(.email)'

# Filtering based on a nested field
jq '.[] | select(.address.city == "Wonderland")'

# Grouping users by age
jq 'group_by(.age) | map({age: .[0].age, users: map(.name)})'

