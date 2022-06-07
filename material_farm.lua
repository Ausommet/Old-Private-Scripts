while Wait() do
for i, v in pairs(workspace.Materials:GetChildren()) do
    pcall(function()game.ReplicatedStorage.ClaimMaterial:InvokeServer(v.Id.Value)end)
end
end