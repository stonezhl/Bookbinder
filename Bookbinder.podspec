Pod::Spec.new do |spec|
  spec.name = "Bookbinder"
  spec.version = "1.0.0"
  spec.summary = "A Swift ePub parser framework for iOS."
  spec.homepage = "https://github.com/stonezhl/Bookbinder"
  spec.license = { type: "MIT", file: "LICENSE" }
  spec.authors = { "Stone Zhang" => "stnzhl@gmail.com" }
  spec.social_media_url = "https://twitter.com/stonezhl1"

  spec.swift_version = "5.0"
  spec.ios.deployment_target = "12.2"
  spec.source = { git: "https://github.com/stonezhl/Bookbinder.git", tag: "#{spec.version}" }
  spec.source_files = "Bookbinder/**/*.{h,swift}"
  spec.requires_arc = true
  spec.pod_target_xcconfig = {
    "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2"
  }

  spec.dependency "Kanna", "~> 5.0.0"
  spec.dependency "ZIPFoundation", "~> 0.9"
end