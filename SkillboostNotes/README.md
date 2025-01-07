In order to make this "skillboostnotes" terraform program to work:

- Terraform init

- Terraform plan
    - var.instance_name: myinstance (or other name depending on the need)
    - var.instance_zone: us-east4-c (or other zone depending on the need)

- Terraform apply
    - var.instance_name: myinstance (or other name, depending on the previous chosen name)
    - var.instance_zone: us-east4-c (or other zone, depending on the previous chosen zone)


To vizualize the dependencies of the terraform resources run:
    - terraform graph | dot -Tpng > graph.png