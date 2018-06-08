Pod::Spec.new do |s|

  s.name         = "Duang"
  s.version      = "1.0.0"
  s.summary      = "Customizable PageMenu In Swift"

  s.description  = <<-DESC
	Quickly create a customizable PageMenu
                   DESC

  s.homepage     = "https://github.com/anwent/Duang"

  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author       = { "anwent" => "zhihaozhanggm@gmail.com" }

  s.source       = { :git => "https://github.com/anwent/Duang.git", :tag => "1.0.0" }

  s.source_files  = "Classes/*.{swift}" 
  s.requires_arc  = true
  s.platform      = :ios, '8.0'
  s.framework     = 'UIKit' 
  s.swift_version = '4.0'

end
