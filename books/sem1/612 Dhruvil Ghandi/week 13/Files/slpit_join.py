import random, string

random_words = (random.choices(string.hexdigits, k=5))
print(random_words)
new_word = ''.join(random_words)
print(new_word)
split_1 = new_word.split('')
print(split_1)