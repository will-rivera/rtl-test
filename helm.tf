resource "helm_release" "rlt-test" {
  name  = "rlt-test"
  chart = "charts/rlt-test"
}
