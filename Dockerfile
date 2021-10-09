# Include Ruby Image
FROM ruby:2.7.4

# Put all files in a dir called /code
WORKDIR /code
COPY . /code

# Install dependecies
RUN bundle install

# Listen to port 4567
EXPOSE 4567

# Tell docker that when we run "docker run", we want to run:
# bundle exec rackup --host 0.0.0.0 -p 4567
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "4567"]

