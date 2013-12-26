LuaOOP
======

这是一个Lua面向对象基础类，并方便在Lua上进行面向对象编程。


使用方法：

这里提供了两个文件，OO.lua 和object.lua，功能完全一样。区别：OO.lua使用了开头Module("OO")声明；object.lua没有使用Module，并且最后返回了预置基础了Object。

1.基本用法

1.1 获得基类

1.1.1 使用OO.lua
    
    require "OO"
    -- 获得预设基类
    local Object = OO.getBaseclass("Object")
    -- 打印类名
    print(Object)

  1.1.2 使用object.lua
    
    -- 获得预设基类
    local Object=require "object"
    -- or
    -- local Object= getBaseclass("Object")
    -- 打印类名
    print(Object)

 1.2 声明新类
    
    -- 声明计算器类
    local Counter = Object:subclass("Counter", {
        --附加新数据
        count = 0,
    })
    -- or 
    -- local Counter = OO.class("Counter", Object, {--附加新数据})
    -- or
    -- local Counter = class("Counter", Object, {--附加新数据})
    -- 打印类名
    print(Counter)

 1.3 声明类方法
    
    function Counter:add()
        self.count = self.count + 1
    end
    function Counter:get()
        return self.count
    end
    
 1.4 新类实例化和调用
    
    local counter = Counter()
    -- 实例名
    print(counter)
    -- 调用和打印
    counter:add()
    print(counter:get(), counter.count)
    
 1.5 自定义构造函数
    
    function Counter:initialize(n)
        if n~=nil then
            self.count = n
        end
    end
    
    -- 实例化调用
    local counter = Counter(9)
    print(counter:get(), counter.count)
    
 1.6 构造中调用父类构造
    
    local SubCounter = Counter:subclass("SubCounter", {
        --附加新数据
        subcount = 0,
    })
    function SubCounter:initialize(n)
        -- 不需要保证父类构造在前的顺序
        -- 调用父类构造初始化
        Counter.initialize(self, n);
        -- 自己初始化
        if n~=nil then
            self.subcount = n;
        end
    end
    
2.高级用法
 
 2.1 运算符重载
    
    -- 可以重载函数有
    --[[
        +: _add_imp(l, r)
        -: _sub_imp(l, r)
        *: _mul_imp(l, r)
        /: _div_imp(l, r)
        %: _mod_imp(l, r)
        ^: _pow_imp(l, r)
        -: _unm_imp(v) -- 取负符号，比如1取负:-1
        ..: _concat_imp(l, r) -- 字符串链接符号
        #: _len_imp(v) -- 取大小符号
        ==: _eq_imp(l, r)
        <: _lt_imp(l, r)
        <=: _le_imp(l, r)
    ]]
 
    -- 例子
    function Counter._add_imp(left, right)
        return Counter(left.count+right.count)
    end
    -- 实例化调用
    local counter1 = Counter(1)
    local counter2 = Counter(2)
    local counter3 = counter1 + counter2
    print(counter3.count)
    
 2.2 其他重载
    
    -- 重载tostring方法
    function Counter:_tostring_imp()
        return tostring(self.count)
    end
    -- 测试
    local counter = Counter(5)
    print(counter, counter.count)
 
 2.3 新的基类
    
    -- 声明新的基类，无法声明已经存在的基类，比如无法再声明一个叫"Object"的基类
    local myObject = OO.baseclass("myObject"--[[, {--附加数据}]])
    -- or
    -- local myObject = baseclass("myObject");
    -- 声明完成后会记录到基类表中，所以可以通过getBaseclass()来获得
    local myObject = OO.getBaseclass("myObject")

3.其他函数
 
 3.1 baseclass:getClass(name)、baseclass.getClassFromFullName、getClass(name, baseclass)
    
    -- 用于获得已经存在类
    -- 例子
    local A=Object:subclass("A")
    A:subclass("B")
    
    -- 获取A类
    local A = Object:getClass("A")
    -- or
    -- local A = Object.getClassFromFullName("Object.A")
    -- or
    -- 当baseclass参数不填时，默认从预设基类中找
    -- local A = getClass("Object.A", --[[Object]])
    
    -- 获取B类
    local B = A:getClass("B")
    -- or
    -- local B = Object:getClass("A.B")
    -- or
    -- local B = Object.getClassFromFullName("Object.A.B")
    -- or
    -- 当baseclass参数不填时，默认从预设基类中找
    -- local B = getClass("Object.A.B", --[[Object]])
    
 3.2 获得父类
    
    local A = B.__super;
    
 3.3 类命名规则
    
    -- A类名
    local A = Object:getClass("A")
    print(A) -- > Object.A
    -- B名
    local B = A:getClass("B")
    print(B) -- > Object.A.B
    -- B 实例
    local b = B()
    print(b) -- > Object.A.B.Instance

 3.4 类方法getName
    
    -- 返回A名
    print(A:getName())
    
 3.5 类方法printSubclasses
  
    -- 打印当前基类下的所有子类名称
    Object.printSubclasses()
    
 3.6 全局方法printBaseclasses
 
    -- 打印所有基类名称
    OO.printBaseclasses()
    -- or
    -- printBaseclasses()
    
