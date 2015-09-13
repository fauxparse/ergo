Dir[File.dirname(__FILE__) + "/helpers/**/*"].each { |f| require f }

World(
  FeatureSupport::GameplayHelper
)
