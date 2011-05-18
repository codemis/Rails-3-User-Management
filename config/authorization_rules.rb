# Declarative Authorization Rules
#
authorization do
  
  role :guest do
    has_permission_on :user_sessions, :to => [:create, :delete]
    has_permission_on :forgot_password, :to => [:create, :update]
  end
  
  role :member do
    includes :guest
    has_permission_on :dashboard, :to => :read
    has_permission_on :users, :to => [:show, :update] do
      if_attribute :id => is { user.id }
    end
  end
  
  role :administrator do
    includes :member
    has_permission_on :users, :to => :manage
    has_permission_on :users, :to => :delete do
      if_attribute :id => is_not { user.id }
    end
    has_permission_on :roles, :to => :manage
  end
  
end
privileges do
  # using the defaults from 
  # http://github.com/stffn/decl_auth_demo_app/blob/master/config/authorization_rules.rb
  # as a starting point
  privilege :manage, :includes => [:create, :update, :read]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end