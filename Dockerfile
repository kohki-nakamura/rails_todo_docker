# FROM：使用するイメージ、バージョン
FROM ruby:3.2.2
# 公式→https://hub.docker.com/_/ruby

# Rails 7ではWebpackerが標準では組み込まれなくなったので、yarnやnodejsのインストールが不要

# RUN：任意のコマンド実行
RUN mkdir /app

# WORKDIR：作業ディレクトリを指定
WORKDIR /app

# COPY：コピー元とコピー先を指定
# ローカルのGemfileをコンテナ内の/app/Gemfileに
COPY Gemfile /app/Gemfile

COPY Gemfile.lock /app/Gemfile.lock

RUN gem update --system
RUN bundle update --bundler

RUN bundle install

COPY . /app

# コンテナ起動時に実行させるスクリプトを追加
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# CMD:コンテナ実行時、デフォルトで実行したいコマンド
# Rails サーバ起動
CMD ["rails", "server", "-b", "0.0.0.0"]