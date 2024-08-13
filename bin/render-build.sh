set -o errexit

bundle install
bundle exec rake assets:clean
bundle exec rake db:migrate
