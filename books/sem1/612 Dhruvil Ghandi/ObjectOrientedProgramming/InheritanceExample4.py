class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __str__(self):
        return f'The coordinates are x:{self.x}, y:{self.y}'

    def __add__(self, other):
        x = self.x + other.x
        y = self.y + other.y
        return Point(x, y)

    def __sub__(self, other):
        """
        substraction -
        """
        pass

    def __mul__(self, other):
        """
        multiplication *
        """
        pass

    def __pow__(self, power):
        """
        power **
        """
        pass

    def __truediv__(self, other):
        """
        division /
        """
        pass

    def __floordiv__(self, other):
        """
        floor division //
        """
        pass

    def __mod__(self, other):
        """
        remainder %
        """
        pass


p1 = Point(1, 2)
print(p1)
p2 = Point(3, 4)
print(p2)
print(p1 + p2)
# operator overloading
# assignment
print(p1 - p2)
print(p1 * p2)
print(p1 ** p2)
print(p1 / p2)
print(p1 // p2)
print(p1 % p2)
