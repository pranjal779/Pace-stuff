class Vehicle:
    sound = 'honk' # class variable
    speed = None

    def __init__(self):
        """"
        two underscores followed by init followed by two underscores
        CONSTRUCTOR
        """
        print("Initializing Vehicle")


class Car:
    sound = 'beep' # class variable
    speed = None

    def __init__(self):
        print("Initializing Car")


class Planes:
    sound = 'boom'  # class variable
    speed = None

    def __init__(self):
        print("Initializing Plane")


    pass

motorcycle = Vehicle()
# bmw = Car()
# maseratti = Car()
# cessna = Planes()
#
#
#
# print(str(motorcycle) + ' is an instance/object of Vehicle class')
# print(str(bmw) + ' is an instance/object of Car class')
#
# #class variable
# print(bmw.sound + '\n' + maseratti.sound)
# print(bmw == maseratti)