repeat task.wait() until game:IsLoaded()
task.wait()

script_key="LuGUCmltYxloNlDGQRWhJFUyQaemilHk";
if game.PlaceId == 6284583030 then
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/4d2476afae4cd2186c3449b71d52cfc5.lua"))()
else
wait(10)
loadstring(game:HttpGet("https://raw.githubusercontent.com/ThanhTuoi852123/bugfestivebean/main/checkram.lua"))()
end
