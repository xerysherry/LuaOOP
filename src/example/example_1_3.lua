local Object = require "object"

-- 声明计算器类
local Counter = Object:subclass("Counter", {
    --附加新数据
    count = 0,
})

function Counter:add()
    self.count = self.count + 1
end

function Counter:get()
    return self.count
end
print(Counter)

local counter = Counter()
-- 实例名
print(counter)

-- 调用和打印
counter:add()
print(counter:get(), counter.count)