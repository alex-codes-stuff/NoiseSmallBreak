/// @description Insert description here
// You can write your code in this editor
levelid = "123"

link = http_get("https://www.googleapis.com/drive/v3/files/" + levelid + "?alt=media&key=AIzaSyBY9VVeA53pcdt0Nofa6VItE2K5r1gH9Zs")

response = ""

buffer =  buffer_create(1024 , buffer_grow, 1);



