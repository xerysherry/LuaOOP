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

-- 重载tostring方法
function Counter:_tostring_imp()
    return tostring(self.count)
end

-- 测试
local counter = Counter(5)
print(counter, counter.count)
