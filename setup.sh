#!/bin/bash

# artifacts repositoriesの作成
gcloud artifacts repositories create docker-repo \
    --repository-format docker \
    --location asia-northeast1 \
    --description "Docker repository"

# 認証情報を付与
gcloud auth configure-docker asia-northeast1-docker.pkg.dev

# Cloud Build でビルド
gcloud builds submit
    --region asia-northeast1 \
    --config cloudbuild.yaml

# docker imageを実行
docker run asia-northeast1-docker.pkg.dev/{YOUR_PROJECT}/docker-repo/hello-image:v1.0.0

# イメージを一覧表示
gcloud artifacts docker images list asia-northeast1-docker.pkg.dev/{YOUR_PROJECT}/docker-repo/hello-image
