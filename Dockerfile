# Use an official Ruby runtime as a parent image
FROM ruby:3.0.0

# Install Dependencies
RUN apt-get update \
    && apt-get install -qq -y build-essential xvfb xdg-utils wget ffmpeg libpq-dev vim libmagick++-dev fonts-liberation sox bc --no-install-recommends\
    && apt-get clean

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# copy the entrypoint script
COPY entrypoint.sh /usr/bin/
RUN chmod 755 /usr/bin/entrypoint.sh
# Install bundle and gems
RUN gem install bundler && bundle install

# Copy the current directory contents into the container
COPY . .

# Run the entrypoint script
ENTRYPOINT ["entrypoint.sh"]

# Expose port 3000 to the outside world
EXPOSE 3000

# Start the Rails application
CMD ["rails", "server", "-b", "0.0.0.0"]
