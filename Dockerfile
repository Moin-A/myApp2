# Stage 1: Backend build
FROM ruby:3.1.2 
# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    default-libmysqlclient-dev \
    nodejs \
    yarn
WORKDIR /app
RUN ls
COPY Gemfile  ./
RUN gem install bundler -v '~> 2.2' && bundle install --path=.bundle
COPY / ./
EXPOSE 3000






