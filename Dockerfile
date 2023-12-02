# Use the official Ruby image with version 3.x
FROM ruby:3.0.0

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Install gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.2.29 && bundle install

# Copy the application code into the container
COPY . .

# Expose port 3000 to the outside world
EXPOSE 3000

# Entrypoint script to handle process initialization
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Start the Rails application
CMD ["rails", "server", "-b", "0.0.0.0"]
