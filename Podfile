inhibit_all_warnings!

pod "AFNetworking"
pod "InflectorKit"
pod "DCKeyValueObjectMapping"

target "Specs", exclusive: true do
  pod "Specta"
  pod "Expecta"
  pod "OCMock"
end

target "IntegrationSpecs", exclusive: true do
  pod "Specta"
  pod "Expecta"
  pod "GCDWebServer"
end

target "Example", exclusive: true do
  xcodeproj "Example/Example.xcodeproj"
  workspace "APIClient.xcworkspace"
  pod "APIClient", path: "./"
end
