class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar, :goal, :position, :ready

  delegate :user, :goal, to: :object
  delegate :name, :avatar, to: :user
end
