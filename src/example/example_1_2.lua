local Object = require "object"

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