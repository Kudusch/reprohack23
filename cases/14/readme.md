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
* `make.sh`: how to batch execute the reproducible material; make sure that the code doesn't change the source code in the reproducible material for the first run

3. Execute

```r
docker compose up --build
```

4. Do postmortem in `output`. Refer to the postmortem guide.
