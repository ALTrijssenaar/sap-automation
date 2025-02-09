variable "application" {
  validation {
    condition = (
      length(trimspace(try(var.application.sid, ""))) != 0
    )
    error_message = "The sid must be specified in the application.sid field."
  }

}
variable "databases" {
  validation {
    condition = (
      length(trimspace(try(var.databases[0].platform, ""))) != 7
    )
    error_message = "The platform (HANA, SQLSERVER, ORACLE, DB2) must be specified in the databases block."
  }

  validation {
    condition = (
      length(trimspace(try(var.databases[0].db_sizing_key, ""))) != 0
    )
    error_message = "The db_sizing_key must be specified in the databases block."
  }
}
variable "infrastructure" {
  validation {
    condition = (
      length(trimspace(try(var.infrastructure.region, ""))) != 0
    )
    error_message = "The region must be specified in the infrastructure.region field."
  }

  validation {
    condition = (
      length(trimspace(try(var.infrastructure.environment, ""))) != 0
    )
    error_message = "The environment must be specified in the infrastructure.environment field."
  }

  validation {
    condition = (
      length(trimspace(try(var.infrastructure.vnets.sap.logical_name, ""))) != 0
    )
    error_message = "Please specify the logical VNet identifier in the network_logical_name field. For deployments prior to version '2.3.3.1' please use the identifier 'sap'."
  }

  validation {
    condition = (
      contains(keys(var.infrastructure.vnets.sap), "subnet_admin") ? (
        var.infrastructure.vnets.sap.subnet_admin != null ? (
          length(trimspace(try(var.infrastructure.vnets.sap.subnet_admin.arm_id, ""))) != 0 || length(trimspace(try(var.infrastructure.vnets.sap.subnet_admin.prefix, ""))) != 0) : (
          true
        )) : (
        true
      )
    )
    error_message = "Either the arm_id or prefix of the Admin subnet must be specified in the infrastructure.vnets.sap.subnet_admin block."
  }

  validation {
    condition = (
      contains(keys(var.infrastructure.vnets.sap), "subnet_app") ? (
        var.infrastructure.vnets.sap.subnet_app != null ? (
          length(trimspace(try(var.infrastructure.vnets.sap.subnet_app.arm_id, ""))) != 0 || length(trimspace(try(var.infrastructure.vnets.sap.subnet_app.prefix, ""))) != 0) : (
          true
        )) : (
        true
      )
    )
    error_message = "Either the arm_id or prefix of the Application subnet must be specified in the infrastructure.vnets.sap.subnet_app block."
  }

  validation {
    condition = (
      contains(keys(var.infrastructure.vnets.sap), "subnet_db") ? (
        var.infrastructure.vnets.sap.subnet_db != null ? (
          length(trimspace(try(var.infrastructure.vnets.sap.subnet_db.arm_id, ""))) != 0 || length(trimspace(try(var.infrastructure.vnets.sap.subnet_db.prefix, ""))) != 0) : (
          true
        )) : (
        true
      )
    )
    error_message = "Either the arm_id or prefix of the Database subnet must be specified in the infrastructure.vnets.sap.subnet_db block."
  }

}

variable "options" {}
variable "authentication" {}
variable "key_vault" {
  validation {
    condition = (
      contains(keys(var.key_vault), "kv_spn_id") ? (
        length(var.key_vault.kv_spn_id) > 0 ? (
          length(split("/", var.key_vault.kv_spn_id)) == 9) : (
          true
        )) : (
        true
      )
    )
    error_message = "If specified, the kv_spn_id needs to be a correctly formed Azure resource ID."
  }
  validation {
    condition = (
      contains(keys(var.key_vault), "kv_user_id") ? (
        length(var.key_vault.kv_user_id) > 0 ? (
          length(split("/", var.key_vault.kv_user_id)) == 9) : (
          true
        )) : (
        true
      )
    )
    error_message = "If specified, the kv_user_id needs to be a correctly formed Azure resource ID."
  }
}


variable "ha_validator" {
  validation {
    condition = (
      parseint(split("-", var.ha_validator)[0], 10) != 0 ? upper(split("-", var.ha_validator)[1]) != "NONE" : true
    )
    error_message = "An NFS provider must be specified using the NFS_provider variable in a HA scenario."
  }
}

variable "custom_prefix" {
  description = "Custom prefix"
  type        = string
  default     = ""
}

variable "is_single_node_hana" {
  description = "Checks if single node hana architecture scenario is being deployed"
  default     = false
}

variable "deployer_tfstate" {
  description = "Deployer remote tfstate file"
}

variable "landscape_tfstate" {
  description = "Landscape remote tfstate file"
}

variable "service_principal" {
  description = "Current service principal used to authenticate to Azure"
}

/* Comment out code with users.object_id for the time being
variable "deployer_user" {
  description = "Details of the users"
  default     = []
}
*/

variable "naming" {
  description = "Defines the names for the resources"
}

variable "custom_disk_sizes_filename" {
  type        = string
  description = "Disk size json file"
  default     = ""
}

variable "deployment" {
  description = "The type of deployment"
}

variable "terraform_template_version" {
  description = "The version of Terraform templates that were identified in the state file"
}

variable "license_type" {
  description = "Specifies the license type for the OS"
  default     = ""
}

variable "enable_purge_control_for_keyvaults" {
  description = "Allow the deployment to control the purge protection"
}

variable "sapmnt_volume_size" {
  description = "The volume size in GB for sapmnt"
}

variable "NFS_provider" {
  type    = string
  default = "NONE"
}

variable "azure_files_sapmnt_id" {
  type    = string
  default = ""
}

variable "Agent_IP" {
  type    = string
  default = ""
}

variable "use_private_endpoint" {
  default = false
}

variable "azurerm_private_endpoint_connection_sapmnt_id" {
  description = "Azure Resource Identifier for an private endpoint connection"
  type        = string
  default = ""
}

variable "hana_dual_nics" {
  description = "value to indicate if dual nics are used for HANA"
}

variable "hana_ANF_volumes" {
  description = "Defines HANA ANF  volumes"
}

variable "deploy_application_security_groups" {
  description = "Defines if application security groups should be deployed"
}
