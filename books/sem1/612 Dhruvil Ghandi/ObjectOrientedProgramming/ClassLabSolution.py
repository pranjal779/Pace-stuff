class Vehicle:
    sound = 'honk'

    def __init__(self, speed, make, model):
        self.speed = speed
        self.make = make
        self.model = model

    def set_year(self, year_of_make):
        self.year = year_of_make

    def __str__(self):
        return f'object \nmake:{self.make}, model:{self.model}, speed: {self.speed}'


class Car(Vehicle):

    def __init__(self, speed, make, model, gear):
        super().__init__(speed, make, model)
        self.gear = gear

    def service(self, service_miles):
        print(f'servicing car now at {service_miles} miles')


class Planes(Vehicle):

    def __init__(self, speed, make, model, cap):
        super().__init__(speed, make, model) # the first line
        self.capacity = cap

    def take_off(self, airport):
        print(f'taking off at {airport}')

    def land(self, airport):
        print(f'landing at {airport}')


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
print(boeing)


print(isinstance(boeing, Planes))
