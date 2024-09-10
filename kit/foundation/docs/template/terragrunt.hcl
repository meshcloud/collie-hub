terraform {
  source = "${get_repo_root()}//kit/foundation/docs"
}

# note: we don't track any state for this module itself

inputs = {
  template_dir  = "${get_repo_root()}/foundations/meshcloud-dev/docs/template"
  output_dir    = "${get_repo_root()}/foundations/meshcloud-dev/.docs-v2"
  platforms_dir = "${get_repo_root()}/foundations/meshcloud-dev/platforms"
}