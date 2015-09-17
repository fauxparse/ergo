class GameSerializer < ActiveModel::Serializer
  attributes :id
  
  has_many :players

  def id
    object.to_param
  end
end
