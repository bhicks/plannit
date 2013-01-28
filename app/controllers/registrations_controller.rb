class RegistrationsController < Devise::RegistrationsController
  before_filter :signed_in_user
# before_filter :correct_user, [:edit, :update, :destroy]

#  private
#    def correct_user
#      if params[:id] != current_user.id
#        flash[:error] = 'Users must edit their own profiles'
#        logger.debug "Illegal user access from user #{current_user.id} to user #{params[:id]}"
#        redirect_to root_path
#      end
#    end
end
