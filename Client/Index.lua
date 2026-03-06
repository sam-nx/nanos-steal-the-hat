local tFiles = Package.GetFiles("Client/modules/", ".lua")

for _, sFile in pairs(tFiles) do
    Package.Require(sFile)
end