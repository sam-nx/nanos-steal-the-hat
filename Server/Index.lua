local tFiles = Package.GetFiles("Server/modules/", ".lua")

for _, sFile in pairs(tFiles) do
    Package.Require(sFile)
end
