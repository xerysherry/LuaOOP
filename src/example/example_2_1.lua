local Object = require "object"

-- 声明计算器类
local Counter = Object:subclass("Counter", {
    --附加新数据
    count = 0,
})

function Counter:initialize(n)
    if n~=nil then
        self.count = n
    end
end

function Counter:add()
    self.count = self.count + 1
end

function Counter:get()
    return self.count
end

-- 例子
function Counter._add_imp(left, right)
    return Counter(left.count+right.count)
end

-- 实例化调用
local counter1 = Counter(1)
local counter2 = Counter(2)
local counter3 = counter1 + counter2
print(counter3.count)