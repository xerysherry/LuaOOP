local Object = require "Object"

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
print(A)

-- 获取B类
local B = A:getClass("B")
-- or
-- local B = Object:getClass("A.B")
-- or
-- local B = Object.getClassFromFullName("Object.A.B")
-- or
-- 当baseclass参数不填时，默认从预设基类中找
-- local B = getClass("Object.A.B", --[[Object]])
print(B)
