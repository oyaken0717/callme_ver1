# README  
# 要件定義  
# 概要  
仕事のノウハウを蓄積してわからない時に使えるようにするアプリ  
# コンセプト  
「これ見てやって」の「これ」をネットで共有する。
# バージョン  
Ruby 2.5.3p105  
Ruby on Rails  5.1.6.1  
psql (PostgreSQL) 11.2  
# 機能一覧  
ログイン機能  
ユーザー登録機能  
メールアドレス、名前、パスワードは必須  
パスワード再設定機能  
仕事一覧表示機能  
お気に入り一覧表示  
仕事投稿機能  
仕事名と仕事内容は必須  
仕事編集機能  
仕事削除機能  
仕事編集と仕事削除は投稿者のみ実行可能  
仕事お気に入り機能  
タグ投稿機能  
タグ削除機能  
# カタログ設計  
<https://docs.google.com/spreadsheets/d/1VLm0Xd-GjCxJ2D1lQsZ1Kt3HnG4hkJFJ5fLYwR07RBg/edit#gid=0>
# テーブル定義  
<https://docs.google.com/spreadsheets/d/1VLm0Xd-GjCxJ2D1lQsZ1Kt3HnG4hkJFJ5fLYwR07RBg/edit#gid=1531966666>
　「Category」というモデルに関しては、PostモデルとTagモデルを多対多の関係で結合する役割とだけ今回は考えています。
# ER図  
<https://docs.google.com/spreadsheets/d/1VLm0Xd-GjCxJ2D1lQsZ1Kt3HnG4hkJFJ5fLYwR07RBg/edit#gid=1085121477>
# 画面遷移図  
<https://docs.google.com/spreadsheets/d/1VLm0Xd-GjCxJ2D1lQsZ1Kt3HnG4hkJFJ5fLYwR07RBg/edit#gid=1092797406>
# ワイヤーフレーム  
<https://docs.google.com/spreadsheets/d/1VLm0Xd-GjCxJ2D1lQsZ1Kt3HnG4hkJFJ5fLYwR07RBg/edit#gid=253675371>
# 使用予定Gem  
carrierwave
mini_magick
# 就業ターム  
①コメント機能  
②メッセージ機能  
# 就業ターム以外
グループ機能
(詳細はカタログ設定の機能一覧に記載)
