class Account:
    name='None'
    def __init__(self,name,password):
        self.name=name
        self.password=password
        self.__balance=0
    def get_money(self,money,password):
        if self.password==password:
            self.__balance+=money
            return 'OK'
        else:
            return 'Error'
    def give_money(self,money,password):
        if self.password==password:
            if money>self.__balance:
                return '招笑'
            self.__balance-=money
            return 'OK'
        else:
            return 'Error'
    def know_balance(self,password):
        if self.password==password:
            return self.__balance
        else:
            return 'Error'
    def what_class(self,):
        print('nothing')
class AccountWechat(Account):
    def what_class(self):
        print('wechat')
        super().what_class()
class AccountZhifubao(Account):
    def __init__(self, name):
        print(name)
    def whatclass(self):
        print('zhibiao')
a=AccountWechat('yfy','1212')
b=AccountZhifubao('yfy')
a.what_class()
b.what_class()
b.whatclass()




