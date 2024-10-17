#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t -c"

RANDOMCOMMIT=4
ZZZ="bedge"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."

else 
  
  if [[ $1 =~ ^[A-Z][a-z]?$ ]]
    then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")

  elif [[ $1 =~ ^[0-9]+$ ]]
    then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = '$1'")
  elif [[ $1 =~ ^[A-Z][a-z]+$ ]]
    then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
  else 
    echo "I could not find that element in the database."
  fi

  if [[ $ATOMIC_NUMBER ]] 
  then
    INFO=$($PSQL "SELECT * FROM properties INNER JOIN elements ON properties.atomic_number = elements.atomic_number INNER JOIN types ON properties.type_id = types.type_id WHERE properties.atomic_number = $ATOMIC_NUMBER")
    echo "$INFO" | while read NUM BAR MASS BAR MELT BAR BOIL BAR TYPEID BAR NUM BAR SYMBOL BAR NAME BAR TYPEID BAR TYPE
    do
      echo "The element with atomic number $NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius." 
    done
  fi


fi 

