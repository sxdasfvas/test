repeat wait() until game:IsLoaded()
settings().Rendering.QualityLevel = 1
game:GetService"RunService":Set3dRenderingEnabled(false)

script_key="LuGUCmltYxloNlDGQRWhJFUyQaemilHk";
if game.PlaceId == 6284583030 then
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/4d2476afae4cd2186c3449b71d52cfc5.lua"))()
else
wait(10)
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/32cbc6585ae03eab4af8c8cfcf0ef75a.lua"))()
end
