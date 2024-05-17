RailsAdmin.config do |config|
  config.asset_source = :sprockets
  config.authenticate_with do
    unless current_user && current_user.has_role?(:admin)
      redirect_to main_app.root_path, alert: 'No estas autorizado para entrar a esta pagina.'
    end
  end

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

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
    exclude_fields :roles if defined?(Rolify)
    exclude_fields :messages
    exclude_fields :reports
  end

  config.model 'Event' do
    exclude_fields :roles
    exclude_fields :reviews

  end

  config.model 'Initiative' do
    exclude_fields :roles
    exclude_fields :requests
    exclude_fields :reports
    exclude_fields :messages
    exclude_fields :events
  end

end
