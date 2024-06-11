terraform {
   required_providers {
      sbercloud = {
         source  = "sbercloud-terraform/sbercloud" # Initialize Cloud.ru provider
      }
   }
}

# Configure Cloud.ru provider
provider "sbercloud" {
   auth_url = "https://iam.ru-moscow-1.hc.sbercloud.ru/v3" # Authorization address
   region   = "ru-moscow-1" # The region where the cloud infrastructure will be deployed

   # Authorization keys
   access_key = var.access_key
   secret_key = var.secret_key
}
resource "sbercloud_identity_user" "obs_user" {
   name        = "OBS_User"
   description = "OBS user created by terraform"
}

resource "sbercloud_identity_group" "obs_admin_group" {
   name        = "obs_admin_group"
}

resource "sbercloud_identity_group_membership" "obs_group_membership" {
   group = sbercloud_identity_group.obs_admin_group.id
   users = [
   sbercloud_identity_user. obs_user.id
   ]
}
resource "sbercloud_identity_role" "obs_admin_role" {
   name        = "OBS_Admin"
   description = "created by terraform"
   type        = "AX"
   policy      = <<EOF
   {
       "Version": "1.1",
       "Statement": [
           {
               "Action": [
                   "obs:*:*"
               ],
               "Effect": "Allow"
           }
       ]
   }
   EOF
}

resource "sbercloud_enterprise_project" "ep_obs_bucket" {
   name        = "obs_bucket"
}

resource "sbercloud_identity_role_assignment" "obs_role_assign" {
   group_id              = sbercloud_identity_group.obs_admin_group.id
   role_id               = sbercloud_identity_role.obs_admin_role.id
   enterprise_project_id = sbercloud_enterprise_project.ep_obs_bucket.id
}

resource "sbercloud_obs_bucket" "obs_bucket" {
   bucket = "my-tf-test-bucket"
   acl    = "private"
   enterprise_project_id = sbercloud_enterprise_project.ep_obs_bucket.id
}
