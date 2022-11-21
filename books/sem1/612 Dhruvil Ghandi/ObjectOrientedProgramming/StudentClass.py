class Student:
    """
    sample
    """
    school = None
    name = None

    def print_name(self):
        print(self.name)
    # default str method - prints
    # __ means internal

    def __str__(self):
        return f'name = {self.name} and school = {self.school}'


dhruv = Student()

dhruv.name = "Dhruv"
dhruv.school = "SSCIS"

print(dhruv)


hill = Student()
hill.name = "J"
hill.school = "SSCIS"
hill.print_name()
