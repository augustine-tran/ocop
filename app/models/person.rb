# frozen_string_literal: true

require 'letter_avatar/has_avatar'

class Person < ApplicationRecord
  include LetterAvatar::HasAvatar

  belongs_to :account

  delegated_type :personable, types: Personable::TYPES

  delegate :name, :email, :department, :role, to: :personable

  delegate :can?, :cannot?, to: :ability

  has_many :council_members, dependent: :destroy

  has_many :assessments, foreign_key: :judge_id, dependent: :destroy, inverse_of: :judge

  has_many :panel_assessments, lambda {
                                 where assessable_type: 'PanelAssessment'
                               }, class_name: 'Assessment', dependent: :destroy, foreign_key: :judge_id

  has_many :panel_submissions, through: :panel_assessments, source: :submission

  has_many :final_assessments, lambda {
                                 where assessable_type: 'FinalAssessment'
                               }, class_name: 'Assessment', dependent: :destroy, foreign_key: :judge_id

  has_many :final_submissions, through: :final_assessments, source: :submission

  has_many :push_subscriptions, class_name: 'Push::Subscription', dependent: :delete_all

  enum role: {
    admin: 'admin',
    user: 'user'
  }

  def ability
    @ability ||= Ability.new(self)
  end

  def president?
    council_members.president.count.positive?
  end
end
