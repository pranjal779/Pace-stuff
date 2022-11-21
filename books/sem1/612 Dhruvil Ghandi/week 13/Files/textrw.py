import string
import random

random_words = []
# print(random.choices(string.hexdigits, k=5))

# split and join
for i in range(10):
    random_words.append(''.join(random.choices(string.hexdigits, k=8)))
print(random_words)

with open('new.txt', 'w') as f:
    f.writelines('\n'.join(random_words))
f.close()
#
#
# # write 10 words to a file from a list
# words = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j']
# f = open('new.txt', 'w')
# for word in words:
#     f.write(word+'\n')
# f.close()
#
# # # read all words
# file = open('new.txt', 'r+')
# lines = file.readlines()
# # change the last word to IS612
# # close file
# file.seek(1)
# lines.pop()
# print(lines)
# lines.append('IS612\n')
# file.writelines(lines)
# file.close()
#
#
# # append done to the file
# f = open('new.txt', 'a')
# f.write('Done')
# f.close()
#
# # read all words
# # change the last word to IS612
# # close file
# append done to the file