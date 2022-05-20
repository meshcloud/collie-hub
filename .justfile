fmt:
    terraform fmt -recursive kit/
    terragrunt hclfmt

cfmm:
    cd compliance/cfmm && deno run --allow-read --allow-write --allow-net update.ts

default:
  just --list