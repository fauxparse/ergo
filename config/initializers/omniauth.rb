Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
    ENV['GOOGLE_CLIENT_ID'],
    ENV['GOOGLE_CLIENT_SECRET'],
    name: "google",
    prompt: "select_account",
    image_aspect_ratio: "square",
    image_size: 128
end
