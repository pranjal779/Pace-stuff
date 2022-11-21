# # csv file
# c - comma ,
# s  - seperated
# v - value
import csv

with open('c.csv', 'r', newline='\n') as names:
    reader = csv.reader(names)
    for record in reader:
        name, class_name, dob = record
        print(f'{name:<10}{class_name:<10}{dob:>10}')

with open('c.csv', 'r', newline='\n') as names:
    reader = csv.DictReader(names)
    for line in reader:
        print(line)

# average of year of birth
count = 0
sum_yob = 0
with open('marketing_campaign.csv', 'r', newline='\n',) as market:
    reader = csv.reader(market, delimiter='\t')
    for record in reader:
        sum_yob += int(record[1])
        count += 1

print(sum_yob//count)
