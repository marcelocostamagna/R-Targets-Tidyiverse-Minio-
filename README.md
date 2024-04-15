# Targets | Tidymodels | Minio | Rstudio | Docker 

## Overview
This project is and e2e pipeline for estimating `cupper points` outcome from the [coffee ratings dataset](https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-07-07/coffee_ratings.csv).

[Tidymodels](https://www.tidymodels.org/) package is used for preprocessing (recipes) and modeling using random forest.

[Targets](https://github.com/ropensci/targets) R package coordinates the steps execution, `code/_targets.R` code contains all the steps from data gathering to model metrics

[Minio](https://github.com/minio/minio) is used as a versioned object storage for saving Targets pipeline status

## Runnin the pipeline
In order to run and interact with the environment, a couple of helpers are available in the form of a `Makefile`.

1. Build services
```bash
make build
```

2. Launch services
```bash
make up
```

3. Access `Rstudio` UI `http://localhost:8787/`

4. In R console run below code for setting envronment variables
```R
 Sys.setenv(
   AWS_ACCESS_KEY_ID = "minio",
   AWS_SECRET_ACCESS_KEY = "minio123",
   AWS_REGION = "us-east-1"
 )
```

5. Run Targets
```R
targets::tar_make()
```

6. Access Minio GUI `http://localhost:9009/`  USR: **minio** PASS: **minio123**

Versioned objects are stored under **targets-versioned/tarpref/objects** prefix

7. Check predictions metrics
```R
targets::tar_read(metrics)
```

8. Other useful commands 
```bash
# Stop and remove docker compose services, including volumes
make down

# Start a `ctop` to view deployed containers
make top

# Tails logs from stack containers
make logs: 

# Remove `./minio/targets-versioned` bucket in minio
make clean-bucket 
```

Note: Delete `minio/.minio.sys` when changing minio docker tag

### Utils
```bash
sudo chown rstudio:rstudio /home/rstudio/.config/rstudio/rstudio-prefs.json 
```

```R
targets::tar_meta(<target>, path)$path   
targets::tar_destroy()
```