# イベンチャー
<img width="1465" alt="スクリーンショット 2023-03-28 午後5 28 45" src="https://user-images.githubusercontent.com/120545081/228177870-fef7a407-a83a-45ff-9167-02a840c5ba40.png">
<img width="1000" alt="スクリーンショット 2023-03-28 午後5 31 40" src="https://user-images.githubusercontent.com/120545081/228178419-f5b4ae1b-df41-410f-a60c-bdc04f35af48.png">
<img width="1000" alt="スクリーンショット 2023-03-28 午後5 32 02" src="https://user-images.githubusercontent.com/120545081/228178858-18d90f5c-dac1-48f3-ae0b-09c9a23debb6.png">
<img width="1000" alt="スクリーンショット 2023-03-28 午後6 10 55" src="https://user-images.githubusercontent.com/120545081/228188204-07b8a9ad-36ad-4e3a-8376-c2f19234f2fc.png">

## サイト概要
### サイトテーマ
イベントの情報を共有することを目的としたコミュニティサイトです。

### テーマを選んだ理由
コロナが収束に近づき、人が集まる機会が増えてきました。
イベントに関する情報を一元管理することで、参加したいイベントの発見から管理、スムーズなイベントの運営や集客が可能になります。
また、オンラインでのイベントが増加しています。イベント情報共有アプリケーションは、オンラインイベントにおいても利用することができ、
イベントの参加者同士が簡単にコミュニケーションを取ることができます。
今後増えていくイベント情報を共有できるアプリケーションに需要があると思いこのテーマを選びました。

### ターゲットユーザ
* イベント企画者
* イベント参加者
* アウトゴーイングな人

### 主な利用シーン
* イベントを開催する時
* イベントの参加者でコミュニティを作りたい時
* 興味のあることのイベント情報を探したい時

## 簡単な説明
* サイトはユーザーと管理者の分かれています。
* 管理者側は、設定したメールアドレスとパスワードでログインすると、「ユーザー」「投稿」「コメント」の管理を行うことができます。
* ユーザーは新規登録、またはログインを行うことでサイトを利用することができます。
* ポートフォリオ用のゲストログインを採用しています。ゲストログインを行なっても全ての機能が利用可能です。

* ユーザーはイベント情報の投稿ができます。
* ユーザーはそれぞれの投稿にコメントができ、ブックマーク登録ができます。
* ユーザーは投稿に紐づいたグループを作成できます。
* グループに参加することでグループチャットが利用できます。

* 投稿名で投稿を検索することができます。
* 投稿に紐づいたタグで絞り込み検索ができます。

## 設計書
+ [ER図](https://drive.google.com/file/d/14NtLXH_LQxv_2KPYQE6knPBHOzUcYJ_P/view?usp=sharing)
+ [テーブル定義書](https://docs.google.com/spreadsheets/d/1Y8b3pgDbWsiRyHGEpR--TOvPyClFGpDh/edit?usp=sharing&ouid=101339252281227293277&rtpof=true&sd=true)
+ [アプリケーション詳細設計書](https://docs.google.com/spreadsheets/d/1ugvtc1d12rCv7gLYcyOGk87xVi9ddwtd_g55OrwVNYM/edit?usp=sharing)

## 開発環境
+ Ruby 3.1.2
+ Ruby on Rails 6.1.7.2

### 使用したGemと機能
+ devise
+ devise-i18n
+ kaminari
+ bootstrap
+ FontAwesome (yarn)