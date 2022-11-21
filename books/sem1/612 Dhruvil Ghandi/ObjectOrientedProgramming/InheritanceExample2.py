# parent of any class that doesnt have a parent class is
# object class and thus devies some methods
class Parent:

    def __init__(self, idr):
        self.idr = idr
        print("debug: finished initializing parent")

    def who_am_i(self):
        print("parent")


# class <class_name>(<parent_class_name>)
class Child1(Parent):
    """
    by default it inherites init method from parent
    """
    pass


class Child2(Parent):

    # def __init__(self, idr, name):
    #     # dry - don't repeat yourself
    #     self.idr = idr # being repeated
    #     self.name = name
    #     print("debug: finished initializing child_2")

    def __init__(self, idr, name):
        # super() refers to the parent class
        super().__init__(idr)  # init method of the parent
        self.name = name
        print("debug: finished initializing child_2")

    # overloading who_am_i from parent class
    def who_am_i(self):
        print("I am child_2")


parent_1 = Parent(1)
child_1 = Child1(2)
child_2 = Child2(3, "some_child")

parent_1.who_am_i()
child_1.who_am_i()
child_2.who_am_i()
