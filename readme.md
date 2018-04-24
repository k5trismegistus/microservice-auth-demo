# 起動方法

auth-server以下のアプリをポート3000、auth-client以下のアプリをポート3001で起動します

```
localhost:3000/users/new
```

にアクセスしユーザー登録、

```
localhost:3000/login
```

でログインできます。

ログインしている状態で

```
localhost:3001
```

にアクセスすると、auth-clientがセッション情報をauth-serverに送信しログインユーザー情報を取得します。
