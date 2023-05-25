# R Template

This is the template for studies mainly with R code.

# Instructions

1. Copy the template to `cases`, e.g. `cases/36` and change to that directory

```bash
cp -r ../r ../../cases/36
cd ../../cases/36
```

2. Edit the following files

* `get_material.r`: how to obtain the reproducible material
* `make.sh`: how to batch execute the reproducible material

3. Execute

```r
docker compose up --build
```

4. Do postmortem in `output`

# Postmortem

1. Code this study as `Executable:1` if `docker compose up --build` works; `Executable:0` otherwise.
