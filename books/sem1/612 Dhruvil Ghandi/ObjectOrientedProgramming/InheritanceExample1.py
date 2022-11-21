# parent of any class that doesnt have a parent class is
# object class and thus devies some methods
class Parent:
    def __init__(self):
        print("initializing parent")
    def who_am_i(self):
        print("parent")


# class <class_name>(<parent_class_name>)
class Child1(Parent):
    pass


class Child2(Parent):
    pass


parent_1 = Parent()
child_1 = Child1()
child_2 = Child2()


#__dir__ prints all the avaible methods for a class
print(parent_1.__dir__())
print(child_1.__dir__())
print(child_2.__dir__())

print(child_1.__str__())
# print(child_1.who_am_i())
