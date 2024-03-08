/// @description Check for updates

if (async_load[? "id"] == con.github.get_req.req)
{
	con_log(con.enums.logtype.debug, $"Received HTTP status {async_load[? "http_status"]} for checking updates: {async_load[? "result"]}\nQueried: {async_load[? "url"]}");
	if (async_load[? "status"] == 0 && async_load[? "http_status"] == 200)
	{
		// The old format was MAJOR.VERSION.MINOR or simply MAJOR.VERSION
		// as of 0.3.00.00, the format is MAJOR.VERSION.MINOR.HOTFIX(.DEV/RC[1-9])
		con.latest_version = string_replace_all(string_replace_all(async_load[? "result"], "\n", ""), " ", ""); // X.X.XX.XX(.DEV/RC[1-9])
		con.outdated = (con.version == con.latest_version ? con.enums.outdated.no : con.enums.outdated.yes);
		con.github.get_req.req = undefined;
	}
	else
	{
		con.outdated = con.enums.outdated.unknown;
	}
}
