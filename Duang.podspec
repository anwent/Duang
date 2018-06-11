Pod::Spec.new do |s|

  s.name         = "Duang"
  s.version      = "1.0.2"
  s.summary      = "Customizable PageMenu In Swift"

  s.description  = <<-DESC
	Quickly create a customizable PageMenu
                   DESC

  s.homepage     = "https://github.com/anwent/Duang"

  s.license      = 'MIT'

  s.author       = { "anwent" => "zhihaozhanggm@gmail.com" }

  s.source       = { :git => "https://github.com/anwent/Duang.git", :tag => s.version }

  s.source_files  = 'Classes/*.swift'
  s.requires_arc  = true
  s.ios.deployment_target = '8.0'
  s.framework     = 'UIKit' 
  s.swift_version = '4.0'

end
