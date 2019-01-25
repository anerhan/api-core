# ApiCore
## Requirements:
```
ruby ~> 2.6.0
warden
jwt
rails ~> 5.2.2
i18n
waterdrop
ruby-kafka ~> 0.6.8
elasticsearch-rails
elasticsearch-model
```

## Installation

- **Add this line to your application's Gemfile:**

```ruby
gem 'api-core', github: 'anerhan/api-core', tag: 'v0.0.1'
```

- **And then execute:**

    $ bundle

### Configure on Rails App side

- **Add to config/initializers/api_core.rb in Your Rails 5.2.2 Application:**
```ruby
# INFO: Configure ApiCore
ApiCore.configure do |config|
  config.app_name = 'catalog-api'
  config.supported_versions = %w[v1]
end

Rails.application.configure do
  # INFO: Apply configs from ApiCore
  config.time_zone = ApiCore.config.time_zone
  config.i18n.available_locales = ApiCore.config.available_locales
  config.i18n.default_locale = ApiCore.config.default_locale #:en
  config.encoding = ApiCore.config.encoding

  # INFO: Apply Middlewares and Warden strategirs from ApiCore
  config.middleware.use ApiCore::Middlewares::Localize

  config.middleware.use ApiCore::Warden::Manager do |manager|
    manager.strategies.add :jwt_auth, ApiCore::Warden::Strategies::JwtAuth
    manager.default_strategies %i[jwt_auth], scope: :default
    manager.failure_app = ApiCore::Middlewares::FailureApp
  end
end
```

- **Modify app/controllers/application_controller.rb:**
```ruby
class ApplicationController < ActionController::API
  include ApiCore::AuthHelper
  include ApiCore::ErrorHelper
end
```

### Usage
- **In Any controller already available methods 'authenticate_user!, current_user, warden, signed_in?':**
```ruby
class ImportsController < ApplicationController
  prepend_before_action :authenticate_user!

  def index
    render json: { imports: [] }
  end
end
```

### Use EventBus for produce events to Kafka
- **Async broadcast event:**
```ruby
ApiCore::EventBus::Client.async_broadcast(payload, topic: 'streaming.customer')
```

- **Sync broadcast event:**
```ruby
ApiCore::EventBus::Client.broadcast(payload, , topic: 'streaming.customer')
```

### Default root path return API Info:
```ruby
{
  info: {
    name: 'catalog-api',
    organization: 'UMICO inc.',
    versions: [
      'v1'
    ],
    time_zone: 'Baku',
    encoding: 'utf-8',
    delivered_at: 'Thu Jan 24 15:12:45 2019'
  }
}
```

### Exceptions to Json response:
- **ActiveRecord::RecordNotFound return:**
```ruby
{ 
  error: { 
    message: 'Record not found', 
    code: 404 
  }
}
```

- **Routing errors return:**
```ruby
{ 
  error: { 
    message: 'Page not found', 
    code: 404 
  }
}
```

- **Exception (500) Internal server errors return:**

```ruby
# Development:
{ 
  error: { 
    message: 'full error message', 
    code: 500 
  } 
}

# Production:
{ 
  error: { 
    message: 'Service temporary unavailable', 
    code: 500 
  } 
}
```
