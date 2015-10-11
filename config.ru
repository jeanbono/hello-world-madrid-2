require 'grape'
require 'active_record'

module MyApp
  class API < Grape::API
    version 'v1', using: :header, vendor: 'myapp'
    format :json
    prefix :api

    desc 'Hello World'
    get :hello do
      {:hello => 'World'}
    end

    resource :opportunities do
      post do
        opp = MyApp::Opportunity.new({
          :Name => 'Test',
          :Description => 'This is an opportunity',
          :Amount => 123
        })
        {:success => opp.save}
      end
    end
  end

  class Opportunity < ActiveRecord::Base
    set_table_name 'salesforce.Opportunity'
  end
end

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])

use ActiveRecord::ConnectionAdapters::ConnectionManagement

run MyApp::API
