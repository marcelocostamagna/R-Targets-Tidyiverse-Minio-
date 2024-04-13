# Targets | Rstudio | Minio | Docker  

**This version works with containerized Rstudio**

In order to run and interact with the environment, a couple of helpers are available in the form of a `Makefile`.

- `down`: stop and remove docker compose services, including volumes
- `up`: start docker compose services in detached mode
- `top`: start a `ctop` to view deployed containers
- `logs`: tails logs from stack containers
- `clean-bucket`: remove `./minio_storage/targets-versioned` bucket form minio

1. Build services
```bash
make build
```

2. Launch services

```bash
make up
```
Note: Delete `minio_storage/.minio.sys` when changing minio docker tag

3. Access `Rstudio` UI `http://localhost:8787/`

4. In R console run below code
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

7. Check result metrics
```R
targets::tar_read(metrics)
```

### Utils
```bash
sudo chown rstudio:rstudio /home/rstudio/.config/rstudio/rstudio-prefs.json 
```

```R
targets::tar_meta(<target>, path)$path   
targets::tar_destroy()
```