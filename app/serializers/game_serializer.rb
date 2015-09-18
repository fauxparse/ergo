class GameSerializer < ActiveModel::Serializer
  attributes :id, :round

  has_many :players

  def id
    object.to_param
  end

  def round
    round = object.rounds.last
    round && ActiveModel::SerializableResource.new(round).as_json
  end
end
