Verification Notes
===

## Analysis

Parse network response headers with Go
 - Parse only target FQDN
 - What is consuming time? (DNS lookup, render blocking check)
 - Cache (etag, cache-control, expire duration)
 - gzip, zopfli (more efficient than deflate)
 - js, css minification
 - Image optimization check
 - Check for document.write usage
 - etc.

## Content Compression

 - [Brotli caching with ngx_brotli](https://github.com/google/ngx_brotli)
    - Don't forget to add Vary header
    - Compare with zstandard
 - gzip static (for zopfli)
    - Cache on dedicated cache server
 - Check if image/jpeg is compressed to tune performance

## Proxy/Cache Server

 - [H2O - an optimized HTTP server with support for HTTP/1.x and HTTP/2](https://github.com/h2o/h2o/)
    - Reportedly 6x faster than nginx (used by Fastly)

## References

 - [psi](https://github.com/addyosmani/psi)
    - Command-line tool for PageSpeed Insights measurement
