from math import gcd
class Ratio:
    def __init__(self, number, demon):
        self.number = number
        self.demon = demon
    def __repr__(self):
        return 'Ratio({0}, {1})'.format(self.number, self.demon)
    def __str__(self):
        return '{0}/{1}'.format(self.number, self.demon)
    def __add__(self, other):
        if(type(other) is int):
            return Ratio(self.number + self.demon, self.demon)
        elif(type(other) is float):
            return float(self)+other
        elif(type(other) is Ratio):
            number= self.number * other.demon + self.demon * other.number
            demon= self.demon * other.demon
            g=gcd(number,demon)
            return Ratio(int(number / g), int(demon / g))
        else:
            return 'Error'
    def __radd__(self, other):
        return self.__add__(other)
    def __float__(self):
        return float(self.number/self.demon)
a=Ratio(1,2)
b=Ratio(1,6)
print(a+b)
print(a+2)             #需使其支持int类型
print(2+a)             #需调用__radd__函数
print(a+0.2)           #需调用__float__使其变为小数运算