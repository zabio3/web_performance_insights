nwdiag, seqdiag
===

ネットワーク図、シーケンス図を生成してくれるツール

### ネットワーク図生成 (nwdiag)

一度、SVGに吐き出してから、PNGに変換した方が綺麗になるため

##### install 

```
pip install nwdiag
```

###### SVGへ変換

```
nwdiag -Tsvg configuration_diagram.nwdiag 
```

###### PNGへ変換

```
qlmanage -t -s 1000 -o . configuration_diagram.svg 
```

## シーケンス図の生成 (seqdiag)

##### install 

```
pip install seqdiag
```

###### SVGへ変換

```
seqdiag -Tsvg first_cache.seqdiag 
```

###### PNGへ変換

```
qlmanage -t -s 1000 -o . first_cache.seqdiag.svg 
```

## 参考

 - [ネットワーク図生成ツール nwdiag](http://blockdiag.com/ja/nwdiag/index.html)
 - [WebUI](https://github.com/dataich/LiveDiag)