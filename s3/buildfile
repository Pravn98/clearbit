.PHONY: clean init plan apply
###  wget required/missing plugin as needed - https://releases.hashicorp.com/
### 	terraform init -input=false -plugin-dir=/usr/local/lib/terraform3.6
init:
	terraform init -input=false
clean:
	rm -rf .terraform
	rm tfplan.out
%:
	terraform workspace select $@
	terraform plan -input=false
%-apply:
	terraform workspace select $(*)
	terraform apply -input=false -auto-approve
plan: init
	@$(MAKE) $(foreach env,$(ENVS), $(env))
apply: init
	@$(MAKE) $(foreach env,$(ENVS), $(env)-apply)
bootstrap: init
	$(foreach env,$(ENVS), terraform workspace new $(env);)
##################
