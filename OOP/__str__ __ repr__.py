class Dog():
    def __init__(self):
        self.__str__=lambda :'a teddy'
        self.__repr__=lambda :'Teddy()'
    def __str__(self):
        return 'a dog'
    def __repr__(self):
        return 'Dog()'
def repr(x):
    return 'yfy'
Teddy = Dog()
print(repr(Teddy))       #先去global里找
print(str(Teddy))
print(Teddy)             #有str的话先调str,否则再调repr
print(Teddy.__repr__())  #先去__init__里找
print(Teddy.__str__())   #先去__init__里找