#!/bin/sh

lua_path_file="./Lua/include/luaModsPath.lua"
rm $lua_path_file
for directory in $(find "$PWD" -type d | grep "media/lua/") ; do
    win_dir=$(echo "$directory" | sed -E 's/\/([A-Za-z])/\1:/')
    echo "package.path = \"${win_dir}/?.lua;\" .. package.path" >> "${lua_path_file}"
done
