# パラメタの設定
par(family = "HiraKakuProN-W3")
# サンプルサイズ
N <- 500

# 観測誤差の標準偏差
observationErrorSD <- 20

# 過程誤差の標準偏差
processErrorSD <- 10

# 係数の過程誤差の標準偏差
coefErrorSD <- 0.5

# 各種シミュレーションデータの生成

# 説明変数をシミュレーションで作る
set.seed(1)
explanatory <- rnorm(n=N, mean=10, sd=10)

# 各種シミュレーションデータの作成

# slopeのシミュレーション
set.seed(12)
slope <- cumsum(rnorm(n=N, mean=0, sd=coefErrorSD)) + 10

plot(slope, main="時間によるslopeの変化", xlab="day")

# 各種シミュレーションデータの作成

# interceptのシミュレーション
set.seed(3)
intercept <- cumsum(rnorm(n=N, mean=0, sd=processErrorSD))

plot(intercept, main="時間によるinterceptの変化", xlab="day")

# 各種シミュレーションデータの作成

# responseのシミュレーション
set.seed(4)
response <- intercept + explanatory*slope + rnorm(n=N, mean=0, sd=observationErrorSD)

plot(response, main="responseのシミュレーション結果", xlab="day")


