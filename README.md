# Elm Favicon Clock

## これは何

favicon に分と秒を表示する時計のようなもの。

Google Chrome で、○時の favicon と、○分の favicon を両方タブ固定して使う。

## 使い方

下記 URL にアクセスすると、favicon に時を表示する。

- [hour](https://kLabz.github.io/elm-favicon-clock/#hour)

下記 URL にアクセスすると、favicon に分を表示する。

- [min](https://kLabz.github.io/elm-favicon-clock/#min)

以下は `22:52` の例。

![22:52](https://taiju.github.io/elm-favicon-clock/artwork/artwork.png)

## ビルド

```sh
$ elm-make FaviconClock.elm --output=favicon-clock.js
```

## 作った動機

Google Chrome のタブ固定機能で固定したタブで時間が確認できると、ブラウザフルスクリーン作業時に捗るかなと思っ
たのと、Elm で何か書いて見たかったのとが重なったので書いた。

## 反省点

favicon の更新みたいなことは Elm 向きではなかった。

## 制限事項

おおよそ何時何分を把握することは問題ないが、秒単位での精度が高くない。
