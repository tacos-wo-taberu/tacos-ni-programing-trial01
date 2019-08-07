# M sequence generator

[byte]$x = 128  #8bit Registerの準備・初期化
[byte]$y = 0  #多項式生成用のシフトレジスタの準備
[byte]$z = 0  #exor　加算用
$d = @(0,0,0,0,0,0,0,0) #ディスプレイ用
 
for( $i =0 ; $i -le 256; $i++ ) {

  $y = $x
  for($j =0 ; $j -le 7; $j++) { $d[7-$j] = $y % 2 ; $y = $y -shr 1 }
  Write-Host $i : $d :$x

# [8,6,5,3]

  $y = $x -shr 2 ; $z = $x -bxor $y  # yは多項式演算用、2つシフトしてるのでX^^6
  $y = $y -shr 1 ; $z = $z -bxor $y  # X^^5
  $y = $y -shr 2 ; $z = $z -bxor $y  # X^^3
  $z = $z % 2      # xor計算用zの0bitだけを有効化
  $z = $z * 128    #zの0bitを7bit目に移動

  $x = $x -shr 1    # xを右に一つシフト
  $x = $x -band [byte]127  # xの7bitを0にする
  $x = $x -bor $z      # xの7bitにｙの値を入れる
  
}