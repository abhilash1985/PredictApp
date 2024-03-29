# frozen_string_literal: true

require "nested_form/engine"
require "nested_form/builder_mixin"

RailsAdmin.config do |config|
  # config.asset_source = :webpacker
  # config.asset_source = :sprockets # :webpacker

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)
  config.authenticate_with do |controller|
    unless current_user.try(:admin)
      flash[:error] = "You are not an admin"
      redirect_to main_app.root_path
    end
    # warden.authenticate! scope: :admin
  end

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model 'User' do
    object_label_method do
      :full_name
    end
  end

  config.model 'Match' do
    object_label_method do
      :full_name
    end
  end
end
