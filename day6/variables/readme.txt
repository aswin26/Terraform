## Variables and outputs

 - terraform.tfvars
 - <fileName>.tfvars
 - <fileName>.auto.tfvars
 - command for <fileName>.tfvars --> terraform plan -var-file = <fileName>.tfvars
 - run time Variable declaration --> terraform plan -var=<VariableName>=<value>


 Hierarchy
 --------

 enivornmental Variables  --> tfvars --> *.auto.tfvars --> -var/-var-file


 outputs
 -------

 - outputs CLI --> terraform output/ terraform output <var_name> / terraform output -json