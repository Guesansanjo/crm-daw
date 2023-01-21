# frozen_string_literal: true

class ListSerializer
  include JSONAPI::Serializer
  attributes :title

  attribute :items do |object|
    ItemSerializer.new(object.items.order(position: :asc)).serializable_hash
  end
end
