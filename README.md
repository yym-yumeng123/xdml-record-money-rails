# README

### 启动项目

```
rails new xdml-record-money --database=postgresql --skip-action-mailbox --skip-action-text --skip-sprockets --skip-javascript --skip-turbolinks --skip-system-test --skip-test --skip-webpack-install --api
```

### 连接数据库

```
docker run -v xdml-record-money-data:/var/lib/postgresql/data -p 5001:5432 -e POSTGRES_USER=yym -e POSTGRES_PASSWORD=123456 -d postgres:12.2
```

### 测试 RSpec

```rb
# 生成命令
bundle binstubs rspec-core

# 使用命令
bin/rspec
```


### 生成文档

```rb
bin/rake docs:generate
```