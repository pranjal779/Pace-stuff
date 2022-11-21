class Parent:

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


print(isinstance(1, str))
print(isinstance(1, int))
print(isinstance(1, float))
print(isinstance(1, bool))

print('-'*72)

print(isinstance(parent_1, Parent))
print(isinstance(child_1, Parent)) # prints true because of inheritance

print(child_1.who_am_i())
