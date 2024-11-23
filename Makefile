install:
	bundle install

lint:
	bundle exec rubocop

tests:
	bundle exec rake test

setup:
	cp .env.example .env

c:
	docker compose run --rm web bin/rails c
