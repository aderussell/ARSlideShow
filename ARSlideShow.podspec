#
#  Be sure to run `pod spec lint ARSlideShow.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "ARSlideShow"
  s.version      = "1.0.0"
  s.summary      = "An animating image slide show for iOS."
  s.description  = "An animating image slide show for iOS."

  s.homepage     = "https://github.com/aderussell/ARSlideShow"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = "MIT"

  s.author             = { "aderussell" => "adrianrussell@me.com" }
  s.social_media_url   = "http://twitter.com/ade177"

  s.platform     = :ios, "9.0"
  s.requires_arc = true

  s.source       = { :git => "https://github.com/aderussell/ARSlideShow.git", :tag => s.version.to_s }

  s.source_files  = "ARSlideShow/*"
  # s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"



  s.frameworks = "UIKit", "MediaPlayer"

end
