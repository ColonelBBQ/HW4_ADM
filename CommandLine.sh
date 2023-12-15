#!/bin/bash

# Question 4: Command Line Question
# RQ 4.1: What is the most-watched Netflix title?

echo "The most watched title is: $(csvcut -d ',' -c movie_id,title vodclickstream_uk_movies_03.csv | sort | uniq -c | sort -nr | head -n 1 | awk -F, '{print $2}')

# I used csvcut because there were columns which had commas and I wasn't getting the correct result for each column, delimiter is comma (-d ',') and I only included columns movie_id and title from the csv file
# sort: Sorts the output for uniq because it needs data to be sorted first
# uniq -c: Counts occurrences of each movie title
# sort -nr: Sorts the counts in descending order
# head -n 1: Selects the most watched movie title
# awk -F, '{print $2}': Extracts and prints the movie title

#########################################################################################################################################################################################################################################

# RQ 4.2: Report the average time between subsequent clicks on Netflix.com

awk -F',' '{sum += $3; count++} END {print "The average time between subsequent clicks on Netflix.com is:", (count > 0 ? sum / count : 0), "seconds."}' vodclickstream_uk_movies_03.csv

# awk -F',' : Processes each row and splits it by comma
# '{sum += $3; count++}': Sums up the durations and counts the entries
# END {print "The average time between subsequent clicks on Netflix.com is:", (count > 0 ? sum / count : 0), "seconds."}: At the end, calculates and prints the average duration

#########################################################################################################################################################################################################################################

# RQ 4.3: Provide the ID of the user that has spent the most time on Netflix

csvcut -d ',' -c user_id,duration vodclickstream_uk_movies_03.csv | awk -F',' '{users[$1] += $2} END {for (user in users) {if (users[user] > max) {max = users[user]; maxUser = user}} print "The user with ID", maxUser, "has spent the most time on Netflix."}'

# Again I used csvcut because there were columns which had commas and I wasn't getting the correct result for each column, delimiter is comma (-d ',') and I only included columns user_id and duration from the csv file
# awk -F',' : Processes each row and sums durations per user
# '{users[$1] += $2}': Sums up the duration for each user
# END { ... }: At the end, finds and prints the user with maximum duration