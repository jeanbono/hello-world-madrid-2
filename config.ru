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
          :name => 'Test',
          :description => 'This is an opportunity',
          :amount => 123,
          :stagename => 'Won',
          :closedate => '2015-10-11'
        })
        {:success => opp.save}
      end
    end
  end

  class Opportunity < ActiveRecord::Base
    self.table_name = 'salesforce.opportunity'
  end
end

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])

use ActiveRecord::ConnectionAdapters::ConnectionManagement

run MyApp::API
