# 面向对象编程（OOP）术语中英对照表

## 🔴 基础与核心概念

| 英文术语 | 中文翻译 | 简要说明 |
|----------|----------|----------|
| **Object-Oriented Programming (OOP)** | 面向对象编程 | 一种以“对象”为中心的编程范式 |
| **Class** | 类 | 定义对象的蓝图或模板 |
| **Object** | 对象 | 类的实例，包含状态和行为 |
| **Instance** | 实例 | 由类创建的对象 |
| **Method** | 方法 | 对象的行为或函数 |
| **Attribute / Property** | 属性 | 对象的状态或数据 |
| **Field / Member** | 字段 / 成员 | 类或对象中的数据成员 |
| **Constructor** | 构造器 / 构造函数 | 创建对象时调用的特殊方法 |
| **Destructor** | 析构函数 | 对象销毁时调用的特殊方法 |
| **Static** | 静态的 | 属于类而非实例的成员 |
| **Dynamic** | 动态的 | 在运行时确定的特性 |

---

## 🟠 封装与访问控制

| 英文术语 | 中文翻译 | 简要说明 |
|----------|----------|----------|
| **Encapsulation** | 封装 | 隐藏对象的内部状态，仅通过方法访问 |
| **Access Modifier** | 访问修饰符 | 控制成员访问权限的关键字 |
| **Public** | 公共的 | 任何地方都可访问 |
| **Private** | 私有的 | 仅类内部可访问 |
| **Protected** | 受保护的 | 类内部和子类可访问 |
| **Internal** | 内部的 | 同一程序集内可访问（C#） |
| **Friend** | 友元 | 允许其他类访问私有成员（C++） |
| **Getter / Setter** | 访问器 / 设置器 | 用于安全访问私有字段的方法 |
| **Property** | 属性 | 封装字段的语法糖，提供get/set访问器 |

---

## 🟡 继承与多态

| 英文术语 | 中文翻译 | 简要说明 |
|----------|----------|----------|
| **Inheritance** | 继承 | 子类获取父类特性的机制 |
| **Base Class / Parent Class / Superclass** | 基类 / 父类 / 超类 | 被继承的类 |
| **Derived Class / Child Class / Subclass** | 派生类 / 子类 | 继承自父类的类 |
| **Polymorphism** | 多态性 | 同一操作作用于不同对象产生不同行为 |
| **Method Overriding** | 方法重写 | 子类重新定义父类的方法 |
| **Method Overloading** | 方法重载 | 同一类中多个同名但参数不同的方法 |
| **Abstract Class** | 抽象类 | 不能实例化，只能被继承的类 |
| **Interface** | 接口 | 定义行为规范的抽象类型 |
| **Virtual Method** | 虚方法 | 可在子类中被重写的方法 |
| **Override** | 重写 | 子类重新实现父类的方法 |
| **Final / Sealed** | 最终的 / 密封的 | 禁止继承或重写的修饰符 |

---

## 🟢 抽象与接口

| 英文术语 | 中文翻译 | 简要说明 |
|----------|----------|----------|
| **Abstraction** | 抽象 | 隐藏复杂性，展示核心功能 |
| **Abstract Method** | 抽象方法 | 只有声明没有实现的方法 |
| **Concrete Class** | 具体类 | 实现所有方法的完整类 |
| **Interface** | 接口 | 纯抽象类型，只包含方法声明 |
| **Implementation** | 实现 | 提供方法的具体代码 |
| **Multiple Inheritance** | 多重继承 | 一个类继承多个父类 |
| **Interface Inheritance** | 接口继承 | 一个接口继承另一个接口 |

---

## 🔵 其他高级概念

| 英文术语 | 中文翻译 | 简要说明 |
|----------|----------|----------|
| **Composition** | 组合 | 对象包含其他对象作为其一部分 |
| **Aggregation** | 聚合 | 对象引用其他对象，但后者可独立存在 |
| **Association** | 关联 | 对象之间的连接关系 |
| **Dependency** | 依赖 | 一个类使用另一个类 |
| **Coupling** | 耦合 | 类之间的依赖程度 |
| **Cohesion** | 内聚 | 类内部元素的相关程度 |
| **Design Pattern** | 设计模式 | 解决常见问题的可重用方案 |
| **Singleton** | 单例模式 | 确保类只有一个实例 |
| **Factory** | 工厂模式 | 创建对象而不指定具体类 |
| **Observer** | 观察者模式 | 对象状态变化时通知依赖对象 |
| **Mixin** | 混入 / 混合类 | 提供可重用功能的类 |

---

## 🟣 常见操作与关键词

| 英文术语 | 中文翻译 | 简要说明 |
|----------|----------|----------|
| **Instantiate** | 实例化 | 创建类的实例 |
| **Extend** | 继承（动词） | 创建子类 |
| **Implement** | 实现（动词） | 提供接口或抽象方法的具体代码 |
| **Override** | 重写（动词） | 在子类中重新定义父类方法 |
| **Overload** | 重载（动词） | 在同一类中定义多个同名方法 |
| **Type Casting** | 类型转换 | 将对象从一种类型转换为另一种 |
| **Upcasting** | 向上转型 | 子类引用转换为父类引用（安全） |
| **Downcasting** | 向下转型 | 父类引用转换为子类引用（需检查） |
| **Type Safety** | 类型安全 | 防止类型错误的机制 |

---

## 📝 使用示例

```java
// 类定义
public class Animal { // Animal 类
    private String name; // 私有字段
    public Animal(String name) { // 构造函数
        this.name = name;
    }
    public void eat() { // 公共方法
        System.out.println(name + " is eating.");
    }
}

// 继承
public class Dog extends Animal { // Dog 继承 Animal
    public Dog(String name) {
        super(name); // 调用父类构造函数
    }
    @Override // 重写注解
    public void eat() { // 方法重写
        System.out.println("Dog is eating dog food.");
    }
}

// 多态示例
Animal myAnimal = new Dog("Buddy"); // 向上转型
myAnimal.eat(); // 输出: Dog is eating dog food.
