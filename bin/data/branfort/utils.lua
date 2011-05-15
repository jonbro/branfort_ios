function replace_char2(pos, str, r)
    return str:sub(1,pos-1) .. r .. str:sub(pos+1)
end
function lerp(start, stop, amt)
	return start + (stop-start) * amt;
end