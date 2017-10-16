do
    local major, minor = _VERSION:match("Lua (%d).(%d)")
    LUA_VERSION = major * 10 + minor
end

local t = require "u-test"

t.all_assertions = function ()
    t.equal(1,1)
    t.not_equal(1,2)
    t.almost_equal(1,3,2)
    t.is_false(false)
    t.is_true(true)
    t.is_not_nil(false)
    t.is_nil(nil)
    t.is_boolean(false)
    t.is_string("string")
    t.is_number(8)
    -- t.is_userdata(???)
    t.is_table({})
    t.is_function(function() end)
    t.is_thread(coroutine.create(function () end))
end

local function fail_all()
    t.equal(1,2, "Should be equal")
    t.not_equal(1,1, "Should not be equal")
    t.almost_equal(1,3,1.9, "This should be almost equal")
    t.is_false(true, "Should be false")
    t.is_true({}, "Should be true")
    t.is_not_nil(nil, "Shouldn't be nil")
    t.is_nil("nil", "Should be nil")
    t.is_boolean("booo", "Should be a boolean")
    t.is_string(1, "Should be a string")
    t.is_number(true, "Should be a number")
    t.is_userdata("no userdata", "Should be a userdata")
    t.is_table(nil, "Should be a table")
    t.is_function(coroutine.create(function () end), "Should be a function")
    t.is_thread(function() end, "Should be a thread")
end

t.all_assertions_failed = function ()
    fail_all()
end

t.param_root_test_p = function (a, b)
    t.equal(a,b)
end

t.param_root_test_p("Lua", "Lua")

t.case1.with_param_p = function (a, b, c)
    t.equal(a + b,  c)
end

t.case1.with_param_p(1,2,3)
t.case1.with_param_p(3,2,5)

t.case1.with_nil_p = function (i_am_nil)
    t.is_nil(i_am_nil)
end

t.case1.with_nil_p()

t.case1.fail_with_param_p = function (placeholder)
    fail_all()
end

t.case1.fail_with_param_p()

if LUA_VERSION > 51 then

    t.param_test = function (a, b)
        t.equal(a,b)
    end

    t.param_test(2, 2)

end -- Lua > 5.1

local ntests, nfailed = t.result()

t.tests_result = function()
    if LUA_VERSION > 51 then
        t.equal(ntests, 8)
        t.equal(nfailed, 2)
    else
        t.equal(ntests, 7)
        t.equal(nfailed, 2)
    end
end

t.summary()
