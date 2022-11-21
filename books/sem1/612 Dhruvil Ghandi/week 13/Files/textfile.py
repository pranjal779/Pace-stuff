file_zen = open('zen_of_python.txt', 'r')

#printing file object
print(file_zen)

#to read all the lines
lines = file_zen.readlines()
print(lines)

#print each line one by one
for line in lines:
    print(line)

file_zen.close()
#r read
#w writing
#a apending