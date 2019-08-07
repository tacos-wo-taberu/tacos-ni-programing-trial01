
# M sequence generator
#
x = 128  #8bit Registerの準備・初期化
y = 0  #多項式生成用のシフトレジスタの準備
z = 0  #exor　加算用
d = [0,0,0,0,0,0,0,1] #ディスプレイ用

for i in range(256) :
  y = x
  for j in range(8) : #表示用
    d[7-j] = y % 2
    y = y >> 1
  print(d,x)

  #polynominal [8,6,5,3]

  y = x >> 2  #yは多項式演算用、x^^6 を　一番右の0ビットに
  z = x ^ y   #zに　一番右ビット　に　x xor y
  y = y >> 1  # x^^5
  z = z ^ y
  y = y >> 2  # x^^3
  z = z ^ y
  
  z = z % 2   # z の　0bitのみを有効化

  z = z * 128 # z の　0bitを7bit目に移動

  x = x >> 1  # x を右に１つシフト、主たる漸化式の実行

  x = x % 128 # 0bit-6bitをマスク　7bitを０に
  x = x | z   # 7bit に　xor(加算)　の結果

  # ループ終わり