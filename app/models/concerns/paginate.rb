module Paginate
  extend ActiveSupport::Concern

  included do
    def self.paginate(page, per_page)
      self.limit(per_page).offset(page * per_page)
    end
  end
end