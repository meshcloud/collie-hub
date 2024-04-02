output "documentation_md" {
  value = <<EOF
# Building Block - Subscription Budget Alert

The Budget Alert Building block configures a simple monthly budget alert for subscriptions.
We highly recommend (and for some landing zones enforce) that application teams set up an alert as a simple
mechanism to prevent unintentional cost overruns.

We encourage application teams to deploy additional alerts with fine-grained notification rules according to the
specific needs of their application and infrastructure.
EOF
}
