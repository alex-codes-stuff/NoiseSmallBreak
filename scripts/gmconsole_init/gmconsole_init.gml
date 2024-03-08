#macro gmc obj_gmconsole // Shortcut to obj_gmconsole for the lazy people out there (you're just like me)
#macro obj_console obj_gmconsole // Versions >0.3.00.00 had GMConsole's object named as "obj_console", this is for backwards compatibility, please use `obj_gmconsole`, or `gmc` in your code.

/// @pure
/// @returns {Bool}
function is_debug()
{
	return instance_number(obj_gmconsole) >= 1 ? !obj_gmconsole.con.build.release : (GM_build_type == "run");
}

/// @description 1 = test, 2 = release (vm), 3 = compiled (yyc)
/// @returns {Real}
/// @self undefined
/// @pure
function get_compile_type()
{
	return (is_debug() ? 1 : (code_is_compiled() ? 3 : 2))
}

/// @param {Real} in
/// @returns {String}
/// @self undefined
/// @pure
function compile_type_tostring(in)
{
	var _compile_type = "";
	switch (get_compile_type())
	{
		case 1:
			_compile_type = "TEST BUILD";
		break;
		case 2:
			_compile_type = "RELEASE/VM BUILD";
		break;
		case 3:
			_compile_type = "COMPILED/YYC BUILD";
		break;
		default:
			_compile_type = "how did you mess up so badly gm doesnt even know if this is a release build";
		break;
	}
	return _compile_type;
}

/// @param		{String}	_cver
/// @returns	{Bool}
function con_is_stable(_cver)
{
	if (string_ends_with(con.version, "-dev")) { return false; }
	for (var i = 0; i < 10; i++) { if (string_ends_with(con.version, $"-rc{i}")) { return false; } }
	return true;
}