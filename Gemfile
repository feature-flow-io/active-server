source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.1"

gem "bootsnap", ">= 1.4.4", require: false
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.4"
# gem "redis", "~> 4.0"
# gem "bcrypt", "~> 3.1.7"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem "rack-cors"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "rubocop", "~> 1.15"
  gem "rubocop-rails", "~> 2.10", ">= 2.10.1"
  gem "rubocop-rspec", "~> 2.3"
end

group :development do
  gem "listen", "~> 3.3"
  gem "spring"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
