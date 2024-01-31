# setup `clangd`

```sh
 rm -r ./bin
 ./configure.developer
 bear -- make -j$(($(nproc) - 1))
```
