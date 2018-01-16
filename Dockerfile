FROM ruby:2.5

ADD blog/ /opt/blog/

ENV JEKYLL_VERSION 3.7.0

EXPOSE 4000

RUN gem install jekyll -v $JEKYLL_VERSION
RUN cd /opt/blog \
    && bundle install

WORKDIR /opt/blog
CMD ["bundle", "exec", "jekyll", "serve", "-H", "0.0.0.0"]

