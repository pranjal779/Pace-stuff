class Vehicle:
    sound = 'honk' # class variable

    def __init__(self, speed, make, model):
        """"
        two underscores followed by init followed by two underscores
        CONSTRUCTOR need the parameters
        """
        self.speed = speed # object attribute
        self.make = make # object attribute
        self.model = model # object attribute

    def set_year(self, year_of_make):
        self.year = year_of_make # object attribute

    def __str__(self):
        # """
        # returns string representation of object
        # :return: string
        # """
        return f'object \nmake:{self.make}, model:' + \
               f'{self.model}, speed: {self.speed}'

class Car:

    def __init__(self, speed, make, model, gear):
        """"
        two underscores followed by init followed by two underscores
        CONSTRUCTOR need the parameters
        """
        self.speed = speed  # object attribute
        self.make = make  # object attribute
        self.model = model  # object attribute
        self.gear = gear

    def set_year(self, year_of_make):
        self.year = year_of_make  # object attribute

    def service(self, service_miles):
        print(f'servicing car now at {service_miles} miles')

    def __str__(self):
        # """
        # returns string representation of object
        # :return: string
        # """
        return f'object \nmake:{self.make}, model:' + \
               f'{self.model}, speed: {self.speed}'


class Planes:
    def __init__(self, speed, make, model, cap):
        """"
        two underscores followed by init followed by two underscores
        CONSTRUCTOR need the parameters
        """
        self.speed = speed  # object attribute
        self.make = make  # object attribute
        self.model = model  # object attribute
        self.capacity = cap

    def take_off(self, airport):
        print(f'taking off at {airport}')

    def land(self, airport):
        print(f'landing at {airport}')

    def __str__(self):
        # """
        # returns string representation of object
        # :return: string
        # """
        return f'object \nmake:{self.make}, model:' + \
               f'{self.model}, speed: {self.speed}'



motorcycle = Vehicle("200", "Ducatti", "Monster")
print(motorcycle)
motorcycle.set_year(2000)

print("-"*100)

bmw = Car(260, "BMW", "X6", 8)
bmw.service(50000)

print("-"*100)

maserati = Car(300, "Maseratti", "Ghibili", 7)
maserati.service(3000)

print("-"*100)

boeing = Planes(700, "Boeing", "747", 250)
boeing.take_off("JFK")
boeing.take_off("LGA")


print(isinstance(boeing, Planes))
