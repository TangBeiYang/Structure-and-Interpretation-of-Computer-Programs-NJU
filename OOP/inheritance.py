# Python 面向对象编程：继承总结
# 根据 PPT 《Inheritance》内容整理

# ===== 1. 属性赋值规则 =====

class Account:
    interest = 0.02  # 类属性
    def __init__(self, holder):
        self.holder = holder  # 实例属性
        self.balance = 0

# 类属性赋值
Account.interest = 0.04  # 修改类属性，所有实例访问该属性时会使用新值（除非实例有同名属性）

# 实例属性赋值
tom_account = Account('Tom')
tom_account.interest = 0.08  # 创建或修改实例属性，不影响类属性或其他实例

# ===== 2. 继承基础 =====

# 继承语法
class CheckingAccount(Account):  # CheckingAccount 继承自 Account
    withdraw_fee = 1  # 子类特有属性
    interest = 0.01   # 重写父类属性

    def withdraw(self, amount):
        # 调用父类方法
        return Account.withdraw(self, amount + self.withdraw_fee)

# 继承意味着子类“是一种”父类
# 子类自动拥有父类的所有属性和方法，除非被重写

# ===== 3. 属性查找规则 =====

# 1. 先在实例中查找
# 2. 再在类中查找
# 3. 最后在父类中逐级查找
# 4. 如果都没找到，抛出 AttributeError

# ===== 4. 继承 vs 组合 vs Mixin =====

# 继承：is-a 关系
# 示例：CheckingAccount is an Account

# 组合：has-a 关系
# 示例：Bank has accounts

class Bank:
    def __init__(self):
        self.accounts = []  # 组合：Bank 对象包含 Account 对象列表

# Mixin：一种“混入”机制，提供可复用的方法集合，但不是严格继承
# Python 中通常通过多继承实现 Mixin

class LoggingMixin:
    def log(self, msg):
        print(f"[LOG] {msg}")

class LoggedAccount(Account, LoggingMixin):
    pass

# ===== 5. 多重继承与菱形问题 =====

class SavingsAccount(Account):
    deposit_fee = 2
    def deposit(self, amount):
        return Account.deposit(self, amount - self.deposit_fee)

class CleverAccount(CheckingAccount, SavingsAccount):
    def __init__(self, holder):
        super().__init__(holder)
        self.balance = 1  # 开户赠送1元

# 方法解析顺序（MRO）由 C3 线性化算法决定
print(CleverAccount.__mro__)  # 查看 MRO

# ===== 6. 设计原则 =====

# 1. 优先使用组合，除非确实需要“is-a”关系
# 2. 继承会破坏封装，子类需了解父类内部实现
# 3. 遵循里氏替换原则（LSP）：子类应能完全替换父类
# 4. 避免过度继承，防止层次过深

# ===== 7. 属性查找练习（来自 PPT 最后一节）=====

class A:
    z = -1
    def f(self, x):
        return B(x-1)

class B(A):
    n = 4
    def __init__(self, y):
        if y:
            self.z = self.f(y)
        else:
            self.z = C(y+1)

class C(B):
    def f(self, x):
        return x

# 测试
a = A()
b = B(1)
b.n = 5

print(C(2).n)          # 输出: 4
print(a.z == C.z)      # 输出: True
print(a.z == b.z)      # 输出: False

# 属性查找路径示例：
# b.z → B实例的z属性（通过self.f(1)得到C实例）
# b.z.z → C实例的z属性（通过C.__init__ → B.__init__ → self.f(0) 得到C实例）

# ===== 8. 总结要点 =====
# - 类属性 vs 实例属性
# - 继承语法与查找链
# - 重写与 super() 调用
# - 多继承与 MRO
# - 组合优于继承（大多数情况）
# - Mixin 作为多继承的一种使用方式
# - 遵循 LSP 原则
