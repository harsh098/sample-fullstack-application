# Sample Fullstack Application

This repo creates two Github Actions CI Pipelines:  
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
Run the following commands
```docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d```  
Now you can access the app at `http://localhost:3000/`

### Running Tests
```chmod +x run_tests.sh && ./run_tests.sh```
