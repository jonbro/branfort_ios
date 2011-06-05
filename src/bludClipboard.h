// a minimal interface to the iphones clipboard

#pragma once

class bludClipboard{
public:
	static const char className[];
	static Lunar<bludClipboard>::RegType methods[];
	UIPasteboard *pasteboard;
	bludClipboard(lua_State *L) {
		pasteboard = [UIPasteboard generalPasteboard];
	}
	int set(lua_State *L){
		NSString *text = [[NSString alloc] initWithUTF8String:luaL_checkstring(L, 1)];
		[pasteboard setValue:text forPasteboardType:@"public.utf8-plain-text"];
		return 1;
	}
	int get(lua_State *L){
		if ([pasteboard containsPasteboardTypes: [NSArray arrayWithObject:@"public.utf8-plain-text"]])
		{
			lua_pushstring(L, [pasteboard.string cString]);
		}else{
			lua_pushnil(L);
		}
		return 1;
	}
	int setDefaults(lua_State *L){
		NSString *text = [[NSString alloc] initWithUTF8String:luaL_checkstring(L, 1)];
		[[NSUserDefaults standardUserDefaults] setObject:text forKey:@"bludDefaults"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		return 1;
	}
	int getDefaults(lua_State *L){
		NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
		NSString *text = [currentDefaults objectForKey:@"bludDefaults"];
		if (text != nil)
		{
			lua_pushstring(L, [text cString]);
		}else{
			lua_pushnil(L);
		}
		return 1;
	}
};
const char bludClipboard::className[] = "bludClipboard";
Lunar<bludClipboard>::RegType bludClipboard::methods[] = {
	method(bludClipboard, set),
	method(bludClipboard, get),
	method(bludClipboard, setDefaults),
	method(bludClipboard, getDefaults),
	{0,0}
};