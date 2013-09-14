#
# Be sure to run `pod spec lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://docs.cocoapods.org/specification.html
#
Pod::Spec.new do |s|
  s.name         = "APIClient"
  s.version      = "0.1.0"
  s.summary      = "A short description of APIClient."
  s.description  = <<-DESC
                    An optional longer description of APIClient

                    * Markdown format.
                    * Don't worry about the indent, we strip it!
                   DESC
  s.homepage     = "http://EXAMPLE/NAME"
  s.license      = 'MIT'
  s.author       = { "Klaas Pieter Annema" => "klaaspieter@annema.me" }
  s.source       = { :git => "http://EXAMPLE/NAME.git", :tag => s.version.to_s }

  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'Classes'

  s.dependency 'AFNetworking', '~> 1.3'
  s.dependency "InflectorKit'"
end
