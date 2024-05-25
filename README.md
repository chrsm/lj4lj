lj4lj
===

**NOTE: this is a work in progress as of 2024-05-25**

`lj4lj` is an FFI wrapper for luajit's API, written in [Yue][1].

This allows code to create and interact with `lua_State`s.


API
===

`lj4lj` offers two ways to interact with the Lua API. The first mechanism is through
the bare `Lua` type, which is mostly a direct transformation of `luajit/src/lj_api.c`.
The second is the `SimpleLua` type. `SimpleLua` is an opinionated wrapper around
the standard APIs and doesn't require much knowledge of the Lua API itself.

## `Lua`

The `Lua` type is mostly a direct transformation of `luajit/src/lj_api.c`.
Construction of a new instance calls `luaL_newstate`, so even if you do not
use it, you should close it.

_How the Lua API actually works is not documented here. Please read Lua's documentation
if you plan on using this wrapper._

Example use:

```lua
s = Lua()
s:openlibs()

s:pushstring('TEST_GLOBAL_VALUE')
s:setglobal('_TEST_GLOBAL')

s:loadstring('print(_TEST_GLOBAL)')
s:pcall()

s:close()
```

### Methods 

State
- `Lua:close()`
- `Lua:pcall()`
- `Lua:openlibs()`
- `Lua:loadstring()`
- `Lua:setfield(idx, name)`
- `Lua:getfield(idx, name)`
- `Lua:setglobal(name)`
- `Lua:getglobal(name)`

Stack setters
- `Lua:pushnil()`
- `Lua:pushnumber(num)`
- `Lua:pushinteger(num)`
- `Lua:pushlstring(str, len)`
- `Lua:pushstring(str)`
- `Lua:pushcclosure(fn, nargs)`
- `Lua:pushcfunction(fn)`
- `Lua:pushboolean(b)`
- `Lua:pushlightuserdata(ud)`
- `Lua:pushthread()`

Unimplemented stack setters:
- `pushvfstring`
- `pushfstring`

Stack getters
- `Lua:checktype(idx, typ)`
- `Lua:checkany(idx)`
- `Lua:typename(t)`
- `Lua:iscfunction(idx)`
- `Lua:isnumber(idx)`
- `Lua:isstring(idx)`
- `Lua:isuserdata(idx)`
- `Lua:checkinteger(idx)`
- `Lua:checklstring(idx, len)`
- `Lua:checkudata(idx, tname)`
- `Lua:checkoption(idx, def, lst)`


Contributing
===

- **don't be an ass**
- use [yue][1]
- write decent commit messages


[1]: https://github.com/pigpigyyy/Yuescript
