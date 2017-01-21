# Helpers for request specs
module RequestHelpers
  # Helpers for JSON data type
  module JsonHelpers
    def json
      @json ||= JSON.parse(response.body)
    end
  end
end