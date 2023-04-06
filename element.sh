# Program for the FreeCodeCamp Relational Databases certification
# Periodic Table Database

if [[ -z $1 ]]
then
    echo "Please provide an element as an argument."
    exit
fi

# Add the connection string for the query
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
# Query the information to the database
QUERY_RESULT=$($PSQL "SELECT elements.atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING (type_id) WHERE atomic_number::VARCHAR='$1' OR name='$1' OR symbol='$1'")

# Evaluate if the query did not return any data
if [[ -z $QUERY_RESULT ]]
then
    echo "I could not find that element in the database."
    exit
fi
# Printing the desired output
echo $QUERY_RESULT | while IFS=" " read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT
do
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
done
