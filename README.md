# terraform_aws_deepseek

A terraform project to create an EC2 instance running Deepseek R1

Using the approach from this guide: https://community.aws/content/2sEuHQlpyIFSwCkzmx585JckSgN/deploying-deepseek-r1-14b-on-amazon-ec2


## Estimated cost

```
 Name                                                       Monthly Qty  Unit              Monthly Cost

 aws_instance.deepseek_r1
 ├─ Instance usage (Linux/UNIX, on-demand, g4dn.xlarge)             730  hours                  $428.51
 └─ root_block_device
    └─ Storage (general purpose SSD, gp3)                           100  GB                       $8.80

 aws_nat_gateway.main
 ├─ NAT gateway                                                     730  hours                   $35.04
 └─ Data processed                                       Monthly cost depends on usage: $0.048 per GB

 aws_lb.deepseek_alb
 ├─ Application load balancer                                       730  hours                   $18.40
 └─ Load balancer capacity units                         Monthly cost depends on usage: $5.84 per LCU

 OVERALL TOTAL                                                                                 $490.75

*Usage costs can be estimated by updating Infracost Cloud settings, see docs for other options.

──────────────────────────────────
31 cloud resources were detected:
∙ 3 were estimated
∙ 28 were free

┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━┳━━━━━━━━━━━━┓
┃ Project                                            ┃ Baseline cost ┃ Usage cost* ┃ Total cost ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━╋━━━━━━━━━━━━┫
┃ main                                               ┃          $491 ┃           - ┃       $491 ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━┛
```

## Tfsec

```
  results
  ──────────────────────────────────────────
  passed               13
  ignored              0
  critical             5
  high                 4
  medium               0
  low                  4

  13 passed, 13 potential problem(s) detected.
  ```