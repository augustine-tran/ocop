# frozen_string_literal: true

module AccountScoped
  extend ActiveSupport::Concern

  included do
    belongs_to :account
    default_scope { where account: Current.account }

    before_validation :set_account
  end

  private

  def set_account
    self.account = Current.account
  end
end
