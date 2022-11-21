lines = ['a', 'b', 'c', '10']
# with open('new_text.txt', 'w') as f:
#     f.writelines(lines)
# f.close()
f = open('new_text.txt', 'a')

for l in lines:
    f.write(l+'\n')
f.close()

