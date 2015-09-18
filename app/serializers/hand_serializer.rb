class HandSerializer < ActiveModel::Serializer
  attributes :player_id, :cards

  def cards
    object.cards.map(&:to_sym)
  end
end
