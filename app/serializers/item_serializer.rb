# frozen_string_literal: true

class ItemSerializer
  include JSONAPI::Serializer
  attributes :title, :list_id
end
