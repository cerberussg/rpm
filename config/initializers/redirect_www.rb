# Redirect www to non-www for SEO consistency
require Rails.root.join("lib", "rack", "host_redirect")

Rails.application.config.middleware.insert_before 0, Rack::HostRedirect,
  { "www.rubypythmore.com" => "rubypythmore.com" }
