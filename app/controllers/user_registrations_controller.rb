# frozen_string_literal: true
require 'pry'
class UserRegistrationsController < Devise::RegistrationsController
  before_action :check_permissions, only: [:edit, :update]
  
  skip_before_action :verify_authenticity_token, only: :create
  def create
    build_resource(spree_user_params)
  
    # if resource.save
    #   binding.pry
    #   set_flash_message(:notice, :signed_up)
    #   sign_in(:spree_user, resource)
    #   session[:spree_user_signup] = true
     
    #   render json: {
    #     status: {code: 200, message: 'Logged in sucessfully.'},
    #     data: SpreeUserSerializer.new(resource).serializable_hash[:data][:attributes]
    #   }, status: :ok
    if resource.save
      # sign_in(:spree_user, resource)
      session[:spree_user_signup] = true
      render json: {
        status: {code: 402, message: 'please confirm verification link sent to registered email.'},
        data: SpreeUserSerializer.new(resource).serializable_hash[:data][:attributes]
      }
    else
      clean_up_passwords(resource)
      respond_with(resource) do |format|
        format.html { render :new }
      end
    end
  end

  protected

  def translation_scope
    'devise.user_registrations'
  end

  def check_permissions
    authorize!(:create, resource)
  end

  private

  def spree_user_params
    params.require(:spree_user).permit(Spree::PermittedAttributes.user_attributes | [:email,:user_name,:password])
  end
end
