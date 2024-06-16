# Sample Fullstack Application

This repo creates two Github Actions CI Workflows:  
| Name | Purpose |Trigger|
|---|---|---|
|`.github/workflows/dev.yml`| Runs CI Tests(Integration) Pushes a Developer Build to the Github Container Repository.|`push`, `pull_request` or manually triggered on main branch |
|`.github/workflows/dev.yml`| Build a Release Docker Image |when a **version tag** (Semver `v.*.*` ) is pushed or **manually triggered** on main branch|

## Accomplished Tasks
- Separate docker overrides for different environments
- Added support for Integration Tests
- Tags pushed 
  - `latest` : For latest stable build
  - `dev`: For latest developer build
- Eliminated need for specifying **Github PAT (Personal Access Token)** by utilising **GITHUB_TOKEN** secret.
- Hardened Docker Images
- Ready for **CD** (Continuous Deployment)

## TODO
- Add support for **Trunk Based Development** or **Release Branches**
- Refactor tests

## How to run on local
### Running on local
- Run the following commands
    ```
    docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d
    ```  
- Now you can access the app at `http://localhost:3000/`  
- You can fine tune the following parameters using environment variables before running the docker compose build.  
    |Name|Purpose|Default Value|
    |----|-------|-------------|
    |`NEXT_PUBLIC_BACKEND_BASE_URL`| Deployed `URL` of backend service. **_IMP: This variable cannot be changed during runtime. It is used at build time by NEXT for its build tool_** | `http://localhost:8000/`|
    |`PG_USER`| Postgres User| `pguser`|
    |`PG_PASSWORD`|Postgres User Password| `Secret`|
    |`IMAGE_TAG`|Image Tag to build|`latest`|

### Running Tests
I have configured tests via the docker compose overlay `docker-compose.tests.yml`<br/>
```
chmod +x run_tests.sh && ./run_tests.sh
```