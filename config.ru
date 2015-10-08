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

    resource :posts do
      post do
        post = MyApp::Post.new({
          :title => 'Test',
          :body => 'This is a post'
        })
        {:success => post.save}
      end
    end
  end

  class Post < ActiveRecord::Base

  end
end

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])

use ActiveRecord::ConnectionAdapters::ConnectionManagement

run MyApp::API
