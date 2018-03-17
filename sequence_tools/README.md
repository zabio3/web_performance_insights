nwdiag, seqdiag
===

Tools for generating network diagrams and sequence diagrams.

### Network Diagram Generation (nwdiag)

Export to SVG first, then convert to PNG for better quality.

##### Install

```
pip install nwdiag
```

###### Convert to SVG

```
nwdiag -Tsvg configuration_diagram.nwdiag
```

###### Convert to PNG

```
qlmanage -t -s 1000 -o . configuration_diagram.svg
```

## Sequence Diagram Generation (seqdiag)

##### Install

```
pip install seqdiag
```

###### Convert to SVG

```
seqdiag -Tsvg first_cache.seqdiag
```

###### Convert to PNG

```
qlmanage -t -s 1000 -o . first_cache.seqdiag.svg
```

## References

 - [Network diagram tool nwdiag](http://blockdiag.com/ja/nwdiag/index.html)
 - [WebUI](https://github.com/dataich/LiveDiag)
