class ProfilesController < ApplicationController

    # GET to /users/:user_id/profile/new
    def new
        # Render blank profile details from 
        @profile = Profile.new
    end
end