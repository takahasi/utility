#!/bin/sh

readonly PROJECT=hogehoge
readonly TOKEN=abcdefgh
readonly EMAIL=hoge@hoge.com

function clean_workspace()
{
  rm -rf coverity_tool.tgz cov-analysis* $PROJECT
}

function download_tool()
{
  wget https://scan.coverity.com/download/linux64 --post-data "token=$TOKEN&project=$PROJECT" -O coverity_tool.tgz
  tar xzf coverity_tool.tgz
}

function download_source()
{
  # download source code
}

function build_source()
{
  # pre-build source code
}

function build_coverity()
{
  ( \
    cd $PROJECT && \
    ./../cov-analysis*/bin/cov-build --dir cov-int make -j && \
    tar czf $PROJECT.tgz cov-int \
  )
}

function upload_results()
{
  readonly DATE=`date +%Y%m%d`
  readonly DESCRIPTION="hogehoge"

  curl --form token=$TOKEN \
      --form email=$EMAIL \
      --form file=@$PROJECT/$PROJECT.tgz \
      --form version="$DATE" \
      --form description="$DESCRIPTION" \
      https://scan.coverity.com/builds?project=$PROJECT
}

clean_workspace
download_tool
download_source
build_source
build_coverity
upload_results
