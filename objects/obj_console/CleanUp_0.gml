/// @description Remove screenshot

if (sprite_exists(con.screenshot)) { sprite_delete(con.screenshot); }
__show_debug_message_base("Console cleaned up");