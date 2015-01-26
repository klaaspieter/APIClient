Pod::Spec.new do |s|
  s.name         = "APIClient"
  s.version      = "0.1.1"
  s.summary      = "Convention over configuration REST API client"
  s.homepage     = "https://github.com/klaaspieter/apiclient"
  s.license      = 'MIT'
  s.author       = { "Klaas Pieter Annema" => "klaaspieter@annema.me" }
  s.source       = { :git => "https://github.com/klaaspieter/APIClient.git", :tag => s.version.to_s }

  s.platform     = :ios, "6.0"
  s.requires_arc = true

  s.source_files = "Classes"

  s.frameworks = "MobileCoreServices", "SystemConfiguration"

  s.dependency "AFNetworking", "~> 2.5"
  s.dependency "InflectorKit", "= 0.0.1"
  s.dependency "DCKeyValueObjectMapping", "~> 1.4"

end
