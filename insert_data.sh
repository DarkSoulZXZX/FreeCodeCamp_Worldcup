#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
    then
    # Insert teams
    INSERT_TEAMS_RESULT=$($PSQL "INSERT INTO TEAMS(NAME) VALUES('$WINNER')")
    INSERT_TEAMS_RESULT=$($PSQL "INSERT INTO TEAMS(NAME) VALUES('$OPPONENT')")
  fi
done

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
    then
    # Get the winner id
    WINNER_ID=$($PSQL "SELECT TEAM_ID FROM TEAMS where NAME='$WINNER'")
    # Get the opponent id
    OPPONENT_ID=$($PSQL "SELECT TEAM_ID FROM TEAMS where NAME='$OPPONENT'")
    echo WINNER: $WINNER_ID
    echo OPPONENT: $OPPONENT_ID
    INSERT_GAMES_RESULT=$($PSQL "INSERT INTO GAMES(YEAR,WINNER_ID,OPPONENT_ID,WINNER_GOALS,OPPONENT_GOALS,ROUND) VALUES($YEAR,$WINNER_ID,$OPPONENT_ID,$WINNER_GOALS,$OPPONENT_GOALS,'$ROUND')")
  fi
done
