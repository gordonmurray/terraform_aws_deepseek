# terraform_aws_deepseek

A terraform project to create an EC2 instance running Deepseek R1

Using the approach from this guide: https://community.aws/content/2sEuHQlpyIFSwCkzmx585JckSgN/deploying-deepseek-r1-14b-on-amazon-ec2

![Ollama AI](images/ollama.png)


## Estimated cost

```
 Name                                                    Monthly Qty  Unit   Monthly Cost

 aws_instance.deepseek_r1
 ├─ Instance usage (Linux/UNIX, on-demand, g4dn.xlarge)          730  hours       $428.51
 └─ root_block_device
    └─ Storage (general purpose SSD, gp3)                        100  GB            $8.80

 OVERALL TOTAL                                                                   $437.31

*Usage costs can be estimated by updating Infracost Cloud settings, see docs for other options.

──────────────────────────────────
16 cloud resources were detected:
∙ 1 was estimated
∙ 15 were free

┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━┳━━━━━━━━━━━━┓
┃ Project                                            ┃ Baseline cost ┃ Usage cost* ┃ Total cost ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━╋━━━━━━━━━━━━┫
┃ main                                               ┃          $437 ┃           - ┃       $437 ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━┛
```

## Tfsec

```
  results
  ──────────────────────────────────────────
  passed               5
  ignored              0
  critical             3
  high                 2
  medium               1
  low                  3

  5 passed, 9 potential problem(s) detected.
  ```