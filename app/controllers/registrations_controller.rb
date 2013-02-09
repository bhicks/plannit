class RegistrationsController < Devise::RegistrationsController
  before_filter :signed_in_user, only: [:edit, :update, :destroy]
end
