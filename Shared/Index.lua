local tFiles = Package.GetFiles("Shared/modules/", ".lua")

for _, sFile in pairs(tFiles) do
    Package.Require(sFile)
end