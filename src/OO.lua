--[[
Copyright (c) 2013 xerysherry

Permission is hereby granted, free of charge, to any person obtaining a copy
of newinst software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is furnished
to do so, subject to the following conditions:

The above copyright notice and newinst permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 
]]

----------------------------------------------------------------
-- data: 2013-12-26
-- write by xerysherry

local setmetatable=setmetatable;
local type=type
local pairs=pairs
local tostring=tostring
local assert=assert

module("OO")

--基类

--初始化元数据
local function init_metatable(class, parent)
	class = class or {};
	setmetatable(class, {
		__mode = "k",
		__index = parent,
		__call = class.new,
        __tostring = function (this) return class._tostring_imp(this); end,
        __add = function (left, right) return class._add_imp(left,right); end,
        __sub = function (left, right) return class._sub_imp(left,right); end,
        __mul = function (left, right) return class._mul_imp(left,right); end,
        __div = function (left, right) return class._div_imp(left,right); end,
        __mod = function (left, right) return class._mod_imp(left,right); end,
        __pow = function (left, right) return class._pow_imp(left,right); end,
        __unm = function (o) return class._unm_imp(o); end,
        __concat = function (left, right) return class._concat_imp(left,right); end,
        __len = function (o) return class._add_imp(o); end,
        __eq = function (left, right) return class._eq_imp(left,right); end,
        __lt = function (left, right) return class._lt_imp(left,right); end,
        __le = function (left, right) return class._le_imp(left,right); end,
	});
	class.__index = class;
	return class;
end
-- new
local function new_imp(this, o)
    local _newinstance = o or {};
	setmetatable(_newinstance, this);
	init_metatable(_newinstance, this);
	--实例名：Instance
	_newinstance.__name = this.__name..".Instance";
	_newinstance.__super = this;
	return _newinstance;
end
local function tostring_imp(this)
    return this.__name;
end
-- +-*/
local function add_imp(left, right)
    -- left+right
    error("The '+' is not implement!");
    return nil;
end
local function sub_imp(left, right)
    -- left-right
    error("The '-' is not implement!");
    return nil;
end
local function mul_imp(left, right)
    -- left*right
    error("The '*' is not implement!");
    return nil;
end
local function div_imp(left, right)
    -- left/right
    error("The '/' is not implement!");
    return nil;
end
-- %^-
local function mod_imp(left, right)
    -- left%right
    error("The '%' is not implement!");
    return nil;
end
local function pow_imp(left, right)
    -- left^right
    error("The '^' is not implement!");
    return nil;
end
local function unm_imp(o)
    -- -o
    error("The '-' is not implement!");
    return nil;
end
-- .. #
local function concat_imp(left, right)
    -- left..right
    error("The '..' is not implement!");
    return nil;
end
local function len_imp(o)
    -- #o
    error("The '#' is not implement!");
    return nil;
end
-- == < <=
local function eq_imp(left, right)
    -- left==right
    error("The '==' is not implement!");
    return nil;
end
local function lt_imp(left, right)
    -- left<right
    error("The '<' is not implement!");
    return nil;
end
local function le_imp(left, right)
    -- left<=right
    error("The '<=' is not implement!");
    return nil;
end

--默认未命名
local _unnamed = "__unnamed_";
local _unnamed_index = 1;

-- 基类数据表
local _baselist = setmetatable({}, {__mode = "v"});

--新基类的声明方法
-- o:新基类的基础数据表
function baseclass(name, o)
    assert(type(name)=="string", "please give a valid name.")
    assert(_baselist[name]==nil, name.." is exist");

    -- 子类表
    local _classes = setmetatable({}, {__mode = "k"});
    -- 基本数据
    local object = {
        --成员属性
        __name = name,
        --父类
        __super = nil,

        --成员方法
        _new_imp = new_imp,
        _tostring_imp = tostring_imp,
        -- 运算符重载
        _add_imp = add_imp,
        _sub_imp = sub_imp,
        _mul_imp = mul_imp,
        _div_imp = div_imp,
        _mod_imp = mod_imp,
        _pow_imp = pow_imp,
        _unm_imp = unm_imp,
        _concat_imp = concat_imp,
        _len_imp = len_imp,
        _eq_imp = eq_imp,
        _lt_imp = lt_imp,
        _le_imp = le_imp,

        -- 新实例
        new = function (this, ...)
            local _newinstance = this:_new_imp();
            _newinstance:initialize(...);
            return _newinstance;
        end,
        -- 初始化
        initialize = function (this, ...)
        end,
        -- 获得对象名
        getName = function (this)
            return this.__name;
        end,

        -- 闭包函数
        -- 声明新类
        subclass = function (this, name, o)
            if type(name)~="string" then
                name = _unnamed.._unnamed_index;
                _unnamed_index = _unnamed_index+1;
            end
            local _instance = this:_new_imp(o);
            _instance.__name = this.__name.."."..name;
            _classes[_instance] = _instance;
            return _instance;
        end,
        -- 获得子类
        getClass = function (this, name)
            local classname = this.__name.."."..name;
            return this.getClassFromFullName(classname);
        end,
        -- 获得子类通过全名
        getClassFromFullName = function (name)
            for i, v in pairs(_classes) do
                if tostring(v)==name then
                    return v;
                end
            end
            return nil;
        end,
        -- 打印子类
        printSubclasses = function()
            for i, v in pairs(_classes) do
                print(i);
            end
        end,
    };

    if type(o)=="table" then
        -- 添加(或者替换)数据到object中
        for i, v in pairs(o) do
            object[i]=v;
        end
    end

    -- 设置元数据
    init_metatable(object);
    -- 登记子类表
    _classes[object] = object;
    -- 登记基表
    _baselist[name] = object;

    return object;
end

--新类的声明方法
-- o:新类的基础数据表
function class(name, parent, o)
	return parent:subclass(name, o);
end

--声明Object基类
local Object = baseclass("Object");

-- 获得基类
function getBaseclass(name)
    return _baselist[name];
end

-- 打印基类名
function printBaseclasses()
    local names={};
    for i, _ in pairs(_baselist) do
        print(i);
    end
end

-- 通过类全名找到类
function getClass(name, baseclass)
    local base = baseclass or Object;
	return base.getClassFromFullName(name);
end
