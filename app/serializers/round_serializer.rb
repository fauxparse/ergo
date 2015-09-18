class RoundSerializer < ActiveModel::Serializer
  attributes :number, :hands

  def number
    object.position + 1
  end

  def hands
    object.hands.each.with_object({}) do |hand, hash|
      hash[hand.player_id] = ActiveModel::SerializableResource.new(hand).as_json
    end
  end
end
