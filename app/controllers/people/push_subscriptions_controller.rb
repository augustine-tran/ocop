# frozen_string_literal: true

class People::PushSubscriptionsController < ApplicationController
  before_action :set_push_subscriptions

  def index; end

  def create
    if (subscription = @push_subscriptions.find_by(push_subscription_params))
      subscription.touch # rubocop:disable Rails/SkipsModelValidations
    else
      @push_subscriptions.create! push_subscription_params.merge(user_agent: request.user_agent)
    end

    head :ok
  end

  def destroy
    @push_subscriptions.destroy_by(id: params[:id])
    redirect_to user_push_subscriptions_url
  end

  private

  def set_push_subscriptions
    @push_subscriptions = Current.person.push_subscriptions
  end

  def push_subscription_params
    params.require(:push_subscription).permit(:endpoint, :p256dh_key, :auth_key)
  end
end
