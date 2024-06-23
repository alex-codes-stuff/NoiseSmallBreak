/// @description Insert description here
// You can write your code in this editor
if (ds_map_find_value(async_load, "id") == latestchangelog)
{
    if (ds_map_find_value(async_load, "status") == 0)
    {
        changelog = ds_map_find_value(async_load, "result");
    }
    else
    {
        changelog = "Could not get latest changelog. Check your WI-FI connection.";
    }
}

