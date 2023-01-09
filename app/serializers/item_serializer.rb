# frozen_string_literal: true

class ItemSerializer
  include JSONAPI::Serializer
  attributes :title
end
