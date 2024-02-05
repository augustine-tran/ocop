# frozen_string_literal: true

class Person < ApplicationRecord
  belongs_to :account

  delegated_type :personable, types: Personable::TYPES

  delegate :name, :email, :role, to: :personable

  delegate :can?, :cannot?, to: :ability

  has_one :council_member, dependent: :destroy

  has_many :accounts, through: :council_members

  has_many :assessments, foreign_key: :judge_id, dependent: :destroy, inverse_of: :judge

  has_many :panel_assessments, lambda {
                                 where assessable_type: 'PanelAssessment'
                               }, class_name: 'Assessment', dependent: :destroy, foreign_key: :judge_id

  has_many :final_assessments, -> { where assessable_type: 'FinalAssessment' }, through: :assessments

  enum role: {
    admin: 'admin',
    user: 'user'
  }

  def ability
    @ability ||= Ability.new(self)
  end

  def president?
    self == Current.account.president
  end
end
