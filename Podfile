inhibit_all_warnings!

pod "AFNetworking", "~> 2.2.1"
pod "InflectorKit"
pod "DCKeyValueObjectMapping"

target "Specs", exclusive: true do
  pod "Specta"
  pod "Expecta"
  pod "OCMock"
end

target "IntegrationSpecs" do
  pod "Specta"
  pod "Expecta"
  pod "Barista"
end

target "Example", exclusive: true do
  xcodeproj "Example/Example.xcodeproj"
  workspace "Example/Example.xcworkspace"
  pod "APIClient", path: "./"
end
