require "OO"

-- 声明新的基类，无法声明已经存在的基类，比如无法再声明一个叫"Object"的基类
OO.baseclass("myObject"--[[, {--附加数据}]])
-- or
-- local myObject = baseclass("myObject");
-- 声明完成后会记录到基类表中，所以可以通过getBaseclass()来获得
local myObject = OO.getBaseclass("myObject")

print(myObject)